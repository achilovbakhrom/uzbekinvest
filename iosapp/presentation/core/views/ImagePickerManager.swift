//
//  ImagePickerManager.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 3/30/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//


// USAGE
//ImagePickerManager().pickImage(self){ image in
//    //here is the image
//}

import Foundation
import UIKit

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker = UIImagePickerController();
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage, String) -> ())?;

    var isCustomGallery = false
    
    var customGalleryClicked: (() -> Void)? = nil
    
    override init(){
        super.init()
    }

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage, String) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;
        alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        let customGallery = UIAlertAction(title: "Custom Gallery", style: .default) { _ in
            self.customGalleryClicked?()
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        if isCustomGallery {
            alert.addAction(customGallery)
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            self.viewController!.present(alert, animated: true, completion: nil)
        }
    }
    func openGallery(){
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }


    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        if #available(iOS 11.0, *) {
            let url = info[.imageURL] as! URL
            pickImageCallback?(image, url.path)
        } else {
            let reference = info[.referenceURL] as? URL
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd_MM_yyyy:HH:mm:ss"
            pickImageCallback?(image, reference?.path ?? "\(dateFormatter.string(from: Date()))-file.jpg")
        }
    }



    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }

}
