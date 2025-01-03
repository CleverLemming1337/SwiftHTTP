//
//  Text.swift
//  SwiftHTML
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation

public struct Text: HTMLElement {
    public let tag = "span"
    
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

public typealias RawText = HTMLText

public struct Paragraph: HTMLElement {
    public let tag = "p"
    
    private let content: HTML
    
    public var body: HTML {
        content
    }
    
    public init(@HTMLBuilder _ content: () -> HTML) {
        self.content = content()
    }
    
    public init(_ text: String) {
        content = HTMLText(text.replacingOccurrences(of: "\n", with: "<br>"))
    }
}

