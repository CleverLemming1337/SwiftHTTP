//
//  TextStyle.swift
//  SwiftHTML
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation

public struct Style {
    let key: String
    let value: CSSValue
    
    public var description: String {
        "\(key): \(value);"
    }
}

public protocol CSSValue { }

extension Int: CSSValue {}

public enum StyleValue: CSSValue {
    public enum Alignment: CSSValue {
        case normal
        case stretch
        case center
        case flexStart
        case flexEnd
        case start
        case end
        case baseline
    }
    
    case initial
    case inherit
    case unset
}
