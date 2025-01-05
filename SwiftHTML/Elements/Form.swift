//
//  Form.swift
//  SwiftHTML
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation

public struct Form: HTMLElement {
    public let attributes: HTMLAttributes
    public let tag = "form"
    
    private let content: HTML
    
    public var body: HTML {
        content
    }
    
    public init(method: HTTPMethod = .post, action: String, @HTMLBuilder _ content: () -> HTML) {
        attributes = HTMLAttributes(with: [
            "method": "\(method)".uppercased(),
            "action": action
        ])
        
        self.content = content()
    }
}

public enum HTTPMethod {
    case get
    case post
    case put
    case patch
    case delete
    case trace
    case options
}

public struct Input: HTMLElement {
    public let tag = "input"
    public let attributes: HTMLAttributes
    
    public init(_ type: InputType = .text, name: String = "", value: String = "", placeholder: String = "", required: Bool = false) {
        attributes = HTMLAttributes(with: [
            "type": "\(type)",
            "name": name,
            "value": value,
            "placeholder": placeholder
        ])
        
        if required {
            attributes.boolAttributes.append("required")
        }
    }
    
    public enum InputType {
        case text
        case number
        case checkbox
        case date
        case color
        case file
        case submit
    }
}
