//
//  ConnectionCard.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/18/21.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct ConnectionCard: View {
    @State var user: User
    let ref = Database.database().reference()
    @State var currentUserId: String = ""
    
    var body: some View {
        VStack{
            HStack{
                RoundedImage(urlImage: user.image, imageWidth: 58.0, imageHeight: 58.0)
                    .padding(.trailing, 6)
                VStack(alignment: .leading, spacing: 4.0){
                    Text(user.name).bold()
                        .font(.system(size: 16))
                        .lineLimit(nil)
                    Text(user.email)
                        .font(.system(size: 16))
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: {
                    UserHandler.addConnection(currentUserId: currentUserId, connectionId: user.userId)
                }, label: {
                    HStack{
                        Image(systemName: "plus")
                            .font(.system(size: 15))
                            .foregroundColor(Color.blue)
                        Text("CONNECT")
                            .font(.system(size: 15))
                            .foregroundColor(Color.blue)
                            .padding(.trailing)
                    }
                    
                })
            }
            .padding(.leading, 16)
            .padding([.top, .bottom] , 20)
        }
    }
}

struct ConnectionCard_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionCard(user: User(userId: "67777", name: "Jennifer Lopez", email: "jLopez@gmail.com", image: "https://cdn.iconscout.com/icon/free/png-256/account-avatar-profile-human-man-user-30448.png", jobDescriotion: "Ios Engineer"), currentUserId: "0118E49C-EADB-4518-95CD-8A37F94080AA")
    }
}
