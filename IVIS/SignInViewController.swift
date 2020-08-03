//
//  SignInViewController.swift
//  IVIS
//
//  Created by 김동욱 on 27/04/2020.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class SignInViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var buttonSignIn: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
                // 로그인 되어 있으면 로그아웃하고 실행하기 - 왜 안되지????
                do {
                    try Auth.auth().signOut()
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                }
                dismiss(animated: true, completion: nil)
        
        // 버튼 외관 꾸미기
        // 버튼의 테두리를 네모에서 타원형으로 바꾸기 (곡률을 이용하여)
        buttonSignIn.layer.cornerRadius = buttonSignIn.bounds.size.height / 2
        
        buttonSignIn.layer.borderWidth = 1
        buttonSignIn.layer.borderColor = UIColor.blue.cgColor
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        // MARK : Google Sign In
        
        // 다음 구문은 pod 'GoogleSignIn', '~> 5.0' 버전일 경우 (2020년 4월 Firebase 문서에 있는 코드)
        // GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // pod 'GoogleSignIn', '~> 4.1.1' 버전일 경우
        GIDSignIn.sharedInstance()?.uiDelegate = self
        
        // login
        Auth.auth().addStateDidChangeListener { (user, err) in
            if user != nil {
                
                self.performSegue(withIdentifier: "SignIn", sender: nil)
            }
        }

        
    }
    
    @IBAction func buttonGoogleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func moveToSignUp(_ sender: Any) {
        let signUpVC = UIStoryboard(name: "SignView", bundle: nil).instantiateViewController(withIdentifier: "signUpVC")
        self.navigationController?.pushViewController(signUpVC, animated: true)
        
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
