//
//  ContentView.swift
//  H4X0R News Client
//
//  Created by Steven Schwab on 10/23/22.
//

import SwiftUI

struct ContentView: View {
    
    //In order to listen to network manager, we create an object
    // from the network manager class and initialize it.
    //Include a property wrapper of @ObservedObject to set up a property as a listener
    // We are subscribing the updates from the network manager
    //Now, whenever the network manager updates, this is going to trigger and
    // we can use network manager .post properties to update our list
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            //For every single post in our posts array
            // I am going to use each of these post items
            // to create a new text object
            // whenever posts changes, it will trigger a rebuild of our list
            List(networkManager.posts) { post in
                // Create a button on the right-hand side of each cell
                // trigger a presentation to the detail view
                // Destination = sent to from link, label = what is seen before
                // being sent to link
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text(String(post.points))
                        Text(post.title)
                    }
                }
            }
            .navigationTitle("H4X0R News")
        }
        //With every content view, there is a method called onAppear
        // and this is just like our viewDidLoad in UIKit world
        // so if we call onAppear method with the perform property
        // then we can pass a function in here that will be performed
        // when this body view appears on the screen
        .onAppear {
            //Get our network manager to trigger a fetch data method
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//let posts = [
//    Post(id: "1", title: "Hello"),
//    Post(id: "2", title: "Bonjour"),
//    Post(id: "3", title: "Hola"),
//]
