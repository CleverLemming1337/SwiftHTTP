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
        HTTP/\(httpVersion) \("\(method)".uppercased())\r
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
