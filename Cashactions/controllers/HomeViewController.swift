//
//  HomeViewController.swift
//  Cashactions
//
//  Created by Dylan Steck on 3/24/18.
//  Copyright © 2018 Dylan Steck. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    var cash: [Int32] = []
    
    @IBOutlet weak var cashTextField: UITextField!
    @IBOutlet weak var cashButton: UIButton!
    //    var people: Int32  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(cash)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addCash(_ sender: UIButton) {
        guard let textField = cashTextField,
            let cashToSave = Int32(textField.text!) else {
                return
            }
        
        self.cash.append(cashToSave)
        print(cash)
        
        let alert = UIAlertController(title: "Cashactions", message: "Transaction added", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
    
}


