//
//  AddPostEventViewController.swift
//  
//
//  Created by 谢阳欣雨 on 4/21/19.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class AddPostEventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var PosterImage: UIImageView!
    @IBOutlet weak var TimeField: UITextField!
    @IBOutlet weak var TitleField: UITextField!
    @IBOutlet weak var DescriptionField: UITextField!
    
    let DatePicker = UIDatePicker()
    
    func createDatePicker(){
        //assign date picker to TimeField
        TimeField.inputView = DatePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDoneClicked))
        
        toolbar.setItems([doneButton], animated: true)
        
        TimeField.inputAccessoryView = toolbar
    }
    
    
    @objc func dateDoneClicked() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm"
        
        TimeField.text = dateFormatter.string(from: DatePicker.date)
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @IBAction func onPostButton(_ sender: Any) {
        let eventPost = PFObject(className: "eventPost")
        
        eventPost["Title"] = TitleField.text!
        eventPost["Time"] = TimeField.text!
        eventPost["Description"] = DescriptionField.text!
        let imageData = PosterImage.image!.pngData()
        let posterFile = PFFileObject(data: imageData!)
        eventPost["Poster"] = posterFile
        
        //eventPost["author"] = PFUser.current()
        
        eventPost.saveInBackground{
            (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("Saved!")
            }else {
                print("error!")
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 374, height: 374)
        let scaledImage = image.af_imageScaled(to: size)
        
        PosterImage.image = image
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func endEdit(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillChange(notification: Notification){
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height
        }else{
            view.frame.origin.y = 0
        }
    }
}
