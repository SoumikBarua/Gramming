//
//  SignInViewController.swift
//  Gramming
//
//  Created by SB on 5/17/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet var emailTextField: CustomTextField!
    @IBOutlet var passwordTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Custom
    }
    
    @IBAction func fbButtonPressed(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Problem authenticating with Facebook! - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("User cancelled Facebook authentication")
            } else {
                print("Successfully authenticated with Facebook!")
                
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
            
        }
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential, completion: {(user, error) in
            if error != nil {
                print("Problem authenticating with Firebase - \(String(describing: error))")
            } else {
                print("Successfully authenticated with Firebase!")
            }
        })
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("Email user authenticated with Firebase")
                } else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("Unable to authenticate with Firebae using email - \(error)")
                        } else {
                            print("Successfully authenticated with Firebase using email")
                        }
                    })
                }
            })
        }
    }
    
    
}
