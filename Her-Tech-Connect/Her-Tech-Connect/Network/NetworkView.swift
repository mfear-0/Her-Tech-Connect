//
//  NetworkView.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/7/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct NetworkView: View {
    @State var usersArray: [User] = []
    let ref = Database.database().reference()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack(alignment: .leading, spacing: 0, content: {
                ForEach(self.usersArray.indices, id: \.self){ index in
                    if #available(iOS 15.0, *) {
                        UserCard(user: self.usersArray[index])
                    } else {
                        // Fallback on earlier versions
                    }
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
                                let userData = User(userId: userDict["userId"] as! String, name: userDict["name"] as! String, email: userEmail, image: userDict["image"] as! String, jobDescriotion: userDict["jobDescription"] as! String, connection: userDict["connections"] as! [String: Any])
                                
                                self.usersArray.append(userData)
                            }
                        }
                    })
                }
            })
        })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color(.systemTeal).ignoresSafeArea())
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView()
    }
}
