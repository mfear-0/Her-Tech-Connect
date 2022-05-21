//
//  UserCard.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/7/21.
//

import SwiftUI
import FirebaseDatabase

@available(iOS 15.0, *)
struct UserCard: View {
    @Environment(\.colorScheme) var colorScheme
    @State var user: User
    @State private var showingSheet = false
    @ObservedObject var chat: Chat = Chat()
    let ref = Database.database().reference()
    var currentUserId: String
    @State var lastMessage = "No mesage to display!"
    @State var time = ""
    var body: some View {
        VStack{
            HStack{
                RoundedImage(urlImage: user.image, imageWidth: 58.0, imageHeight: 58.0)
                    .padding(.trailing, 6)
                VStack(alignment: .leading, spacing: 4.0){
                    HStack{
                        Text(user.name).bold()
                            .font(.system(size: 16))
                            .lineLimit(nil)
        //                    .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(self.time)
                            .font(.system(size: 12))
                            .foregroundColor(colorScheme == .dark ? Color("DarkRed") : .red)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing)
                    }
                    Text(self.lastMessage)
                        .font(.system(size: 16))
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 16)
            .padding([.top, .bottom] , 20)
        }
        
        .onAppear(perform: {
            //Get the last mesage
            getLastMessage()
        })
        .background(RoundedRectangle(cornerRadius: 10).stroke((colorScheme == .dark ? Color("LightBlueSwitch") : Color(UIColor.systemGray6)), lineWidth: 2).background((colorScheme == .dark ? Color("LightBlueSwitch") : Color.white).cornerRadius(10)).shadow(radius: 8))
        .padding()
        .onTapGesture {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet, onDismiss: {
            //Get last message when you get back from the messageView
            getLastMessage()

        }) {
            NavigationView{
                MessageView(currentUserID: currentUserId, receiverEmail: user.email, receiverId: user.userId)
            }
            
        }
    }
    
    func getLastMessage(){
        ref.child("ChatGroup").child(self.currentUserId).child(self.user.userId).observe( .value, with: { (recipientNode) in
            if !recipientNode.exists() {
                Message.newChatWith(senderId: self.currentUserId, recipientId: self.user.userId)
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
                    self.lastMessage = recentMessage.message
                    self.time = (calculateTimeStamp(seconds: recentMessage.timeCreated))
                    
                }
            })
        })
    }
}

struct UserCard_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            UserCard(user: User(userId: "67777", name: "Jennifer Lopez", email: "jLopez@gmail.com", image: "https://cdn.iconscout.com/icon/free/png-256/account-avatar-profile-human-man-user-30448.png", jobDescriotion: "Ios Engineer"), currentUserId: "0118E49C-EADB-4518-95CD-8A37F94080AA")
        } else {
            // Fallback on earlier versions
        }
    }
}
