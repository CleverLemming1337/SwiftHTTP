//
//  HTTPStatusCode.swift
//  SwiftHTTP
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation

public extension Int {
    static let httpOK = 200
    static let httpNotFound = 404
    static let httpMethodNotAllowed = 405
    static let httpTeapot = 418
    static let httpUnprocessableEntity = 422
    static let httpInternalServerError = 500
    static let httpNotImplemented = 501
}
