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
    @State var currentUserId: String = ""
    @State private var showingSheet = false
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                LazyVStack(alignment: .leading, spacing: 0, content: {
                    ForEach(self.usersArray.indices, id: \.self){ index in
                        if #available(iOS 15.0, *) {
                            UserCard(user: self.usersArray[index], currentUserId: self.currentUserId)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                })
                .onAppear(perform: {
                    
                    //Get the Current User Id
                    ref.child("Users").observeSingleEvent(of: .value, with: {(users) in
                        for aUser in users.children {
                            let snap = aUser as! DataSnapshot
                            let userDict = snap.value as! [String: Any]
                            let userEmail = userDict["email"] as! String
                            if userEmail == Auth.auth().currentUser!.email {
                                self.currentUserId = userDict["userId"] as! String
                                
                                //Get all your connections out of the connection table
                                if usersArray.isEmpty {
                                    ref.child("Connections").child(self.currentUserId).observe(.childAdded, with: {(connections) in
                                        
                                        if !connections.exists() {return}
                                        let connection = connections.key
                                        
                                        print(connection)
                                        
                                        //Get connection info
                                        ref.child("Users").child(connection).observeSingleEvent(of: .value, with: {(aUser) in

                                            DispatchQueue.main.async {
                                                let userDict = aUser.value as! [String: Any]
                                                let userData = User(userId: userDict["userId"] as! String, name: userDict["name"] as! String, email: userDict["email"] as! String, image: userDict["image"] as! String, jobDescriotion: userDict["jobDescription"] as! String)
                                                self.usersArray.append(userData)
                                            }

                                        })
                                        
                                    })
                                }
                            }
                        }
                    })
                })
            })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .frame(width: 60, height: 60)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                        .padding()
                        .shadow(radius: 2)
                        .onTapGesture {
                            showingSheet.toggle()
                        }
                        .fullScreenCover(isPresented: $showingSheet) {
                            NavigationView{
                                if #available(iOS 15.0, *) {
                                    ConnectionView()
                                } else {
                                    // Fallback on earlier versions
                                }
                            }
                            
                        }
                }
            }
        }
//            .background(Color(.systemTeal).ignoresSafeArea())
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView()
    }
}
