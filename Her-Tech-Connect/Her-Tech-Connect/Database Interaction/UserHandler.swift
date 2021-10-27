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
    
    static func addUser(name: String, email: String, image: String) {
        let user: [String: Any] = [
            "userId": userId,
            "name": name,
            "email": email,
            "image": image
        ]
        
        ref.child("Users").child(userId).setValue(user)
    }
}
