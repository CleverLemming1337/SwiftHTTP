//
//  Heading.swift
//  SwiftHTML
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation

public struct Heading: HTMLElement {
    public let tag: String
    
    public var body: HTML {
        content
    }
    
    private let content: HTML
    
    public init(size: Size = .big, _ text: String) {
        tag = size.rawValue
        content = RawText(text)
    }
    
    public init(size: Size = .big, @HTMLBuilder _ content: () -> HTML) {
        tag = size.rawValue
        self.content = content()
    }
    
    public enum Size: String {
        case big = "h1"
        case mediumBig = "h2"
        case mediumSmall = "h3"
        case small = "h4"
        case smaller = "h5"
        case smallest = "h6"
    }
}
