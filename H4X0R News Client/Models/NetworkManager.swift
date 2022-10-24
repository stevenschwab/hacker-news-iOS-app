//
//  NetworkManager.swift
//  H4X0R News Client
//
//  Created by Steven Schwab on 10/23/22.
//

import Foundation

//How do we show our results on the screen? How can we pass the results from our network manager to the list
// inside of the contentView? By making our network manager class conform to the observable object protocol
// This means it can actually start to broadcast one or many of its properties to any interested party
// ObservableObject makes the NetworkManager observable

class NetworkManager: ObservableObject {
    //create a property called posts and initialize it as a new array of post objects
    //11. Publish our posts to any interested parties by including a property wrapper called @Published
    // Whenever the property has changes to notify all of the listeners
    @Published var posts = [Post]()
    
    func fetchData() {
        //1. Create a url from a string. The string being the hackernews REST API. Creates an optional
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            //2. If we are able to generate a URL from this string, create a session object from URLSession class
            // and initialize it using a default config
            let session = URLSession(configuration: .default)
            //3. Create a task which is set to session.dataTask and going to choose the initializer that takes
            // a URL and has a completion handler with the data we get back
            let task = session.dataTask(with: url) { data, reponse, error in
                //4. Check if there are no errors and assume we got some data back in JSON format
                if error == nil {
                    //5. Create a decoder from JSON decoder
                    let decoder = JSONDecoder()
                    //6. Get JSON decoder to decode the data we got back from networking session
                    // type is the results.self which is the data type of the results struct.
                    // Data coming back from networking session is an optional, so we have to optionally bind
                    // it to safeData and allow us to work with a non-optional
                    if let safeData = data {
                        //7. Because decode can throw, we have to call it with keyword try.
                        // If we want to catch any errors that occur, we have to wrap the method in do catch block
                        do {
                            //8. Once this data has been decoded, we can bind it to a constant called results
                            // and now we can use our results to populate our list, but before we can do that
                            // we must make sure our task
                            let results = try decoder.decode(Results.self, from: safeData)
                            //12. When we use @published, we always have to make sure we fetch the main thread. We have to tap into the dispatch queue
                            // and inside the closure we set the published property. If you don't, you'll get an error in the console
                            // because the property is a prop other objects are listening to and this object must happen on the main thread
                            // If it happens in the background, then our contentview won't get notified in a timely fashion
                            DispatchQueue.main.async {
                                //10. Once our networking completes and we get hold of the data from the API inside our constant called results,
                                // then we can set our posts. Hits is an array of post objects
                                // Include self.posts because we are inside a closure
                                self.posts = results.hits
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            //9. Starts off networking task
            task.resume()
        }
    }
}
