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
            
            print(data)
            
            
            // json serialization using a do/catch
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            } catch {
                print("there was an error")
            }
            
            
        }
        task.resume()
    }


}

