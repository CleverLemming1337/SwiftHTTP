//
//  HTTPResponse.swift
//  SwiftHTTP
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation

public struct HTTPResponse {
    let status: Int
    
    let headers: [String: String]
    
    let httpVersion: String
    
    let body: String
    
    var httpText: String {
        """
        HTTP/\(httpVersion) \(status)\r
        \(headers.map { key, value in "\(key): \(value)" }.joined(separator: "\r\n"))\r
        \r
        \(body)
        """ // TODO: Ensure \n has leading \r
    }
    
    public init(status: Int = .httpOK, headers: [String: String] = [:], httpVersion: String = "1.1", _ body: String) {
        self.status = status
        self.httpVersion = httpVersion
        self.body = body
        
        var newHeaders = headers
        if !headers.keys.contains("Content-Length") {
            newHeaders["Content-Length"] = "\(body.utf8.count)"
        }
        
        self.headers = newHeaders
    }
    
    public func removingBody() -> HTTPResponse {
        return HTTPResponse(status: status, headers: headers, httpVersion: httpVersion, "")
    }
}

public struct HTTPHeader {
    let name: String
    let value: String
    
    var string: String {
        "\(name): \(value)"
    }
}
