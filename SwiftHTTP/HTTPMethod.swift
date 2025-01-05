//
//  HTTPMethod.swift
//  SwiftHTTP
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    case head = "HEAD"
    case options = "OPTIONS"
}

public func httpMethodFormatted(_ method: HTTPMethod) -> String {
    var color = "9" // white
    switch method {
    case .get:
        color = "2" // green
    case .post:
        color = "3" // yellow
    case .put:
        color = "4" // blue
    case .delete:
        color = "1" // red
    case .patch:
        color = "6" // cyan
    case .head:
        color = "2" // green
    case .options:
        color = "5" // magenta
    }
    
    return "\u{1b}[9\(color);1m\(method.rawValue)\u{1b}[0m"
}
