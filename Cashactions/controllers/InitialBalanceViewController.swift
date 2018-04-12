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
    var ref: DatabaseReference!
    @IBOutlet weak var initialBalanceTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(firebaseAuth.currentUser?.displayName as! String)
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addInitialBalance(_ sender: Any) {
        self.ref.child("transactions").setValue(["balance": initialBalanceTextField.text, "title": "Initial Balance"])
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
