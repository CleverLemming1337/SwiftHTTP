//
//  HTMLIntergration.swift
//  SwiftHTTP
//
//  Created by CleverLemming on 04.01.25.
//

import Foundation
import SwiftHTML

public extension HTTPResponse {
    init(status: Int = .httpOK, headers: [String: String] = [:], _ page: HTMLPage) {
        self.status = status
        let body = page.render()
        self.body = body
        
        var newHeaders = headers
        if !headers.keys.contains("Content-Type") {
            newHeaders["Content-Type"] = "text/html"
        }
        if !headers.keys.contains("Content-Length") {
            newHeaders["Content-Length"] = "\(body.utf8.count)"
        }
        self.headers = newHeaders
        
        print(newHeaders)
        
        print(httpText)
    }
}
