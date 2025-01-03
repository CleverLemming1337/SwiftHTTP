//
//  Page.swift
//  SwiftHTML
//
//  Created by Leonard Fekete on 02.01.25.
//

import Foundation

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
