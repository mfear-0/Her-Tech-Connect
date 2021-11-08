//
//  MessageView.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/7/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct MessageView: View {
    @State var messageText = ""
    @State var showSubTextView = false
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
            .background(Color(.systemTeal).ignoresSafeArea())
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
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            MessageView()
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
