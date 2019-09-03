//
//  LoginViewController.swift
//  Snapchap
//
//  Created by Nasr Mohammed on 9/3/19.
//  Copyright © 2019 Nasr Mohammed. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var topButton: UIButton!
    
    @IBOutlet weak var bottomButton: UIButton!
    
    var signUpMode = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func topTapped(_ sender: Any) {
        
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                if signUpMode {
                    // Sign up
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if let error = error {
                            self.presentAlert(alert: error.localizedDescription)
                        }else {
                            print("Sign Up was successful :)")
                            self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                        }
                    })
                } else {
                    // Log in
                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                        if let error = error {
                           self.presentAlert(alert: error.localizedDescription)
                        }else {
                            print("Login was successful :)")
                            self.performSegue(withIdentifier: "moveToSnaps", sender: nil)

                        }
                    })
                }
            }
        }
        
    }
    
    func presentAlert(alert:String) {
        let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func bottomTapped(_ sender: Any) {
       
        
        if signUpMode {
            // switch to log in
            signUpMode = false
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
        } else {
            // switch to signup
            signUpMode = true
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Log In", for: .normal)
        }
    }
    
}

