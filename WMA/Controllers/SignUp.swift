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
    
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    var employeeCheck: Bool?
    var employerCheck: Bool?
    let myDatabase = Database.database().reference()
 
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    func checkBoth() -> Bool{
        if employeeCheck == employerCheck{
            let alert = UIAlertController(title: "Both selected", message: "Cannot choose both employer & employee", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"Missing Credentials\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            return true
        }
        return false
    }
    
    
    @IBAction func employeeButton(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            employeeCheck = sender.isSelected
           
        }else{
            sender.isSelected = true
            employeeCheck = sender.isSelected
        }
        if checkBoth() == true{
            sender.isSelected = false
        }
    }
   
    
    @IBAction func employerButton(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
             employerCheck = sender.isSelected
            
        }else{
            sender.isSelected = true
             employerCheck = sender.isSelected
        }
        if checkBoth() == true{
            sender.isSelected = false
        }
    }
    
        @IBAction func registerPressed(_ sender: UIButton) {
            if emailText.text!.isEmpty &&  passwordText.text!.isEmpty{
                let alert = UIAlertController(title: "Missing Credentials", message: "Please enter email & password.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"Missing Credentials\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
            print("Employee has been checked", employeeCheck)
            print("Employer has been checked", employerCheck)
            
          
            
            //fix email address already in use
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
                       
                        case .emailAlreadyInUse:
                            print("Email Registered")
                            let alert = UIAlertController(title: "Email Registered", message: "Enter a different email address", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                NSLog("The \"EmailAlreadyInUse\" alert occured.")
                            }))
                            self.present(alert, animated: true, completion: nil)
                            self.emailText.text = ""
                            self.passwordText.text = ""
                        
                        case .networkError:
                            print("Network Error")
                            let alert = UIAlertController(title: "Network Error", message: "Connect to a data source.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                NSLog("The \"NetworkError\" alert occured.")
                            }))
                            self.present(alert, animated: true, completion: nil)
                            self.emailText.text = ""
                            self.passwordText.text = ""
                        default:
                            
                            print("Create User Error: \(error)")
                        }
                    }
                }else{
                    let userDictionary = ["Name": self.name.text,"Email": self.emailText.text,"Company": self.company.text, "Employee": self.employeeCheck,"Employer": self.employerCheck] as [String : Any]
                    self.myDatabase.child("users").childByAutoId().setValue(userDictionary)
                    self.performSegue(withIdentifier: "goToUserHome", sender: self)
                    
                }
            }
        }
    }
    

