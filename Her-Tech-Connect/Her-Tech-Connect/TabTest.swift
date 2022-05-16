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
    @State private var showingSheet = false
    @State var currentUserId: String = ""
    @State var latestMessages = [Any]()
    @State var name = ""
    @State var email = ""
    @State var image = ""
    @ObservedObject var chat: Chat = Chat()
    var body: some View {
        NavigationView{
            TabView {
                
                HomePage(newShoutouts: newShoutouts, latestMessages: latestMessages).tabItem {
                    Label("Home", systemImage: "house")
                }
                .onAppear(perform: {
                    if newShoutouts.Shoutdata.isEmpty{
                        getEarlyShoutOut()
                        getLatestMessages()
                    }
                })
                
                NetworkView().tabItem{
                    Label("Network", systemImage: "person.3.fill")
                }
                
                NewEventScreen().tabItem {
                    Label("Events", systemImage: "mappin.and.ellipse")
                }
                
                ShoutOutView().tabItem {
                    Label("Shout Outs", systemImage: "megaphone")
                }
                
                MoreView().tabItem {
                    Label("More", systemImage: "line.horizontal.3")
                }
            }
            .onAppear(perform: {
                ref.child("Users").observeSingleEvent(of: .value, with: {(users) in
                    for aUser in users.children {
                        let snap = aUser as! DataSnapshot
                        let userDict = snap.value as! [String: Any]
                        let userEmail = userDict["email"] as! String
                        if userEmail == Auth.auth().currentUser!.email {
                            self.currentUserId = userDict["userId"] as! String
                            self.name = userDict["name"] as! String
                            self.email = userDict["email"] as! String
                            self.image = userDict["image"] as! String
                        }
                    }
                })
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    HStack{
                        RoundedImage(urlImage: self.image , imageWidth: 45.0, imageHeight: 45.0)
                        VStack{
                            Text(self.name)
                                .bold()
                                .font(.system(size: 15))
                                .foregroundColor(Color(UIColor.black))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            Text(self.email)
                                .font(.system(size: 15))
                                .foregroundColor(Color(UIColor.black))
                                                    
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.bottom)
                }
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
    
    //Get the latest Messages
    func getLatestMessages(){
        ref.child("Users").observeSingleEvent(of: .value, with: {(users) in
            for aUser in users.children {
                let snap = aUser as! DataSnapshot
                let userDict = snap.value as! [String: Any]
                let userEmail = userDict["email"] as! String
                if userEmail == Auth.auth().currentUser!.email {
                    self.currentUserId = userDict["userId"] as! String
                    
                    //Get all your connections out of the connection table
                    if latestMessages.isEmpty {
                        ref.child("Connections").child(self.currentUserId).observe(.childAdded, with: {(connections) in
                            
                            if !connections.exists() {return}
                            let connection = connections.key
                            
                            print(connection)
                            
                            //Get connection info
                            ref.child("Users").child(connection).observeSingleEvent(of: .value, with: {(aUser) in

                                DispatchQueue.main.async {
                                    let userDict = aUser.value as! [String: Any]
                                    let userData = User(userId: userDict["userId"] as! String, name: userDict["name"] as! String, email: userDict["email"] as! String, image: userDict["image"] as! String, jobDescriotion: userDict["jobDescription"] as! String)

                                    
                                    ref.child("ChatGroup").child(self.currentUserId).child(userData.userId).observe( .value, with: { (recipientNode) in
                                        if !recipientNode.exists() {
                                            Message.newChatWith(senderId: self.currentUserId, recipientId: userData.userId)
                                        }
                                        
                                        guard let recipientDictionary = recipientNode.value as? [String: String] else {return}
                                        let chatID = recipientDictionary["chatID"]!
                                        let sorted = self.ref.child("Chats").child(chatID).queryOrdered(byChild: "timeCreated")
                                        
                                        //Listen for new messages and only return new messages
                                        sorted.observeSingleEvent(of: .value, with: { (messagesSnapshot) in
                                            
                                            if messagesSnapshot.exists(){
                                                for snapshot in messagesSnapshot.children{
                                                    let snap = snapshot as! DataSnapshot
                                                    let messageDict = snap.value as! [String: Any]
                                                    
                                                    self.chat.data.append(Message(senderId: messageDict["senderId"] as! String, senderName: messageDict["senderName"] as! String, message: messageDict["message"] as! String, type: messageDict["type"] as! String, timeCreated: messageDict["timeCreated"] as! Double))
                                                }
                                                //Get the last message from the array
                                                let recentMessage = self.chat.data.last!
                                                
                                                //Add last message to users latest array
                                                let userLatest: [String: Any] = [
                                                    "currentUserId" : self.currentUserId,
                                                    "recieverId" : userData.userId,
                                                    "recieverName" : userData.name,
                                                    "recieverEmail" : userData.email,
                                                    "recieverImage" : userData.image,
                                                    "lastMessage" : recentMessage.message,
                                                    "time": recentMessage.timeCreated
                                                    
                                                ]
                                                latestMessages.append(userLatest)
                                                
                                            }
                                            print(latestMessages)
                                            let sortedlatestMessages = latestMessages.sorted(by:{(time1, time2) -> Bool in
                                                return ((time1 as! NSDictionary).value(forKey: "time") as! Double) < ((time2 as! NSDictionary).value(forKey: "time") as! Double)})
                                            latestMessages.removeAll()
                                            latestMessages = sortedlatestMessages
                                            print(latestMessages)
                                        })
                                    })
                                }

                            })
                            
                        })
                    }
                }
            }
        })
    }
}

struct TabTest_Previews: PreviewProvider {
    static var previews: some View {
        TabTest()
    }
}
