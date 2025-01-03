//
//  HTTPMethod.swift
//  SwiftHTTP
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation

public enum HTTPMethod {
    case get
    case post
    case put
    case patch
    case delete
    case trace
    case other(method: String)
}
