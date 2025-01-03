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
    public let name: String
    
    public var body: HTML? {
        content
    }
    
    private let content: HTML
    
    public init(_ name: String = UUID().uuidString , @HTMLBuilder _ content: () -> HTML) {
        self.content = content()
        self.name = name
    }
    
    public func buildFile(to path: consuming URL) {
        let buildPath = path.appending(path: "build")
        do {
            try FileManager.default.createDirectory(at: buildPath, withIntermediateDirectories: true)
            try render().write(to: buildPath.appendingPathComponent("\(name).html"), atomically: true, encoding: .utf8)
        }
        catch {
            print("Error saving \(name): \(error.localizedDescription)")
        }
    }
}
