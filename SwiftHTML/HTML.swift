//
//  HTML.swift
//  SwiftHTML
//
//  Created by CleverLemming on 03.01.25.
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
    var tag: String { get }
    @HTMLBuilder var body: HTML { get }
}

public extension HTMLElement {
    /// Default implementation to render an HTML element
    func render() -> String {
        if body is EmptyHTML { // element has no own body
            if let attributes = Mirror(reflecting: self).children.filter({ $0.label == "attributes" }).first?.value as? HTMLAttributes {
                return "<\(tag) \(attributes.render())/>"
            }
            else {
                return "<\(tag)/>"
            }
        }
        
        if let attributes = Mirror(reflecting: self).children.filter({ $0.label == "attributes" }).first?.value as? HTMLAttributes {
            return "<\(tag) \(attributes.render())>\(body.render())</\(tag)>"
        }
        return "<\(tag)>\(body.render())</\(tag)>"
    }
    
    var body: HTML { EmptyHTML() }
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


public struct EmptyHTML: HTML {
    public func render() -> String {
        return ""
    }
}
