//
//  ShoutOutCard.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 12/7/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct ShoutOutCard: View {
    @State var imageUrl: String = ""
    let ref = Database.database().reference()
    @State var post = [String: Any]()
    @State var title: String = "I just got a promotion at my Job!😍😍 I am Really excited!"
    @State var voteCount: Int = 100
    @State var posterName: String = "Anic Lopez"
    @State var isLiked: Bool = false
    @State var currentUserID: String = ""
    @State var likesArray =  [String]()
    
    var body: some View {
        VStack{
            
            HStack{
                RoundedImage(urlImage: imageUrl, imageWidth: 58.0, imageHeight: 58.0)
                    .padding(.vertical, 5)
                    .padding(.leading, 5)
                    .padding(.top, 5)
                VStack(alignment: .leading, spacing: 2.0){
                    HStack{
                        Text(posterName).bold()
                            .font(.system(size: 16))
                            .lineLimit(nil)

                        Text(calculateTimeStamp(seconds: self.post["timeCreated"] as! Double))
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .onAppear(perform: {
                ref.child("Users").child(self.post["posterID"] as! String).observeSingleEvent(of: .value, with: {(user) in
                    
                    let userDict = user.value as! [String: Any]
                    self.posterName = userDict["name"] as! String
                    self.imageUrl = userDict["image"] as! String
                })

            })
            
            Text(self.post["title"] as! String)
                .bold()
                .font(.system(size: 18))
                .lineLimit(4)
                .padding(.horizontal)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Read More")
                        .foregroundColor(Color.blue)
                })
                    .padding(.leading, 5)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Button(action: {
                    if self.likesArray.contains(currentUserID){
                        deleteVote()
                    } else {
                        upvote()
                    }
                }, label: {
                    HStack(spacing: 0){
                        //Set up like icon
                        if self.likesArray.contains(currentUserID){
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color.blue)
                                .padding(.trailing, 2)
                        } else {
                            Image(systemName: (self.isLiked ? "heart.fill": "heart" ))
                                .foregroundColor(Color.blue)
                                .padding(.trailing, 2)
                        }
                        Text(getLikesCount())
                            .foregroundColor(Color.blue)
                    }
                    
                })
                    .padding(.trailing, 5)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 5.0)
            .padding(.vertical)
            .frame(alignment: .bottom)
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
                ref.child("ShoutOut").child(self.post["shoutOutID"] as! String).child("upVotes").observeSingleEvent(of: .value, with: {(likers) in
                    for aLiker in likers.children {
                        let snap = aLiker as! DataSnapshot
                        self.likesArray.append(snap.key)
                    }
                })
            }
        })
        .background(RoundedRectangle(cornerRadius: 10).stroke((Color(UIColor.systemGray6)), lineWidth: 2).background((Color.white).cornerRadius(10)).shadow(radius: 8))
        .padding()
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
    
    // Fuction called when a user upvote a post
    func upvote() {
        ref.child("ShoutOut").child(self.post["shoutOutID"] as! String).child("upVotes").child(currentUserID).setValue(currentUserID)
        self.likesArray.append(currentUserID)
        self.isLiked = true
    }
    
    //Function called when a user delete vote
    func deleteVote() {
        
        ref.child("ShoutOut").child(self.post["shoutOutID"] as! String).child("upVotes").observeSingleEvent(of: .value, with: {(likers) in
            for aLiker in likers.children {
                let snap = aLiker as! DataSnapshot
                if currentUserID == snap.key {
                    self.ref.child("ShoutOut").child(self.post["shoutOutID"] as! String + "/upVotes/"+(snap.key)).removeValue()
                }
            }
        })
        self.likesArray.remove(at: self.likesArray.firstIndex(of: currentUserID)!)
        self.isLiked = false
    }
    
}

struct ShoutOutCard_Previews: PreviewProvider {
    static var previews: some View {
        ShoutOutCard()
    }
}