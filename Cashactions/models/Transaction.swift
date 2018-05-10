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
    let value: Int
    let addedByUser: String
    let transactionType: String
    let ref: DatabaseReference?
    let valueTitle: String
    
    init(value: Int, transactionType: String, valueTitle: String, addedByUser: String) {
//      self.key = key
        self.value = value
        self.addedByUser = addedByUser
        self.transactionType = transactionType
        self.valueTitle = valueTitle
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
//        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        value = snapshotValue["value"] as! Int
        addedByUser = snapshotValue["addedByUser"] as! String
        ref = snapshot.ref
        valueTitle = snapshotValue["valueTitle"] as! String
        transactionType = snapshotValue["transactionType"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "value": value,
            "valueTitle": valueTitle,
            "transactionType": transactionType,
            "addedByUser": addedByUser,
        ]
    }
    
}
