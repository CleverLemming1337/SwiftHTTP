//
//  SwiftHTMLTests.swift
//  SwiftHTMLTests
//
//  Created by CleverLemming on 02.01.25.
//

import Testing
@testable import SwiftHTML

struct SwiftHTMLTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        
    }
    
    @Test func savePage() async throws {
        SamplePage().buildFile(to: URL(fileURLWithPath: "\(NSHomeDirectory())/Desktop"))
    }
}

struct SamplePage: HTMLPage {
    let name = "TestPage"
    
    var body: HTML {
        Heading("This is SwiftHTML")
        Image(from: "https://512pixels.net/wp-content/uploads/2024/06/15-Sequoia-Light-16x9-Thumbnail_2-500x500.jpg", alt: "This is an example image")
        Paragraph("SwiftHTML is a Swift framework that lets you build HTML sites with Swift's declarative result builder syntax.\nHere an example:")
        Code("""
            struct SamplePage: HTMLPage {
                let name = "TestPage"
                
                var body: HTML {
                    Heading("This is SwiftHTML")
                    Image(from: "https://512pixels.net/wp-content/uploads/2024/06/15-Sequoia-Light-16x9-Thumbnail_2-500x500.jpg", alt: "This is an example image")
                    Paragraph("SwiftHTML is a Swift framework that lets you build HTML sites with Swift's declarative result builder syntax.\\nHere an example:")
                    Code(\"""
                        Heading("This is SwiftHTML")
                        Image(from: "https://512pixels.net/wp-content/uploads/2024/06/15-Sequoia-Light-16x9-Thumbnail_2-500x500.jpg", alt: "This is an example image")
                        Paragraph("SwiftHTML is a Swift framework that lets you build HTML sites with Swift's declarative result builder syntax.\\nHere an example:")
                    \""")
                }
            }
        """)
    }
}
