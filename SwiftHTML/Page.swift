//
//  SwiftHTTPTests.swift
//  SwiftHTTPTests
//
//  Created by Leonard Fekete on 02.01.25.
//

import Foundation

public protocol HTML {
    /// Render the HTML element as a String
    func render() -> String
}

@resultBuilder public struct HTMLBuilder {
    static public func buildBlock(_ components: HTML...) -> HTML {
        HTMLText(components.map { $0.render() }.joined(separator: "\n"))
    }
    
    static public func buildOptional(_ component: HTML?) -> HTML {
        component ?? HTMLText("")
    }
    
    static public func buildEither(first component: HTML) -> HTML {
        component
    }

    static public func buildEither(second component: HTML) -> HTML {
        component
    }
}

/// Represents a basic HTML element
public protocol HTMLElement: HTML {
    var tagName: String { get }
    @HTMLBuilder var body: HTML? { get }
    
}

public extension HTMLElement {
    /// Default implementation to render an HTML element
    func render() -> String {
        if let body = body {
            return "<\(tagName)>\(body.render())</\(tagName)>"
        }
        return "<\(tagName)/>"
    }
    
    var body: HTML? { nil }
}

/// Represents raw HTML text
public struct HTMLText: HTML {
    let text: String
    
    public init(_ text: String) {
        self.text = text
    }
    
    public func render() -> String {
        text
    }
}

/// Represents a full HTML page
public struct Page: HTMLElement {
    public var tagName: String { "html" }
    
    @HTMLBuilder public var body: HTML? {
        content
    }
    
    private let content: HTML
    
    public init(@HTMLBuilder _ content: () -> HTML) {
        self.content = content()
    }
}


/// Example of a self-closing tag
public struct Img: HTMLElement {
//    public var attributes: HTMLAttributes
    public let tagName: String = "img"
    
    public init(src: String, alt: String = "") {
//        attributes = HTMLAttributes(with: [
//            "src": src,
//            "alt": alt
//        ])
    }
}
