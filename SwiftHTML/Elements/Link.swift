//
//  Link.swift
//  SwiftHTML
//
//  Created by Leonard Fekete on 03.01.25.
//

import Foundation

public struct Link: HTMLElement {
    public let tag = "a"
    public let attributes: HTMLAttributes
    
    private let content: HTML
    
    public var body: HTML {
        content
    }
    
    public init(to url: String, @HTMLBuilder _ content: () -> HTML) {
        attributes = HTMLAttributes(with: [
            "href": url
        ])
        self.content = content()
    }
    
    public init(to url: String, _ text: String) {
        attributes = HTMLAttributes(with: [
            "href": url
        ])
        content = RawText(text.replacingOccurrences(of: "\n", with: "<br>"))
    }
}
