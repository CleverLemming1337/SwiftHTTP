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
    static let httpNotAcceptable = 406
    static let httpTeapot = 418
    static let httpUnprocessableEntity = 422
    static let httpInternalServerError = 500
    static let httpNotImplemented = 501
}

public func getHTTPStatusCodeName(_ status: Int) -> String{
    switch status {
    case 200:
        return "OK"
    case 404:
        return "Not Found"
    case 405:
        return "Method Not Allowed"
    case 406:
        return "Not acceptable"
    case 418:
        return "I'm a teapot"
    case 422:
        return "Unprocessable Entity"
    case 500:
        return "Internal Server Error"
    case 501:
        return "Not Implemented"
    default:
        return "Unknown"
    }
}

public func httpStatusCodeFormatted(_ status: Int) -> String {
    var color = "7" // default is grey
    
    switch status / 100 { // only first digit
    case 1:
        color = "9" // default (white)
    case 2:
        color = "2" // green
    case 3:
        color = "3" // yellow
    case 4:
        color = "1" // red
    case 5:
        color = "5" // magenta
    default:
        color = "7" // grey
    }
    return "\u{1b}[3\(color);1m\(status) \(getHTTPStatusCodeName(status))\u{1b}[0m"
}
