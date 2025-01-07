//
//  HTTPResponse.swift
//  SwiftHTTP
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation

public typealias Response = HTTPResponse

public struct HTTPResponse {
    let status: Int
    
    let headers: [String: String]
    
    let body: String
    
    var httpText: String {
        """
        HTTP/1.1 \(status)\r
        \(headers.map { key, value in "\(key): \(value)" }.joined(separator: "\r\n"))\r
        \r
        \(body)
        """ // TODO: Ensure \n has leading \r
    }
    
    public init(status: Int = .httpOK, headers: [String: String] = [:], _ body: String) {
        self.status = status
        self.body = body
        
        var newHeaders = headers
        if !headers.keys.contains("Content-Length") {
            newHeaders["Content-Length"] = "\(body.utf8.count)"
        }
        
        self.headers = newHeaders
    }
}

public struct HTTPHeader {
    let name: String
    let value: String
    
    var string: String {
        "\(name): \(value)"
    }
}
