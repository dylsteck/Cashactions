//
//  HomeViewController.swift
//  Cashactions
//
//  Created by Dylan Steck on 3/24/18.
//  Copyright © 2018 Dylan Steck. All rights reserved.
//

import UIKit
import CoreData
import ChameleonFramework
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {
    var ref = Database.database().reference()
    var powderAsh = UIColor(red:0.73, green:0.78, blue:0.75, alpha:1.0)
    var seaMist = UIColor(red:0.76, green:0.88, blue:0.76, alpha:1.0)
    var window:UIWindow?
    
    @IBOutlet weak var cashView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cashTextField: UITextField!
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var cashTypeControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeDB()
        cashView.backgroundColor = GradientColor(.leftToRight, frame: view.frame, colors: [powderAsh, seaMist])
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func observeDB() {
        let userID = Auth.auth().currentUser!.uid
        
        ref.child(userID).child("Balance/value").observe(.value, with: { snapshot in
            print(userID)
            let price = snapshot.value as! Int
            print(price)
            self.priceLabel.text = "$" + String(price)
//      update      ref.child("yourKey").child("yourKey").updateChildValues(["yourKey": yourValue])
        })
    }
    @IBAction func addCash(_ sender: UIButton) {
        let userID = Auth.auth().currentUser!.uid
        let email = Auth.auth().currentUser?.email

        var segType:String
        var segFinal = ""
        if self.cashTypeControl.selectedSegmentIndex == 0{
            segType = "Add"
            segFinal = segType
        }
        else{
            segType = "Spend"
            segFinal = segType
        }
        
        let transaction = Transaction(value: Int(cashTextField.text!)!, transactionType: segFinal, valueTitle: cashTextField.text!, addedByUser: (email!))
        let initialRef = self.ref.child(userID).child("transactions").child(cashTextField.text!)
        initialRef.setValue(transaction.toAnyObject())
        
        ref.child(userID).child("Balance/value").observeSingleEvent(of: .value, with: { snapshot in
            let price = snapshot.value as! Int
            if self.cashTypeControl.selectedSegmentIndex == 0{
            self.ref.child(userID).child("Balance/value").setValue(Int(price + Int(self.cashTextField.text!)!))
            }
            else {
                self.ref.child(userID).child("Balance/value").setValue(Int(price - Int(self.cashTextField.text!)!))
            }
            
        })
        
        let alert = UIAlertController(title: "Cashactions", message: "Transaction added", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
    
    func checkStatus(){
        if Auth.auth().currentUser != nil {
            // User is signed in.
            print("user is not signed in")
        }
        else {
            // No user is signed in.
            print("no user signed in, continue sign out")
            if let storyboard = self.storyboard {
                let vc = storyboard.instantiateViewController(withIdentifier: "Login") as! UIViewController
                self.present(vc, animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        checkStatus()
    }
    
    
}


