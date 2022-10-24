//
//  WebView.swift
//  H4X0R News Client
//
//  Created by Steven Schwab on 10/23/22.
//

import Foundation
import WebKit
import SwiftUI

// Construct a UIKit component
struct WebView: UIViewRepresentable {
    
    let urlString: String?
    
    //2 delegate methods below
    
    func makeUIView(context: Context) -> WKWebView {
        // Turn it into a swiftUI webview
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // What should be displayed in the view
        if let safeString = urlString {
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}
