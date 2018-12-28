//
//  LoginVC.swift
//  Thoughts
//
//  Created by Joshua Madrigal on 12/27/18.
//  Copyright © 2018 joshuamadrigal. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginBtn: RoundButton!
    @IBOutlet private weak var createUser: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        
    }
    
    @IBAction func createUserClicked(_ sender: Any) {
        performSegue(withIdentifier: "goToCreateUser", sender: self)
        
    }
    

}
