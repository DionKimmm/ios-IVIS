//
//  SignInViewController.swift
//  IVIS
//
//  Created by 김동욱 on 27/04/2020.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var buttonSignIn: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 버튼 외관 꾸미기
        // 버튼의 테두리를 네모에서 타원형으로 바꾸기 (곡률을 이용하여)
        buttonSignIn.layer.cornerRadius = buttonSignIn.bounds.size.height / 2
        
        buttonSignIn.layer.borderWidth = 1
        buttonSignIn.layer.borderColor = UIColor.blue.cgColor
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        // Do any additional setup after loading the view.
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
