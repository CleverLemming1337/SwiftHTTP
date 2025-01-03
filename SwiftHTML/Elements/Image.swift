//
//  Image.swift
//  SwiftHTML
//
//  Created by CleverLemming on 03.01.25.
//

import Foundation

/// The HTML `img<src=alt=>` tag. Can be initialized from a url or from the assets.
public struct Image: HTMLElement {
    public var attributes: HTMLAttributes
    public let tag: String = "img"
    
    public init(from url: String, alt: String = "") {
        attributes = HTMLAttributes(with: [
            "src": url,
            "alt": alt
        ])
    }
}
