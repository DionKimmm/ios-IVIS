//
//  GithubViewController.swift
//  UITest
//
//  Created by 김동욱 on 15/04/2020.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit
import SafariServices
import Firebase

class GithubViewController: UIViewController {

    var db: Firestore!
    
    @IBOutlet weak var gitHubCollectionView: UICollectionView!
    var githubList: [GitHubModel] = []
    var githubListReal: [GitHubModel] = []
    var array : [UserDTO] = []
    var uidKey : [String] = []
    var count = 0
    
    @IBOutlet weak var userLabel: UILabel!
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {

        }
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        print("***************************************")
        print("***************************************")
        print("viewWillAppear 실행")
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("***************************************")
                print("***************************************")
                print("유저 수 => \(querySnapshot!.count)")
                self.githubList.removeAll()
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    print("\(document.documentID) => \(document.data()["displayName"]!)")
                    print("깃허브 URL => \(document.data()["profileImageURL"]!)")
                    let url = URL(string: "\(document.data()["profileImageURL"]!)")
                    let data = try! Data(contentsOf: url!)
                    
                    self.githubList.append(GitHubModel.init(name: "\(document.data()["displayName"]!)", photo: UIImage(data: data), url: "\(document.data()["githubURL"]!)"))
                    
                    
                    
                }
                print("***************************************")
                print("***************************************")
            }
        }
        gitHubCollectionView.reloadData()
        print(githubList)
    }
    
    //MARK:- viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()

        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.githubList.removeAll()
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    print("\(document.documentID) => \(document.data()["displayName"]!)")
                    let url = URL(string: "\(document.data()["profileImageURL"]!)")
                    let data = try! Data(contentsOf: url!)
                    
                    self.githubList.append(GitHubModel.init(name: "\(document.data()["displayName"]!)", photo: UIImage(data: data), url: "\(document.data()["githubURL"]!)"))
                    
                    
                    
                }
            }
        }
        
        //dummy data
//        let github_kdw14 = GitHubModel.init(name: "14김동욱", photo: UIImage(named: "14김동욱"), url:"https://github.com/Dionkimmm")
//        let github_kdw15 = GitHubModel.init(name: "15김동욱", photo: nil, url: "")
//        let github_pjy = GitHubModel.init(name: "박정용", photo: nil, url: "")
//        githubList.append(github_kdw14)
//        githubList.append(github_kdw15)
//        githubList.append(github_pjy)
        
//        // 로그인 되어 있으면 로그아웃하고 실행하기 - 왜 안되지????
//        do {
//            try Auth.auth().signOut()
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
//        dismiss(animated: true, completion: nil)
        
        
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
            userLabel.text = Auth.auth().currentUser?.email
            print(Auth.auth())
            print(Auth.auth().currentUser)
            print(Auth.auth().currentUser?.email)
            print(user.photoURL)
//            let userInfo = Auth.auth().currentUser?.providerData[indexPath.row]
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGitHub" {
            
            let selectedCell = sender as! GitHubCollectionViewCell
            if let selectedIndexPath = gitHubCollectionView.indexPath(for: selectedCell) {
                
                // 정보 가져다주기
//                let gitHubSafariVC = segue.destination as! GitHubSafariViewController
//                gitHubSafariVC.githubModel = githubList[selectedIndexPath.row]
                
                // 사파리 열기
                guard let url = URL(string: githubList[selectedIndexPath.row].url) else {
                    return
                }
                let gitHubSafiriVC = SFSafariViewController(url: url)
                self.show(gitHubSafiriVC, sender: self)
            }
        }
    }
}
// extension을 이용한 Protocol 선언 방법
// 해당되는 프로토콜을 나누어 선언 하는 것이 요즘의 관례임.

extension GithubViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 - 1, height: UIScreen.main.bounds.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.bounds.width / 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
}

extension GithubViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return githubList.count
        //return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! GitHubCollectionViewCell
        
        cell.gitHubName.text = githubList[indexPath.row].name
        cell.gitHubImageView.image = githubList[indexPath.row].photo
        
        print("***********************")
        print("***********************")
        print(githubList)
        print("***********************")
        print("***********************")
        
        
        
        return cell
    }
    
    
}

extension GithubViewController: UICollectionViewDelegate {
    
}
