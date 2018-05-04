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

class InitialBalanceViewController: UIViewController {
    var firebaseAuth = Auth.auth()
    var ref = Database.database().reference(withPath: "transactions")
    var transactions: [Transaction] = []
    var email = Auth.auth().currentUser?.email
    @IBOutlet weak var initialBalanceTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let index = email?.range(of: "@")?.lowerBound {
//            let cutEmail = email![..<index]
//            print(cutEmail)
//        }
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addInitialBalance(_ sender: Any) {
        let transaction = Transaction(value: Int(initialBalanceTextField.text!)!, valueTitle: "Initial Transaction", addedByUser: (email!))
        let initialRef = self.ref.child(Auth.auth().currentUser!.uid).child("transactions").child("Initial Transaction")
        initialRef.setValue(transaction.toAnyObject())
        
        let balance = Transaction(value: Int(initialBalanceTextField.text!)!, valueTitle: "Balance", addedByUser: (email!))
        let balanceRef = self.ref.child(Auth.auth().currentUser!.uid).child("Balance")
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
