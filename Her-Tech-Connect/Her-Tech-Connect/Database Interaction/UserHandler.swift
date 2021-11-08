//
//  UserHandler.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/25/21.
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
            "connections": ["": ""]
        ]
        
        ref.child("Users").child(userId).setValue(user)
    }
}
