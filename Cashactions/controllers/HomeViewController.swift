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
    
    @IBOutlet weak var cashView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cashTextField: UITextField!
    @IBOutlet weak var cashButton: UIButton!
    
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
        guard let textField = cashTextField,
            let cashToSave = Int32(textField.text!) else {
                return
            }
        
        let alert = UIAlertController(title: "Cashactions", message: "Transaction added", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
    
}


