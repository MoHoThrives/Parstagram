//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Mohanad Osman on 3/24/19.
//  Copyright © 2019 mohanadhmd. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse


class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageField: UIImageView!
    
    @IBOutlet weak var getComment: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let post = PFObject(className: "Posts")

        post["caption"] = getComment.text!
        post["author"] = PFUser.current()!
        
        let imgData = imageField.image?.pngData()
        let file = PFFileObject(data: imgData!)
        
        post["image"] = file
        
        
        post.saveInBackground { (success, error) in
            if(success){
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            } else {
                print("error!")
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        imageField.image = scaledImage
        dismiss(animated: true, completion: nil)
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
