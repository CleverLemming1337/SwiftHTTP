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
        Page("TestPage") {
            Image(from: "https://...")
        }.buildFile(to: URL(fileURLWithPath: "\(NSHomeDirectory())/Desktop"))
    }
}
