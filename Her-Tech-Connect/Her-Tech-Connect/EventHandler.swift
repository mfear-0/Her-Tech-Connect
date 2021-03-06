//
//  EventHandler.swift
//  Her-Tech-Connect
//
//  Created by Student Account on 12/8/21.
//

import Foundation
import FirebaseDatabase

class EventHandler {
    static let eventID = UUID().uuidString
    static let ref = Database.database().reference()
    
    static func addEvent(name: String, address: String, date: String, time:String) {
        print("Reached event handler")
        
        let event: [String: Any] = [
            "eventID": eventID,
            "name": name,
            "date": date,
            "time": time,
            "address": address
            
        ]
        
        ref.child("Events").child(eventID).setValue(event)
    }
    
    static func schedEvent(userId: String, eventId: String) {
        let schId = UUID().uuidString
        
        let schedule: [String: Any] = [
            "schId": schId,
            "userId": userId,
            "eventId": eventId
        ]
        
        ref.child("Schedule").child(schId).setValue(schedule)
    }
    
}
