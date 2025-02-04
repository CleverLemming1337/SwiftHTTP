//
//  HTTPRequest.swift
//  SwiftHTTP
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation

public struct HTTPRequest {
    public let method: HTTPMethod
    
    public let headers: [String: String]
    
    public let body: String
    
    public let path: String
    
    public var httpText: String {
        """
        \(method.rawValue) HTTP/1.1\r
        \(headers.map { key, value in "\(key): \(value)" }.joined(separator: "\r\n"))\r
        \r
        \(body)
        """ // TODO: Ensure \n has leading \r
    }
    
    public init(_ path: String, method: HTTPMethod = .get, headers: [String: String], body: String) {
        self.path = path
        self.method = method
        self.body = body
        self.headers = headers
    }
    
    public var formData: [String: String]? {
        if headers["Content-Type"] != "application/x-www-form-urlencoded" {
            return nil
        }
        var result = [String: String]()
        
        for payload in body.split(separator: "&") {
            let pair = payload.split(separator: "=")
            if pair.count == 1 {
                result[String(pair[0])] = ""
                continue
            }
            guard pair.count == 2 else { return nil }
            result[String(pair[0])] = String(pair[1])
        }
        
        return result
    }
}

public func parseHTTPRequestText(_ text: String) -> HTTPRequest? {
    let parts = text.split(separator: "\r\n\r\n", maxSplits: 1, omittingEmptySubsequences: false)
    guard parts.count >= 1 else { return nil }
    
    let headerPart = String(parts[0])
    let bodyPart = parts.count > 1 ? String(parts[1]) : ""
    
    var lines = headerPart.split(separator: "\r\n", omittingEmptySubsequences: true).map(String.init)
    guard let requestLine = lines.first else { return nil }
    lines.removeFirst()
    
    let requestLineParts = requestLine.split(separator: " ", maxSplits: 2)
    guard requestLineParts.count == 3,
          let method = HTTPMethod(rawValue: String(requestLineParts[0])), // TODO: Returning `nil` is currently handled outside and sends `422 Unprocessable Entity`, an unknown method should send `405 Method Not Allowed`
          let httpVersion = requestLineParts.last?.split(separator: "/").last else {
        return nil
    }
    let path = String(requestLineParts[1])

    var headers: [String: String] = [:]
    for line in lines {
        let headerParts = line.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true)
        guard headerParts.count == 2 else { continue }
        let key = headerParts[0].trimmingCharacters(in: .whitespaces)
        let value = headerParts[1].trimmingCharacters(in: .whitespaces)
        headers[key] = value
    }

    return HTTPRequest(path, method: method, headers: headers, body: bodyPart)
}
