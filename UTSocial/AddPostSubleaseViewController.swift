//
//  AddPostSubleaseViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/15/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit

class AddPostSubleaseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var defaultPicture: UIImageView!
    
    //Tap Camera Gesture to Open Camera or Gallery Library
    @IBAction func cameraTapGesture(_ sender: UITapGestureRecognizer)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            picker.sourceType = .camera
        }
        else
        {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    //selecting and saving the image to variable
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.defaultPicture.image = image
        dismiss(animated: true, completion: nil)
    }
    
}
