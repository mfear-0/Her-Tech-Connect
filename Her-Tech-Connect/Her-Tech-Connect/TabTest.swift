//
//  TabTest.swift
//  Her-Tech-Connect
//
//  Created by Student Account on 10/24/21.
//  Modified by Arica Conrad on 12/15/21.
//  Modified by Natalman Nahm on 04/22/22

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct TabTest: View {
    @ObservedObject var newShoutouts: AllShoutOuts = AllShoutOuts()
    let ref = Database.database().reference()
    var body: some View {
        TabView {
            
            HomePage(newShoutouts: newShoutouts).tabItem {
                Label("Home", systemImage: "house")
            }
            .onAppear(perform: {
                if newShoutouts.Shoutdata.isEmpty{
                    getEarlyShoutOut()
                }
            })
            
            NetworkView().tabItem{
                Label("Network", systemImage: "person.3.fill")
            }
            
            EventView().tabItem {
                Label("Events", systemImage: "mappin.and.ellipse")
            }
            
            ShoutOutView().tabItem {
                Label("Shout Outs", systemImage: "megaphone")
            }
            
            MoreView().tabItem {
                Label("More", systemImage: "line.horizontal.3")
            }
        }
    }
    
    //load the view with existing shoutouts
    func getEarlyShoutOut() {
        let sorted = ref.child("ShoutOut").queryOrdered(byChild: "timeCreated")
        sorted.observeSingleEvent(of: .value, with: {(post) in
            for aPost in post.children {
                let snap = aPost as! DataSnapshot
                let postDict = snap.value as! [String: Any]
                
                if let image = postDict["image"] as? String {
                    newShoutouts.Shoutdata.append(ShoutOut(shoutOutID: postDict["shoutOutID"] as! String, posterID: postDict["posterID"] as! String, title: postDict["title"] as! String, story: postDict["story"] as! String, timeCreated: postDict["timeCreated"] as! Double, upvotes: postDict["upVotes"], image: image))
                } else {
                    newShoutouts.Shoutdata.append(ShoutOut(shoutOutID: postDict["shoutOutID"] as! String, posterID: postDict["posterID"] as! String, title: postDict["title"] as! String, story: postDict["story"] as! String, timeCreated: postDict["timeCreated"] as! Double, upvotes: postDict["upVotes"], image: ""))

                }
            }
            newShoutouts.Shoutdata.reverse()
            
        })
    }
}

struct TabTest_Previews: PreviewProvider {
    static var previews: some View {
        TabTest()
    }
}
