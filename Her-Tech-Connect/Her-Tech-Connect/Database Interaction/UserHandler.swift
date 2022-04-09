//
//  UserHandler.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/25/21.
//  Modified by Arica Conrad on 11/8/21.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class UserHandler {
    static let userId = UUID().uuidString
    static let ref = Database.database().reference()
    
    /*
     Add user to the database
     */
    static func addUser(name: String, email: String, image: String) {
        let user: [String: Any] = [
            "userId": userId,
            "name": name,
            "email": email,
            "image": image,
            "jobDescription": "",
            "connections": ["connection1": ""]
        ]
        
        ref.child("Users").child(userId).setValue(user)
    }
    
    /*
     Add Connection to a user
     */
    static func addConnection(currentUserId: String, connectionId: String) {
        
        ref.child("Connections").child(currentUserId).child(connectionId).setValue(connectionId)
    }
    
    /*
     update User info
     */
    static func updateUserInfo(userId: String, userName: String, userEmail: String, image: String, jobDescription: String){
        let updateUserInfo: [String: Any] = [
            "userId": userId,
            "name": userName,
            "email": userEmail,
            "image": image,
            "jobDescription": jobDescription
        ]
        ref.child("Users").child(userId).setValue(updateUserInfo)
    }
    /*
     Create a shout out post
     */
    static func createShoutOut(posterId: String ,title: String, story: String, image: String){
        let shoutOutID = UUID().uuidString
        let newShoutOut: [String: Any] = [
            "shoutOutID": shoutOutID,
            "posterID": posterId,
            "title": title,
            "story": story,
            "timeCreated": Date().timeIntervalSince1970,
            "upVotes": 0,
            "image": image
        ]
        
        ref.child("ShoutOut").child(shoutOutID).setValue(newShoutOut)
    }
}
