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

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldShouldReturn(emailTextField)
        emailTextField.delegate = self as! UITextFieldDelegate
        emailTextField.tag = 0 //Increment accordingly
        passwordTextField.delegate = self as! UITextFieldDelegate
        passwordTextField.tag = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        //Exits keyboard when user taps away
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
        // this function goes to next keyboard(email to password etc)
    }
    
    @IBAction func signUp(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error { // if there's an error
                print(error.localizedDescription)
                
                let alert = UIAlertController(title: "Error", message: "There has been an error. Please try again.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
                
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
            }
            else if let user = user{ // if there's no error
                print("no error in sign up")
                print(user.user.uid)
                print(user.user.email)
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
                
                let alert = UIAlertController(title: "Error", message: "Your email or password is incorrect. Please try again.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
                
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
            }
            else if let user = user{ // if there's no error
                print("no error in log in")
                print(user.user.email)
                if let storyboard = self.storyboard {
                    let vc = storyboard.instantiateViewController(withIdentifier: "Home") as! UIViewController
                    self.present(vc, animated: false, completion: nil)
                }
            }
        }
        
    }

    @IBAction func resetPassword(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
            if let error = error{
                let alert = UIAlertController(title: "Error", message: "There has been an error. Please try again.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
            else{
                let alert = UIAlertController(title: "Done", message: "A password reset email was sent to " + self.emailTextField.text!, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        }
    }
}
