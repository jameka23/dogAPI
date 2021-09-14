//
//  DogAPI.swift
//  doggo
//
//  Created by Jameka Echols on 9/11/21.
//

import Foundation

class DogAPI {
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        
        // computed property
        // instead of having to create an instance of the URL every single time we create an URL, we can use it from the
        // dog api
        var url : URL {
            return URL(string: self.rawValue)! // never force unwrap but this is a guaranteed working url
        }
    }
}

