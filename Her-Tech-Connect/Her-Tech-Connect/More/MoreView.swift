//
//  MoreView.swift
//  Her-Tech-Connect
//
//  Created by Hans Mandt on 11/12/21.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth


struct MoreView: View {
    let ref = Database.database().reference()
    @State var userId: String = ""
    @State var userName: String = ""
    @State var userImage: String = ""
    @State var jobDescription: String = ""
    @State var userEmail: String = ""
    
    var body: some View {
        VStack {
            VStack{
                RoundedImage(urlImage: self.userImage, imageWidth: 120, imageHeight: 120)
                Text(self.userName)
                    .bold()
                    .font(.system(size: 22))
                Text(self.userEmail)
                    .font(.system(size: 14))
                Text(self.jobDescription)
                    .font(.system(size: 14))
                
            }
            .frame(maxWidth: .infinity, maxHeight: 250)
            .background((Color.white).cornerRadius(35, corners: [.bottomRight, .bottomLeft]))
            .onAppear(perform: {
                ref.child("Users").observeSingleEvent(of: .value, with: {(users) in
                    for aUser in users.children {
                        let snap = aUser as! DataSnapshot
                        let userDict = snap.value as! [String: Any]
                        let userEmail = userDict["email"] as! String
                        
                        if userEmail == Auth.auth().currentUser!.email {
                            self.userId = userDict["userId"] as! String
                            self.userName = userDict["name"] as! String
                            self.userImage = userDict["image"] as! String
                            self.jobDescription = userDict["jobDescription"] as! String
                            self.userEmail = userDict["email"] as! String
                        }
                        
                    }
                })
            })
            
            Form {
                
                NavigationLink(destination: ProfileView()){
                    Image(systemName: "person")
                    Text("My Profile")
                }
                
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
            .padding(.top, 20)
        
        
        }
        .background(Color(UIColor.systemGray6))
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
