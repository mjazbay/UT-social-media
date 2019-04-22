//
//  AddPostEventViewController.swift
//  
//
//  Created by 谢阳欣雨 on 4/21/19.
//

import UIKit
import Parse
import AlamofireImage

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
        let size = CGSize(width: 374, height: 415)
        let scaledImage = image.af_imageScaled(to: size)
        
        PosterImage.image = image
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func endEdit(_ sender: Any) {
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
