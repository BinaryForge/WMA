//
//  SignUp.swift
//  WMA
//
//  Created by Alexey Kuznetsov on 9/27/18.
//  Copyright © 2018 Alexey Cain. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUp: UIViewController{

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        @IBAction func registerPressed(_ sender: UIButton) {
            if emailText.text!.isEmpty &&  passwordText.text!.isEmpty{
                let alert = UIAlertController(title: "Missing Credentials", message: "Please enter email & password.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"Missing Credentials\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
            print("Enter")
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                if error != nil{
                    if let errCode = AuthErrorCode(rawValue: error!._code) {
                        switch errCode {
                        case .invalidEmail:
                            
                            print("User not found")
                            let alert = UIAlertController(title: "Invalid Email", message: "The email address is badly formatted.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                NSLog("The \"Invalid Email\" alert occured.")
                            }))
                            self.present(alert, animated: true, completion: nil)
                            self.emailText.text = ""
                            self.passwordText.text = ""
                            
                        case .weakPassword:
                            
                            print("Wrong Password")
                            let alert = UIAlertController(title: "Weak Password", message: "The password must be 6 characters long or more.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                NSLog("The \"Weak Password\" alert occured.")
                            }))
                            self.present(alert, animated: true, completion: nil)
                            self.emailText.text = ""
                            self.passwordText.text = ""
                            
                        default:
                            
                            print("Create User Error: \(error)")
                        }
                    }
                }else{
                    self.performSegue(withIdentifier: "goToUserHome", sender: self)
                    
                }
            }
        }
    }
    

