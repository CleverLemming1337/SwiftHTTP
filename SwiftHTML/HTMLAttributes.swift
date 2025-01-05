//
//  HTMLAttributes.swift
//  SwiftHTML
//
//  Created by CleverLemming on 02.01.25.
//

import Foundation

@dynamicMemberLookup public class HTMLAttributes {
    private var attributes: [String: String]
    public var boolAttributes: [String]
    
    public subscript(dynamicMember attribute: String) -> String {
        return attributes[attribute, default: ""]
    }
    
    public init() {
        attributes = [:]
        boolAttributes = []
    }
    
    public init(with attributes: [String: String], boolAttributes: [String] = []) {
        self.attributes = attributes
        self.boolAttributes = boolAttributes
    }
    
    public func render() -> String {
        return attributes.map { key, value in "\(key)=\"\(value)\"" }.joined(separator: " ") + " " + boolAttributes.joined(separator: " ")
    }
}

public protocol HasHTMLAttributes: HTML {
    var attributes: HTMLAttributes { get }
}
