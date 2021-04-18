//
//  UploadViewController.swift
//  InstaCloneProject_
//
//  Created by Şeyma Nur on 13.04.2021.
//

import UIKit
import Firebase
class UploadViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector( chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)

    }
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    //
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info [ .originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func uploadClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        //görseli veriye
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil{
                    self.makeAlert(title: "Error!", message: error!.localizedDescription)
                        
                   //kulanıcının kaydettiği şeyin url sini almak
                }else{
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                           //database
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy": Auth.auth().currentUser!.email!,"postComment": self.commentText.text!,"data": FieldValue.serverTimestamp(),"likes":0] as [String: Any]
                             firestoreReference = firestoreDatabase.collection("Posts").addDocument(data:firestorePost , completion: { (error) in
                                if error != nil{
                                    self.makeAlert(title: "Error!", message: error!.localizedDescription)
                                }else{
                                    self.imageView.image=UIImage(named: "default.png")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                        }
                    }
                }
            }
            
        }
    
    }
        func makeAlert(title:String,message:String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let okButton=UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            }
    
    
   

    }

