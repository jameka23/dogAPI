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
        
        DogAPI.requestRandomImage(completionHandler: handleRandomImageRequest(imageData:error:))
    }
    
    func handleRandomImageRequest(imageData:DogImage?, error:Error?){
        guard let message = URL(string: imageData?.message ?? "") else { return }
        
        DogAPI.requestImageFile(url: message, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?){
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

}

