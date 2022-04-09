//
//  ShoutOutDetailView.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 12/15/21.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct ShoutOutDetailView: View {
    
    @State var shoutOut: ShoutOut
    @State var posterName: String = ""
    @State var imageUrl: String = ""
    let ref = Database.database().reference()
    @State var currentUserID: String = ""
    @State var likesArray =  [String]()
    
    var body: some View {
        VStack(spacing: 5){
            
            HStack{
                Text("by \(posterName)")
                    .font(.system(size: 16))
                    .lineLimit(nil)
                
                RoundedImage(urlImage: imageUrl, imageWidth: 30.0, imageHeight: 30.0)
//                    .padding(.vertical, 5)
//                    .padding(.leading, 5)
//                    .padding(.top, 5)
                    
            }
            .padding(.horizontal)
            .padding(.bottom, 2)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            
            if #available(iOS 15.0, *) {
                if shoutOut.image != "" {
                    AsyncImage(url: URL(string: shoutOut.image), content: { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipShape(Rectangle())
                            .shadow(radius: 10)
                        
                    },
                       placeholder: {
                        ProgressView()
                    })
                }
            } else {
                // Fallback on earlier versions
            }
            
            HStack(spacing: 0){
                
                if self.likesArray.contains(currentUserID){
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 14, height: 14)
                        .foregroundColor(Color.blue)
                        .padding(.trailing, 2)
                } else {
                    Image(systemName: "heart" )
                        .resizable()
                        .frame(width: 14, height: 14)
                        .foregroundColor(Color.blue)
                        .padding(.trailing, 2)
                }
                Text(getLikesCount())
                    .font(.system(size: 14))
                    .foregroundColor(Color.blue)
                
                Text(calculateTimeStamp(seconds: shoutOut.timeCreated))
                    .font(.system(size: 14))
                    .foregroundColor(.red)
                    .padding(.horizontal)
                
            }
            .padding(.bottom)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text(shoutOut.title)
                .bold()
                .font(.system(size: 24))
                .lineLimit(nil)
                .padding(.top, 10)
                .padding(.horizontal)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            
            
            
            Text("Story")
                .bold()
                .font(.system(size: 18))
                .padding(.top, 3)
            
            Text(shoutOut.story)
                .font(.system(size: 18))
                .lineLimit(nil)
//                .padding(.top, 0.5)
                .padding(.horizontal, 12)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
        }
        .onAppear(perform: {
            
            //Get the current User ID
            ref.child("Users").observeSingleEvent(of: .value, with: {(users) in
                for aUser in users.children {
                    let snap = aUser as! DataSnapshot
                    let userDict = snap.value as! [String: Any]
                    let userEmail = userDict["email"] as! String
                    if userEmail == Auth.auth().currentUser!.email {
                        self.currentUserID = userDict["userId"] as! String
                    }
                }
            })
            
            //Get all likers of this post
            if self.likesArray.isEmpty{
                ref.child("ShoutOut").child(shoutOut.shoutOutID).child("upVotes").observeSingleEvent(of: .value, with: {(likers) in
                    for aLiker in likers.children {
                        let snap = aLiker as! DataSnapshot
                        self.likesArray.append(snap.key)
                    }
                })
            }
            
            ref.child("Users").child(shoutOut.posterID).observeSingleEvent(of: .value, with: {(user) in
                
                let userDict = user.value as! [String: Any]
                self.posterName = userDict["name"] as! String
                self.imageUrl = userDict["image"] as! String
            })

        })
    }
    
    //Get likes count
    func getLikesCount() -> String {
        if self.likesArray.count == 0 {
            return "No Upvote"
        } else if self.likesArray.count == 1{
            return "1 Upvote"
        } else {
            return "\(self.likesArray.count) Upvotes"
        }
    }
}

struct ShoutOutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShoutOutDetailView(shoutOut: ShoutOut(shoutOutID: "081E69E7-C3EC-474E-83BE-529BE037E9C4", posterID: "8AB3D92B-E08E-4213-A803-B644C1F2CCE0", title: "I love designing!", story: "I may not like Programming, But I like Designing UI.💡💡", timeCreated: 1639521939.7025862, upvotes: [0], image: "https://firebasestorage.googleapis.com:443/v0/b/her-tech-connect.appspot.com/o/shoutoutImage%2FEEAA04AE-F430-40DB-B541-9231554C31BC.jpg?alt=media&token=8f2a40c2-eec8-482a-9b54-ce4cc257abd1"))
    }
}
