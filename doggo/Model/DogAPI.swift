//
//  DogAPI.swift
//  doggo
//
//  Created by Jameka Echols on 9/11/21.
//

import Foundation
import UIKit

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
    
    // mark as a class bc we dont nee and instance of dogapi in order to use it
    // also can't return a value since it's a class func so we can pass in a
    // (closure) to get a value back to the view controller are going to be parameters of the callback function
    // mark as escaping because it is
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void){
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (imgData, response, error) in
            guard let imgData = imgData else {
                completionHandler(nil, error)
                return
            }
            
            let downloadedImage = UIImage(data: imgData)
            completionHandler(downloadedImage, nil)
        })
        task.resume()
    }
}




