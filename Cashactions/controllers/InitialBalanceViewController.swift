//
//  InitialBalanceViewController.swift
//  Cashactions
//
//  Created by Dylan Steck on 4/6/18.
//  Copyright © 2018 Dylan Steck. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class InitialBalanceViewController: UIViewController, UITextFieldDelegate {
    var firebaseAuth = Auth.auth()
    var ref = Database.database().reference(withPath: "transactions")
    var transactions: [Transaction] = []
    @IBOutlet weak var initialBalanceTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    var formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let index = email?.range(of: "@")?.lowerBound {
//            let cutEmail = email![..<index]
//            print(cutEmail)
//        }
        ref = Database.database().reference()
        initialBalanceTextField.delegate = self
        initialBalanceTextField.resignFirstResponder()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        //Exits keyboard when user taps away
    }

    @IBAction func addInitialBalance(_ sender: Any) {
        let userID = Auth.auth().currentUser!.uid
        let email = Auth.auth().currentUser?.email
        let tValue = initialBalanceTextField.text!
        formatter.dateFormat = "MM/dd/yyyy, H:mm:ss"
        var timeString = formatter.string(from: Date())
        
        let transaction = Transaction(value: Int(tValue)!, transactionType: "Add", valueType: "Initial Transaction", addedByUser: (email!), dateAdded: timeString )
        let initialRef = self.ref.child(userID).child("transactions").child("Initial Transaction")
        initialRef.setValue(transaction.toAnyObject())
        
        let balance = Transaction(value: Int(tValue)!, transactionType: "Add", valueType: "Balance: $" + tValue, addedByUser: (email!), dateAdded: timeString)
        let balanceRef = self.ref.child(userID).child("Balance")
        balanceRef.setValue(transaction.toAnyObject())
        
    } //end of IBAction
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
