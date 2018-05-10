//
//  ViewController.swift
//  Cashactions
//
//  Created by Dylan Steck on 3/23/18.
//  Copyright © 2018 Dylan Steck. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUp(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error { // if there's an error
                print(error.localizedDescription)
            }
            else if let user = user{ // if there's no error
                print("no error in sign up")
                print(user.email)
                print(user.uid)
                if let storyboard = self.storyboard {
                    let vc = storyboard.instantiateViewController(withIdentifier: "InitialBalance") as! UIViewController
                    self.present(vc, animated: false, completion: nil)
                }
            }
        }
    }
    
    @IBAction func logIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error { // if there's an error
                print(error.localizedDescription)
            }
            else if let user = user{ // if there's no error
                print("no error in log in")
                print(user.email)
                if let storyboard = self.storyboard {
                    let vc = storyboard.instantiateViewController(withIdentifier: "Home") as! UIViewController
                    self.present(vc, animated: false, completion: nil)
                }
            }
        }
        
    }

}
