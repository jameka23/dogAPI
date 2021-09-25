//
//  ViewController.swift
//  doggo
//
//  Created by Jameka Echols on 9/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { data, response, error in
            //the response or error is returned
            
            guard let data = data else {
                return
            }
            
            
            
            
            // json serialization using a do/catch
            
//            do {
//                //cast as a dictionary with <string,any>
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
//
//                let url = json["message"] as! String
//                print(url)
//
//            } catch {
//                print("there was an error")
//            }
            
            // using the decoder to convert json into swift struct
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            
            guard let message = URL(string: imageData.message) else { return }
            
            DogAPI.requestImageFile(url: message, completionHandler: self.handleImageFileResponse(image:error:))
        }
        task.resume()
    }

    func handleImageFileResponse(image: UIImage?, error: Error?){
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

}

