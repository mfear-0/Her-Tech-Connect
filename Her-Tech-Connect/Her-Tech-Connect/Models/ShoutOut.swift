//
//  ShoutOut.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 12/14/21.
//

import Foundation
import SwiftUI

class ShoutOut: Identifiable, ObservableObject {
    @Published var shoutOutID: String
    @Published var posterID: String
    @Published var title: String
    @Published var story: String
    @Published var timeCreated: Double
    @Published var upVotes: Any!
    
    
    init(shoutOutID: String, posterID: String, title: String, story: String, timeCreated: Double, upvotes: Any!) {
        
        self.shoutOutID = shoutOutID
        self.posterID = posterID
        self.title = title
        self.story = story
        self.timeCreated = timeCreated
        
        if upvotes != nil {
            self.upVotes = upvotes
            
        } else {
            self.upVotes = 0
        }
    }
}

class AllShoutOuts: ObservableObject{
    @Published var Shoutdata: [ShoutOut] = [ShoutOut]()
}
