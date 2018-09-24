//
//  Message.swift
//  BulletinBoardiOS21
//
//  Created by Ivan Ramirez on 9/24/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation
import CloudKit

class Message {
    
    static let TypeKey = "Message"
    private let TextKey = "text"
    private let TimeStampKey = "timeStamp"
    
    //Be mindful that Data is an apple made class. you'll need to conver the time in seconds perhaps.
    
    let text: String
    let timeStamp: Date
    
    init(text: String, timeStamp: Date = Date()) {
        self.text = text
        self.timeStamp = timeStamp
    }
    
    //2.Failable init
    //pull the values out and set them in the model
    init?(cloudKitRecord: CKRecord) {

        //need to cast bc they loose their type
        guard let text = cloudKitRecord[TextKey] as? String,
            let timeStamp = cloudKitRecord[TimeStampKey] as? Date else {return nil}
        
        self.text = text
        self.timeStamp = timeStamp
        
    }
    
    //turn into CKRecord to be use with Cloud Kit. Pretty much a fancy dictionary
    //1.Computed Property
    var CloudKitRecord: CKRecord {
        
        let record = CKRecord(recordType: Message.TypeKey)
        
        record.setValue(text, forKey: TextKey)
        //the code below and above do the same thing
        record[TimeStampKey] = timeStamp as CKRecordValue
        
        return record
    }
    
    
    
    
}
