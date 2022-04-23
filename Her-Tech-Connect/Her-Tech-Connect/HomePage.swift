//
//  HomePage.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/23/21.
//  Modified by Arica Conrad on 12/15/21.
//  Modified by Natalman Nahm on 04/22/22

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct HomePage: View {
    @ObservedObject var newShoutouts: AllShoutOuts = AllShoutOuts()
    let ref = Database.database().reference()
    @State private var showingSheet = false
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        
//        VStack {
//
//            // Arica: A decorative ombre band across the top that showcases the app's colors.
//            ZStack {
//
//                Rectangle()
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color("LightBlue"), Color("LightYellow")]), startPoint: .leading, endPoint: .trailing))
//                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 20)
//            }
//
//            Spacer()
//
//            ScrollView {
//
//                VStack {
//
//                    // Arica: The title text.
//                    Text("Welcome to Her Tech Connect!")
//                        .foregroundColor(Color("DarkBlue"))
//                        .font(.title2)
//                        .padding()
//
//                    // Arica: Instructional text for the users.
//                    Text("Here are the highlights of what happened while you were away:")
//                        .foregroundColor(Color("Black"))
//                        .font(.body)
//                        .padding()
//
//                    // Arica: The temporary location of the log out button. Please move to the bottom of the More tab.
//                    Button(action: {
//                        viewModel.signOut()
//                    }, label: {
//                        Text("Log Out")
//                            .padding()
//                            .foregroundColor(Color("Black"))
//                            .font(.title3)
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            .background(Color("LightBlueSwitch"))
//                            .cornerRadius(40)
//                            .overlay( RoundedRectangle(cornerRadius: 40)
//                            .stroke(Color("LightBlue"), lineWidth: 4))
//                    })
//                    .padding()
//
//                    Spacer()
//                }
//            }
//        }
        
        ZStack{
            VStack{
                ScrollView(.vertical, showsIndicators: false){
                    
                    RefreshControl(coordinateSpace: .named("RefreshControl")) {
                        //refresh view
                        newShoutouts.Shoutdata.removeAll()
                        DispatchQueue.main.async {
                            getEarlyShoutOut()
                        }
                        
                    }
                    
                    HStack{
                        Rectangle()
                            .fill(Color.blue)
                            .frame(maxWidth: .infinity, maxHeight: 2.0)
                        Text("Latest Shoutouts")
                            .font(.system(size: 15))
                            .foregroundColor(Color.blue)
                        Rectangle()
                            .fill(Color.blue)
                            .frame(maxWidth: .infinity, maxHeight: 2.0)
                    }
                    .padding()
                    
                    LazyVStack(alignment: .leading, spacing: 0){
                        ForEach(newShoutouts.Shoutdata.indices.prefix(2), id: \.self){ index in
                            ShoutOutCard(shoutOut: newShoutouts.Shoutdata[index])
                        }
                    }
                    .onAppear(perform: {
                        if newShoutouts.Shoutdata.isEmpty{
                            getEarlyShoutOut()
                        }
                    })
                    
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Log Out")
                            .padding()
                            .foregroundColor(Color("Black"))
                            .font(.title3)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("LightBlueSwitch"))
                            .cornerRadius(40)
                            .overlay( RoundedRectangle(cornerRadius: 40)
                            .stroke(Color("LightBlue"), lineWidth: 4))
                    })
                    .padding()
                }
                .coordinateSpace(name: "RefreshControl")
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
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
