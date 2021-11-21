//
//  ConnectionView.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/18/21.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

@available(iOS 15.0, *)
struct ConnectionView: View {
    @State var usersArray: [User] = []
    let ref = Database.database().reference()
    @State var currentUserId: String = ""
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
        
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack(alignment: .leading, spacing: 0, content: {
                ForEach(self.usersArray.indices, id: \.self){ index in
                    ConnectionCard(user: self.usersArray[index], currentUserId: self.currentUserId)
                }
            })
            .onAppear(perform: {
                if usersArray.isEmpty {
                    ref.child("Users").observeSingleEvent(of: .value, with: {(users) in
                        for aUser in users.children {
                            let snap = aUser as! DataSnapshot
                            let userDict = snap.value as! [String: Any]
                            let userEmail = userDict["email"] as! String
                            
                            if userEmail != Auth.auth().currentUser!.email {
                                let userData = User(userId: userDict["userId"] as! String, name: userDict["name"] as! String, email: userEmail, image: userDict["image"] as! String, jobDescriotion: userDict["jobDescription"] as! String)
                                
                                self.usersArray.append(userData)
                            }
                            
                            if userEmail == Auth.auth().currentUser!.email {
                                self.currentUserId = userDict["userId"] as! String
                            }
                            
                        }
                    })
                }
            })
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Connections")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack)
    }
}

@available(iOS 15.0, *)
struct ConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionView()
    }
}
