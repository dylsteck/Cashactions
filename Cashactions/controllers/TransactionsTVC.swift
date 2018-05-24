//
//  TransactionsTVC.swift
//  Cashactions
//
//  Created by Dylan Steck on 5/15/18.
//  Copyright © 2018 Dylan Steck. All rights reserved.
//

import Foundation
import UIKit

import FirebaseAuth
import FirebaseCore
import FirebaseDatabase


class TransactionsTVC: UITableViewController {
    var ref = Database.database().reference()
    var userID = Auth.auth().currentUser!.uid
    
    var values = [String]()
    var types = [String]()
    var dates = [String]()
    
    override func viewDidLoad() {
        loadFirebase()
    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section \(section)"
//    }
//
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ControllerCell", for: indexPath) as! TableViewCellCA
        
    //    cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        let row = indexPath.row
        cell.tvcAmountLabel.text = "$" + self.values[row]
        cell.tvcTypeLabel.text = self.types[row]
        cell.tvcDateLabel.text = self.dates[row]
        return cell
    }
    
    func loadFirebase(){
        ref.child(userID).child("transactions").observeSingleEvent(of: .value, with: { snapshot in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                // 1. turns all snapshot instances into a dictionary
                for item in dictionary {
                //2. parses all items in said dictionary
                    let reference = item.value
                    let referenceValue = reference["value"] as! Double
                    print(referenceValue)
                    self.values.append(String(referenceValue))
                    
                    let valueType = reference["valueType"] as! String
                    let transactionType = reference["transactionType"] as! String
                    
                    self.types.append(transactionType + ": " + valueType)
                    
                    let date = reference["dateAdded"] as! String
                    self.dates.append("Date Added: " + date)
                //3. references ["value"] of that particular item
                }
            self.tableView.reloadData()
            }
        })
        
    }
}
