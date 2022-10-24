//
//  DetailView.swift
//  H4X0R News Client
//
//  Created by Steven Schwab on 10/23/22.
//

import SwiftUI

// Detail view showing up when we click on a link in the list
// when detail view loads up, it gets passed a url string,
// which gets uses to create a webview
struct DetailView: View {
    // Most important thing to be passed in
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.google.com")
    }
}
