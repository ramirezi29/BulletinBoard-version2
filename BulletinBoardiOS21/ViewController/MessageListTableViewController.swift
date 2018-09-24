//
//  MessageListTableViewController.swift
//  BulletinBoardiOS21
//
//  Created by Ivan Ramirez on 9/24/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class MessageListTableViewController: UITableViewController {
    @IBOutlet weak var messageTextField: UITextField!
    
    // run the clousre once, in order to not make it so taxing
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ties to notification cent in the message controller
        //observer is where every the part you want to listen is at
        //name has a constant that was made in Message Controller
        //object is nil
        NotificationCenter.default.addObserver(self, selector: #selector(reloadViews), name: MessageController.shared.messagesWereUpdatedNotification, object: nil)
        // show the loading icon working
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        MessageController.shared.fetchMessageRecordsFromiCloud()
    }
    
    //needs to be @objc func
    @objc func reloadViews() {
        DispatchQueue.main.async {
            //this code will turn off the loading icon that is working
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.tableView.reloadData()
        }
    }
    
    @IBAction func postMessageButtonTapped(_ sender: Any) {
        guard let messageText = messageTextField.text else {return}
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        MessageController.shared.saveMessageRecordToiCloudWith(text: messageText)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MessageController.shared.messages.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        let message = MessageController.shared.messages[indexPath.row]
        
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = dateFormatter.string(from: message.timeStamp)
        
        return cell
    }
}
