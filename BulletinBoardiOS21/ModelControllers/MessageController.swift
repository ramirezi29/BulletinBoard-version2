//
//  MessageController.swift
//  BulletinBoardiOS21
//
//  Created by Ivan Ramirez on 9/24/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation
import CloudKit


//make func to be able to save and fetch

class MessageController {
    
    static let shared = MessageController()
    
    //notifcation name
    let messagesWereUpdatedNotification = Notification.Name("messagesWereUpdated")
    var messages: [Message] = [] {
        didSet {
            //notification Center -> reload the table view there's been a change
            //sounds out the notification to any one listening
            NotificationCenter.default.post(name: messagesWereUpdatedNotification, object: nil)
        }
    }
    
    
    //func EXAMPLESaveToiCloudWith(text: String) {
        
        //Initialize a new message object
        
        //use a cloudKitManager function to save the message's CKRecord
        
        
        //check for errors
        
        //if there are no errors, then append the message to the messages array
  //  }

  //  func EXAMPLEfetchMessagesRecFromiCloud() {
        
        //use a cloudKitManger func to fetch Messages records from the right database
    
        
        //take the records returned and initialize message objects from them
        
        //set the newly created message in the MessageController's array of message
   // }
    
    
    func saveMessageRecordToiCloudWith(text: String) {
        
        let message = Message(text: text)
        
        CloudKitManager.shared.saveRecordToCloudKit(record: message.CloudKitRecord, database: CKContainer.default().publicCloudDatabase) { (error) in
            
            if let error = error {
                //proper handling in future features, would include an user notification for the user so the know to try again or something
                print("Error saving message record to iCloud: \(error.localizedDescription)")
            } else {
                
                // if theres no error append messages to message array
                self.messages.append(message)
            }
        }
    }

    func fetchMessageRecordsFromiCloud() {
        
      
        CloudKitManager.shared.fetchRecordsOf(type: Message.TypeKey, database: CKContainer.default().publicCloudDatabase) { (records, error) in
            if let error = error {print ("Error fetching message records from iCLoud: \(error.localizedDescription)") }
            guard let records = records else {return}
            // turn into message
            //take the records array and flat map through array. call the message init. $0 reps each message
            let messages = records.compactMap({ Message(cloudKitRecord: $0) })
            self.messages = messages
        }
    }
}
