//
//  DogAPI.swift
//  doggo
//
//  Created by Jameka Echols on 9/11/21.
//

import Foundation
import UIKit

class DogAPI {
    
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageFromBreed(String)
        
        
        // computed property
        // instead of having to create an instance of the URL every single time we create an URL, we can use it from the
        // dog api
        var url : URL {
            return URL(string: self.rawValue)! // never force unwrap but this is a guaranteed working url
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageFromBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            default:
                print(Error)
            }
        }
    }
    
    // mark as escaping because the completion will be called once the function is finished executing
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void){
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromBreed(breed).url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { data, response, error in
            //the response or error is returned
            
            guard let data = data else {
                completionHandler(nil, error) // return the error since somehting happened
                return
            }
            
            // using the decoder to convert json into swift struct
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            completionHandler(imageData,nil) // return the image since there was no error
        }
        task.resume()
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




