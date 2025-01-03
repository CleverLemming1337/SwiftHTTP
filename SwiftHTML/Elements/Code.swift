//
//  Code.swift
//  SwiftHTML
//
//  Created by Leonard Fekete on 03.01.25.
//

import Foundation

public struct Pre: HTMLElement {
    public let tag = "pre"
    
    private let content: HTML
    
    public var body: HTML {
        content
    }
    
    public init(@HTMLBuilder _ content: () -> HTML) {
        self.content = content()
    }
    
    public init(_ text: String) {
        content = HTMLText(text)
    }
}

public struct Code: HTMLElement {
    public let tag = "code"
    
    private let content: HTML
    
    public var body: HTML {
        Pre {
            content
        }
    }
    
    public init(@HTMLBuilder _ content: () -> HTML) {
        self.content = content()
    }
    
    public init(_ text: String) {
        content = HTMLText(text)
    }
}
