//
//  CloudKitManager.swift
//  BulletinBoardiOS21
//
//  Created by Ivan Ramirez on 9/24/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {
    
    static let shared = CloudKitManager()
    
    //func that will let us save to cloudKit
    // _ in, is the default value
    //there could be an Error
    func saveRecordToCloudKit(record: CKRecord, database: CKDatabase, completion: @escaping (Error?) -> Void = { _ in }) {
        
        database.save(record) { (_, error) in
            completion(error)
        }
    }
    //fetch record of any type
    func fetchRecordsOf(type: String, database: CKDatabase, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        
        //what records do we want back? my own records, or those that say the word "hello"
        //value true, if theres a message give it to us
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Message.TypeKey, predicate: predicate)
        
        //give cloud kid this query, heres what i want, can you give it back. "yes, and if it fails ill let you know"
        
        database.perform(query, inZoneWith: nil, completionHandler: completion)
    }
}
