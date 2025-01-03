//
//  HTMLAttributes.swift
//  SwiftHTML
//
//  Created by CleverLemming on 02.01.25.
//

import Foundation

@dynamicMemberLookup public struct HTMLAttributes {
    private var attributes: [String: String] = [:]
    
    public subscript(dynamicMember attribute: String) -> String {
        return attributes[attribute, default: ""]
    }
    
    public init() {
        attributes = [:]
    }
    
    public init(with attributes: [String: String]) {
        self.attributes = attributes
    }
    
    public func render() -> String {
        return attributes.map { key, value in "\(key)=\"\(value)\"" }.joined(separator: " ")
    }
}

public protocol HasHTMLAttributes: HTML {
    var attributes: HTMLAttributes { get }
}
