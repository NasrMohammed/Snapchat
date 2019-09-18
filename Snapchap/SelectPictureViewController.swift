//
//  SelectPictureViewController.swift
//  FirebaseAuth
//
//  Created by Nasr Mohammed on 9/4/19.
//

import UIKit
import FirebaseStorage

class SelectPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker : UIImagePickerController?
    var imageAdded = false
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       imagePicker =  UIImagePickerController()
        imagePicker?.delegate = self
        
    }
    

    @IBAction func selectPhotoTapped(_ sender: Any) {
        
        if imagePicker != nil {
            imagePicker!.sourceType = .photoLibrary
            present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        if imagePicker != nil {
            imagePicker!.sourceType = .camera
            present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    @IBAction func nextTapped(_ sender: Any) {
        imageAdded = true
        if let message = messageTextField.text {
            if imageAdded  && message != "" {
             
              // upload the image
                let imagesFolder = Storage.storage().reference().child("images")
                if let image = imageView.image {
                    if let imageData = image.jpegData(compressionQuality: 0.1) {
                        imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData, metadata: nil) { (metadata, error) in
                            if let error  error {
                                
                            }
                        }
                    }

                }

                
              // segue to next view controller
            } else {
                // we are missing something
                let alertVC = UIAlertController(title: "Error", message: "You must provide an image and a message for your snap", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertVC.dismiss(animated: true, completion: nil)
                }
                alertVC.addAction(okAction)
                present(alertVC, animated: true, completion: nil)
            }
        }
        
        
    }
    
    func presentAlert(alert:String) {
        let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
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
