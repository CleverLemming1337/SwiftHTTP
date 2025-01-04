//
//  HTTPRequest.swift
//  SwiftHTTP
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation

public struct HTTPRequest {
    let method: HTTPMethod
    
    let headers: [String: String]
    
    let httpVersion: String
    
    let body: String
    
    let path: String
    
    var httpText: String {
        """
        \(method.rawValue) HTTP/\(httpVersion)\r
        \(headers.map { key, value in "\(key): \(value)" }.joined(separator: "\r\n"))\r
        \r
        \(body)
        """ // TODO: Ensure \n has leading \r
    }
    
    public init(_ path: String, method: HTTPMethod = .get, headers: [String: String], httpVersion: String = "1.1", body: String) {
        self.path = path
        self.method = method
        self.httpVersion = httpVersion
        self.body = body
        self.headers = headers
    }
}

public func parseHTTPRequestText(_ text: String) -> HTTPRequest? {
    // Zerlege die Eingabe in Header und Body
    let parts = text.split(separator: "\r\n\r\n", maxSplits: 1, omittingEmptySubsequences: false)
    guard parts.count >= 1 else { return nil }
    
    let headerPart = String(parts[0])
    let bodyPart = parts.count > 1 ? String(parts[1]) : ""

    // Zerlege die Header in Zeilen
    var lines = headerPart.split(separator: "\r\n", omittingEmptySubsequences: true).map(String.init)
    guard let requestLine = lines.first else { return nil }
    lines.removeFirst() // Entferne die Statuszeile

    // Analysiere die Statuszeile
    let requestLineParts = requestLine.split(separator: " ", maxSplits: 2)
    guard requestLineParts.count == 3,
          let method = HTTPMethod(rawValue: String(requestLineParts[0])),
          let httpVersion = requestLineParts.last?.split(separator: "/").last else {
        return nil
    }
    let path = String(requestLineParts[1])

    // Analysiere die Header
    var headers: [String: String] = [:]
    for line in lines {
        let headerParts = line.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true)
        guard headerParts.count == 2 else { continue }
        let key = headerParts[0].trimmingCharacters(in: .whitespaces)
        let value = headerParts[1].trimmingCharacters(in: .whitespaces)
        headers[key] = value
    }

    // Erstelle und gib die HTTPRequest-Instanz zurück
    return HTTPRequest(path, method: method, headers: headers, httpVersion: String(httpVersion), body: bodyPart)
}
