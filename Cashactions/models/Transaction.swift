//
//  Transaction.swift
//  Cashactions
//
//  Created by Dylan Steck on 4/16/18.
//  Copyright © 2018 Dylan Steck. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Transaction {
    
    
//    let key: String
    let value: Double
    let addedByUser: String
    let transactionType: String
    let ref: DatabaseReference?
    let valueType: String
    let dateAdded: String
    
    init(value: Double, transactionType: String, valueType: String, addedByUser: String, dateAdded: String) {
//      self.key = key
        self.value = value
        self.addedByUser = addedByUser
        self.transactionType = transactionType
        self.valueType = valueType
        self.ref = nil
        self.dateAdded = dateAdded
    }
    
    init(snapshot: DataSnapshot) {
//        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        value = snapshotValue["value"] as! Double
        addedByUser = snapshotValue["addedByUser"] as! String
        ref = snapshot.ref
        valueType = snapshotValue["valueType"] as! String
        transactionType = snapshotValue["transactionType"] as! String
        dateAdded = snapshotValue["dateAdded"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "value": value,
            "valueType": valueType,
            "transactionType": transactionType,
            "addedByUser": addedByUser,
            "dateAdded": dateAdded
        ]
    }
    
}
