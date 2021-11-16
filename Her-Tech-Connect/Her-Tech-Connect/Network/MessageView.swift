//
//  MessageView.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/7/21.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

@available(iOS 15.0, *)
struct MessageView: View {
    @State var messageText = ""
    @State var showSubTextView = false
    let ref = Database.database().reference()
    lazy var messages: [Any] = []
    let currentUserEmail = Auth.auth().currentUser!.email
    var receiverEmail: String
    var recieverId: String
    
    @Environment(\.dismiss) var dismiss
    var btnBack : some View { Button(action: {
        dismiss()
        }) {
            HStack {
            ImageButton(image: "arrow.backward", imageWidth: 20, imageHeight: 20)
            }
        }
    }
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                })
                ZStack{
                    VStack{
                        Divider()
                            .frame(height: 1)
                        HStack{
                            emojiButton("😍")
                            emojiButton("🥰")
                            emojiButton("🤩")
                            emojiButton("🛩")
                            emojiButton("✈️")
                            emojiButton("😎")
                            emojiButton("❤️")
                            emojiButton("😂")
                            emojiButton("🤯")
                        }
                        .clipped()
                        .shadow(radius: 5)
                        .padding(.horizontal, 10.0)
                        .padding(.vertical, 2.0)
                        .frame(maxWidth: .infinity, alignment: .center)
                        HStack{
                            RoundedImage(urlImage: "https://cdn.iconscout.com/icon/free/png-256/account-avatar-profile-human-man-user-30448.png", imageWidth: 45, imageHeight: 45)
                            HStack{
                                TextField("Add a Comment...", text: $messageText)
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "paperplane")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color(UIColor.systemPink))
                                })
                                .padding(.trailing, 5)
                            }
                            .padding(12)
                            .overlay(RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color(UIColor.systemPink), lineWidth: 1))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.trailing)
                        }
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .padding(.leading)
                    }
                }
                .padding(.bottom, 8.0)
                .background(Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color(.systemTeal).ignoresSafeArea())
            .gesture(
                DragGesture()
                        .onChanged({_ in
                            self.showSubTextView = false
                            hideKeyboard()
                        }))
        }
        .navigationTitle("Message")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack)
    }
    
    /*
     Emoji button to add preloaded emoji to your comment
     */
    func emojiButton(_ emoji: String) -> Button<Text> {
        Button {
            if self.showSubTextView == false {
                self.showSubTextView = true
            }
            self.messageText += emoji
        } label: {
            Text(emoji)
                .font(.system(size: 33))
        }
    }
    
    //Retrieves messages between a single user and recipient while declaring a listener and sorting the messages by time.
    func getMessages(uid: String) {
        //Get the chatID for this user and recipient
        ref.child("ChatGroup").child(currentUserEmail!).child(receiverEmail).observe( .value, with: { (recipientNode) in
            if !recipientNode.exists() {
                Message.newChatWith(senderEmail: currentUserEmail!, recipientEmail: receiverEmail)
            }
            //ensure the recipientNode value is imported as a String Dictionary, otherwise return
            guard let recipientDictionary = recipientNode.value as? [String: String] else {return}
            //Get the chatID
            let chatID = recipientDictionary["chatID"]!
            //Sort the chats by time
            let sorted = self.ref.child("Chats").child(chatID).queryOrdered(byChild: "time")
            //Listen for new messages and only return new messages
            sorted.observe(.childAdded, with: { (messageSnapshot) in
                //If no messages, skip import
                if !messageSnapshot.exists() { return }
                //import messages as a Dictionary with String keys
                //NOTE: messageDictionary has String keys for Dictionary objects
                guard let messageDictionary = messageSnapshot.value as? [String: Any] else {return}
                //Store messageDictionary
//                self.messages.append(messageDictionary)
//                self.messages.append(messageDictionary)
//                self.tableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .none, animated: false)
                
            })
        })
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            MessageView(receiverEmail: "janedoe@outlook.com", recieverId: "0118E49C-EADB-4518-95CD-8A37F94080AA")
        } else {
            // Fallback on earlier versions
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
