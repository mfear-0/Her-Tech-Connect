//
//  User.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/25/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

class User: Identifiable, ObservableObject {
    @Published var userId: String
    @Published var name: String
    @Published var email: String
    @Published var image: String
    @Published var jobDescription: String
    @Published var connection: [String: Any]
    
    init(userId: String, name: String, email: String, image: String, jobDescriotion: String, connection: [String: Any]){
        self.userId = userId
        self.name = name
        self.email = email
        self.image = image
        self.jobDescription = jobDescriotion
        self.connection = connection
    }
}
