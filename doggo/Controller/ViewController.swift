//
//  ViewController.swift
//  doggo
//
//  Created by Jameka Echols on 9/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    let breeds: [String] = ["greyhound", "poodle"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
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
extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(breed: breeds[row], completionHandler: handleRandomImageRequest(imageData:error:))
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
}
