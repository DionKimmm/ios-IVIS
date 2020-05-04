//
//  SignUpViewController.swift
//  IVIS
//
//  Created by 김동욱 on 27/04/2020.
//  Copyright © 2020 dionkim. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var buttonSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSignUp.layer.cornerRadius = buttonSignUp.bounds.height / 2
        buttonSignUp.layer.borderWidth = 1
        buttonSignUp.layer.borderColor = UIColor.white.cgColor

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
