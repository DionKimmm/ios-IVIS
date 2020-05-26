//
//  ETCViewController.swift
//  IVIS
//
//  Created by 김동욱 on 26/05/2020.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ETCViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func profileUpload(_ sender: Any) {
        
        let imagePick = UIImagePickerController()
        imagePick.delegate = self
        imagePick.allowsEditing = true
//        imagePick.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePick.sourceType = .photoLibrary
        
        self.present(imagePick, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
//            userLabel.text = Auth.auth().currentUser?.email
//            //            let userInfo = Auth.auth().currentUser?.providerData[indexPath.row]
//            
            
        }
        
        // Do any additional setup after loading the view.
    }
    
//    breakpoint 걸고 실행
//    lldb 창에서 po info 엔터
//    하면 info에 대한 키와 벨류가 주루룩 뜬다
    
//    (lldb) po info
//    ▿ 6 elements
//    ▿ 0 : 2 elements
//    ▿ key : UIImagePickerControllerInfoKey
//    - _rawValue : UIImagePickerControllerImageURL
//    - value : file:///Users/dionkim/Library/Developer/CoreSimulator/Devices/1A670F56-8D9D-4F41-975B-44892D72A1B2/data/Containers/Data/Application/11747176-EB74-4F8F-ACA6-B2ADD26EC11E/tmp/BAEE892D-C6C7-4A2B-837A-BEB6CE7CA481.jpeg
//    ▿ 1 : 2 elements
//    ▿ key : UIImagePickerControllerInfoKey
//    - _rawValue : UIImagePickerControllerMediaType
//    - value : public.image
//    ▿ 2 : 2 elements
//    ▿ key : UIImagePickerControllerInfoKey
//    - _rawValue : UIImagePickerControllerEditedImage
//    - value : <UIImage: 0x600003a323e0> size {826, 620} orientation 0 scale 1.000000
//    ▿ 3 : 2 elements
//    ▿ key : UIImagePickerControllerInfoKey
//    - _rawValue : UIImagePickerControllerOriginalImage
//    - value : <UIImage: 0x600003a26f40> size {4032, 3024} orientation 1 scale 1.000000
//    ▿ 4 : 2 elements
//    ▿ key : UIImagePickerControllerInfoKey
//    - _rawValue : UIImagePickerControllerCropRect
//    - value : NSRect: {{0, 0}, {4031.9998746125634, 3028.8694710253799}}
//    ▿ 5 : 2 elements
//    ▿ key : UIImagePickerControllerInfoKey
//    - _rawValue : UIImagePickerControllerReferenceURL
//    - value : assets-library://asset/asset.HEIC?id=CC95F08C-88C3-4012-9D6D-64A413D254B3&ext=HEIC
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
//       'UIImagePickerControllerOriginalImage' has been renamed to 'UIImagePickerController.InfoKey.originalImage'
//        let image =
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        
        let data = pickedImage.pngData()
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
            
            
            let imageName: String = uid  + "\(Int(NSDate.timeIntervalSinceReferenceDate * 1000)).jpg"
            
            // 파이어스토리지 저장소 참조 만들기
            let profileRef = Storage.storage()
                .reference()
                .child("ios_images")
                .child(imageName)
            
            // Upload the file to the path
            profileRef.putData(data!, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                }
                // Metadata contains file metadata such as size, content-type.
                let size = metadata.size
                // You can also access to download URL after upload.
                profileRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                }
            }
            
            // dismiss
            dismiss(animated: true, completion: nil)
        }

        
    }

}
