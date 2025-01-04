//
//  ServerConnection.swift
//  SwiftHTTP
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation
import Network

public class HTTPServer {
    public let port: NWEndpoint.Port
    public let listener: NWListener
    
    public let handleRequest: (HTTPRequest, String) -> HTTPResponse

    private var connectionsByID: [Int: ServerConnection] = [:]

    public init(port: UInt16, handleRequest: @escaping (HTTPRequest, String) -> HTTPResponse) {
        self.port = NWEndpoint.Port(rawValue: port)!
        self.handleRequest = handleRequest
        listener = try! NWListener(using: .tcp, on: self.port)
    }

    public func start() throws {
        print("Server starting...")
        listener.stateUpdateHandler = self.stateDidChange(to:)
        listener.newConnectionHandler = self.didAccept(nwConnection:)
        listener.start(queue: .main)
    }

    public func stateDidChange(to newState: NWListener.State) {
        switch newState {
        case .ready:
          print("Server listening on port \(port)")
        case .failed(let error):
            print("Server failure, error: \(error.localizedDescription)")
            exit(EXIT_FAILURE)
        default:
            break
        }
    }

    private func didAccept(nwConnection: NWConnection) {
        let connection = ServerConnection(nwConnection: nwConnection)
        self.connectionsByID[connection.id] = connection
        connection.didStopCallback = { _ in
            self.connectionDidStop(connection)
        }
        
        connection.start(with: handleRequest)
        
        print("Server did open connection #\(connection.id)")
    }


    private func connectionDidStop(_ connection: ServerConnection) {
        self.connectionsByID.removeValue(forKey: connection.id)
        print("Server did close connection #\(connection.id)")
    }

    private func stop() {
        self.listener.stateUpdateHandler = nil
        self.listener.newConnectionHandler = nil
        self.listener.cancel()
        for connection in self.connectionsByID.values {
            connection.didStopCallback = nil
            connection.stop()
        }
        self.connectionsByID.removeAll()
    }
}


public class ServerConnection {
    //The TCP maximum package size is 64K 65536
    public let MTU = 65536

    private static var nextID: Int = 0
    public let  connection: NWConnection
    public let id: Int
    public var data: String? = nil

    public init(nwConnection: NWConnection) {
        connection = nwConnection
        id = ServerConnection.nextID
        ServerConnection.nextID += 1
    }

    public var didStopCallback: ((Error?) -> Void)? = nil

    public func start(with handleReceive: @escaping (HTTPRequest, String) -> HTTPResponse) {
        connection.stateUpdateHandler = self.stateDidChange(to:)
        setupReceive(with: handleReceive)
        connection.start(queue: .main)
    }

    private func stateDidChange(to state: NWConnection.State) {
        switch state {
        case .waiting(let error):
            connectionDidFail(error: error)
        case .ready:
            print("Connection #\(id) ready")
        case .failed(let error):
            connectionDidFail(error: error)
        default:
            break
        }
    }

    private func setupReceive(with handleRequest: @escaping (HTTPRequest, String) -> HTTPResponse) {
        connection.receive(minimumIncompleteLength: 1, maximumLength: MTU) { (data, _, isComplete, error) in
            if let data = data, !data.isEmpty {
                // Konvertiere die empfangenen Daten in einen String (oder analysiere sie anders)
                if let message = String(data: data, encoding: .utf8) {
                    if let request = parseHTTPRequestText(message) {
                        print("> \(request.method.rawValue) \(request.path) HTTP/\(request.httpVersion)")
                        let response = handleRequest(request, request.path)
                        print("< \(response.status)")
                        
                        self.send(data: response.httpText.data(using: .utf8)!)
                    }
                    
                    // HTTP text couldn't be parsed
                    self.send(data: HTTPResponse(status: .httpUnprocessableEntity, "Invalid HTTP data").httpText.data(using: .utf8)!)
                    
                }
            }
            
            if isComplete {
                self.connectionDidEnd()
            } else if let error = error {
                self.connectionDidFail(error: error)
            } else {
                self.setupReceive(with: handleRequest) // Warten auf mehr Daten
            }
        }
    }



    public func send(data: Data) {
        self.connection.send(content: data, completion: .contentProcessed( { error in
            if let error = error {
                self.connectionDidFail(error: error)
                return
            }
        }))
    }

    public func stop() {
        print("Connection #\(id) will stop")
    }



    private func connectionDidFail(error: Error) {
        print("Connection #\(id) did fail, error: \(error)")
        stop(error: error)
    }

    private func connectionDidEnd() {
        print("Connection #\(id) did end")
        stop(error: nil)
    }

    private func stop(error: Error?) {
        connection.stateUpdateHandler = nil
        connection.cancel()
        if let didStopCallback = didStopCallback {
            self.didStopCallback = nil
            didStopCallback(error)
        }
    }
}
