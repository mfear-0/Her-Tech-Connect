//
//  Message.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/14/21.
//

import Foundation
import SwiftUI
import FirebaseDatabase

class Message: Identifiable {
    var senderId: String
    var senderName: String
    var message: String
    var type: String
    var timeCreated: Double
    var content: [String:Any] //Dictionary that stores all of the Message's content which can be accessed by calling Message.content["key for what you'd like to access"]
    static let ref = Database.database().reference()
    
    init(senderId: String, senderName:String, message: String, type: String, timeCreated: Double) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        self.senderId = senderId
        self.senderName = senderName
        self.message = message
        self.type = type
        self.timeCreated = timeCreated
        self.content = ["senderId":self.senderId,
                        "senderName":self.senderName,
                        "message":self.message,
                        "type":self.type,
                        "timeCreated":self.timeCreated
        ]
    }
    
    /*
     Send message to the recipient
     */
    static func sendTo(recipientId: String, message: Message) {
        
        Message.ref.child("ChatGroup").child(message.senderId).child(recipientId).observeSingleEvent(of: .value, with: {(recipientNode) in
            //if conversation already exists
            if recipientNode.hasChildren() {
                let recipientDictionary = recipientNode.value as! [String:String]
                let chatID = recipientDictionary["chatID"]!
                //append message to existing conversation
                Message.ref.child("Chats").child(chatID).childByAutoId().setValue(message.content)
                //else
            } else {
                //create new conversation
                Message.newChatWith(senderId: message.senderId, recipientId: recipientId)
                //retry send message
                self.sendTo(recipientId: recipientId, message: message)
            }
            
        })
    }
    
    /*
     Create a new chat
     */
    static func newChatWith(senderId: String, recipientId: String) {
        //new child node for Chats/(chatID = autogenerated)
        let newChat: [String:Any] = ["chatID": Message.ref.child("Chats").childByAutoId().key!]
        //new child node for Members/senderUserID/(recipientUserID)
        Message.ref.child("ChatGroup").child(senderId).child(recipientId).setValue(newChat)
        //new child node for Members/recipientUserID/(senderUserID)
        Message.ref.child("ChatGroup").child(recipientId).child(senderId).setValue(newChat)
    }
}