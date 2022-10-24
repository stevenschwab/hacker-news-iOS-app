//
//  PostData.swift
//  H4X0R News Client
//
//  Created by Steven Schwab on 10/23/22.
//

import Foundation

// Create a structure to represent all of the properties we want out of the results
// Conforms to the decodable protocol so we can use the json decoder to decode
// our json data into a result struct

struct Results: Decodable {
    let hits: [Post]
}

// Post object. In order for something to be identifiable, it must have a property called id

struct Post: Decodable, Identifiable {
    // We already have an id identifier, so we can use computed properties
    // whenever we try to fetch an id, it's going to look at the value of the
    // objectID and assign it to the property id
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
