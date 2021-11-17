//
//  UserCard.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/7/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct UserCard: View {
    @State var user: User
    @State private var showingSheet = false
    var currentUserId: String
    let lastMessage = "How are you"
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
                        
                        Text("11:00 PM")
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing)
                    }
                    Text("\(lastMessage) \(user.name)?")
                        .font(.system(size: 16))
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 16)
            .padding([.top, .bottom] , 20)
        }
        .background(RoundedRectangle(cornerRadius: 10).stroke((Color(UIColor.systemGray6)), lineWidth: 2).background((Color.white).cornerRadius(10)).shadow(radius: 8))
        .padding()
        .onTapGesture {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            NavigationView{
                MessageView(currentUserID: currentUserId, receiverEmail: user.email, receiverId: user.userId)
            }
            
        }
    }
}

struct UserCard_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            UserCard(user: User(userId: "67777", name: "Jennifer Lopez", email: "jLopez@gmail.com", image: "https://cdn.iconscout.com/icon/free/png-256/account-avatar-profile-human-man-user-30448.png", jobDescriotion: "Ios Engineer", connection: ["":""]), currentUserId: "0118E49C-EADB-4518-95CD-8A37F94080AA")
        } else {
            // Fallback on earlier versions
        }
    }
}
