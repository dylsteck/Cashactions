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
    
    func loadFirebase(){
        ref.child(userID).child("transactions").queryOrderedByKey().observe(.childAdded) { (snapshot) in
            for transaction in snapshot.children.allObjects as! [DataSnapshot] {
                print(transaction.value)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        
        return cell
    }
    
    
}
