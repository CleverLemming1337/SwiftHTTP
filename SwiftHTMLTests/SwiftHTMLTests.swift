//
//  SwiftHTMLTests.swift
//  SwiftHTMLTests
//
//  Created by Leonard Fekete on 02.01.25.
//

import Testing
@testable import SwiftHTML

struct SwiftHTMLTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        
    }
    
    @Test func savePage() async throws {
        TestPage().buildFile(to: URL(fileURLWithPath: "\(NSHomeDirectory())/Desktop"))
    }
}

struct TestPage: HTMLPage {
    let name = "TestPage"
    
    var body: HTML {
        Image(from: "Test", alt: "Test")
    }
}
