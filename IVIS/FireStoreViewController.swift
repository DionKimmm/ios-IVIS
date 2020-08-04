//
//  FireStoreViewController.swift
//  IVIS
//
//  Created by mac on 2020/08/04.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit
import Firebase

class FireStoreViewController: UIViewController {

    var db: Firestore!
    var fireStoreArray : [FireStoreModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //temp
        let temptemp: [String:Any] = ["email":"0", "profileImageUrl":"1", "githubUrl":"2", "uid":"3"]
        
//        if let uidResult = temptemp["key"] {
//            print(result)
//        }
        
        if let temptemptemp = FireStoreModel.init(dictionary: temptemp){
            fireStoreArray.append(temptemptemp)
        }
        print("tempFireStoreArray => \(fireStoreArray)")
        
        db = Firestore.firestore()
        
//        let docRef = db.collection("users").document("BJ")

        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let temp = document.data() as Dictionary
                    print("temp => \(temp)")
                    if let tempArray = FireStoreModel.init(dictionary: temp){
                        self.fireStoreArray.append(tempArray)
                    }
                    print("fireStoreArray => \(self.fireStoreArray)")
                }
            }
        }
        print("fireStoreArray => \(self.fireStoreArray)")
        
        print("--------카운트--------")
        print(fireStoreArray.count)
        print("--------어레이 0번--------")
        print(fireStoreArray[0])
        print("--------어레이 0번 uid--------")
//        let a1 = fireStoreArray[0] {
//            if let result = a1["uid"] {
//                print(result)
//            }
//        }
        
//        }
        print("--------어레이 1번--------")
        print("--------어레이 1번 uid--------")
//        print("fireStoreArray[0][\"uid\"] => \(fireStoreArray[0]["uid"])")
        
        
//        let docRef = db.collection("cities").document("BJ")
//
//        docRef.getDocument { (document, error) in
//            if let city = document.flatMap({
//              $0.data().flatMap({ (data) in
//                return FireStoreModel(dictionary: data)
//              })
//            }) {
//                print("City: \(city)")
//            } else {
//                print("Document does not exist")
//            }
//        }
        


        // Do any additional setup after loading the view.
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
