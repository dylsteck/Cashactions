//
//  HomeViewController.swift
//  Cashactions
//
//  Created by Dylan Steck on 3/24/18.
//  Copyright © 2018 Dylan Steck. All rights reserved.
//

import UIKit
import CoreData
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var ref = Database.database().reference()
    var window:UIWindow?
    let cashTypes = ["Select Value Type", "Add or Withdraw Cash", "Bills", "Business", "Food and Drink", "Lose or Deposit Cash", "Miscellaneous", "Other", "Received Money", "Shopping", "Travel"]
    var pickerType = ""
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cashTextField: UITextField!
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var cashTypeControl: UISegmentedControl!
    var formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeDB()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        emailLabel.text = "Welcome, " + (Auth.auth().currentUser?.email!)! + " !"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        //Exits keyboard when user taps away
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func observeDB() { // all this does is updates balance
        let userID = Auth.auth().currentUser!.uid
        
        ref.child(userID).child("Balance/value").observe(.value, with: { snapshot in
            print(userID)
            let price = snapshot.value as! Int
            print(price)
            self.priceLabel.text = "$" + String(price)
        })
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
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cashTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cashTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(cashTypes[row])
        pickerType = cashTypes[row]
        return
    }
    
    @IBAction func addCash(_ sender: UIButton) { // adds new cash
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
        
        formatter.dateFormat = "d MMM yyyy h:mm:ss"
        var timeString = formatter.string(from: Date())
        var tValue = cashTextField.text!
        let valueType = timeString + " " + pickerType
        let transaction = Transaction(value: Int(tValue)!, transactionType: segFinal, valueType: pickerType, addedByUser: (email!), dateAdded: timeString)
        let initialRef = self.ref.child(userID).child("transactions").child(valueType)
        initialRef.setValue(transaction.toAnyObject())
        
            ref.child(userID).child("Balance/value").observeSingleEvent(of: .value, with: { snapshot in
                let price = snapshot.value as! Int
                if self.cashTypeControl.selectedSegmentIndex == 0{
                    self.ref.child(userID).child("Balance/value").setValue(Int(price + Int(tValue)!))
                }
                else {
                    self.ref.child(userID).child("Balance/value").setValue(Int(price - Int(tValue)!))
                }
                
            })
        let alert = UIAlertController(title: "Cashactions", message: "Transaction added", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
