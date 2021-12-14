//
//  ShoutOutView.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 12/7/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct ShoutOutView: View {
    let ref = Database.database().reference()
    @State private var showingSheet = false
    @State var shoutOutArray = [Any]()
    var body: some View {
       ZStack{
           VStack{
               ScrollView(.vertical, showsIndicators: false){
                   if #available(iOS 14.0, *) {
                       LazyVStack(alignment: .leading, spacing: 0){
                           ForEach(self.shoutOutArray.indices, id: \.self){ index in
                               ShoutOutCard(post: self.shoutOutArray[index] as! [String: Any])
                           }
                       }
                   } else {
                       // Fallback on earlier versions
                   }
               }
           }
           .onAppear(perform: {
               if shoutOutArray.isEmpty {
                   let sorted = ref.child("ShoutOut").queryOrdered(byChild: "timeCreated")
                   sorted.observeSingleEvent(of: .value, with: {(snapshot) in
                       for aPost in snapshot.children.reversed() {
                           let snap = aPost as! DataSnapshot
                           let userDict = snap.value as! [String: Any]
                           self.shoutOutArray.append(userDict)
                       }
                   })
               }
           })
           
           VStack{
               Spacer()
               HStack{
                   Spacer()
                   if #available(iOS 14.0, *) {
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
                           .fullScreenCover(isPresented: $showingSheet, onDismiss: {
//                               self.shoutOutArray.removeAll()
//                               if shoutOutArray.isEmpty {
//                                   let sorted = ref.child("ShoutOut").queryOrdered(byChild: "timeCreated")
//                                   sorted.observeSingleEvent(of: .value, with: {(snapshot) in
//                                       for aPost in snapshot.children.reversed() {
//                                           let snap = aPost as! DataSnapshot
//                                           let userDict = snap.value as! [String: Any]
//                                           self.shoutOutArray.append(userDict)
//                                       }
//                                   })
//                               }
                               DispatchQueue.main.async {
                                   updatePage()
                               }
                               
                           }) {
                               AddShoutOut()
                           }
                   } else {
                       // Fallback on earlier versions
                   }
               }
           }
       }
   }
    
    //update the view when new post is added
    func updatePage() {
        let sorted = ref.child("ShoutOut").child("timeCreated")
        sorted.observe(.childAdded, with: {(post) in
            if !post.exists() {return}
            guard let postDict = post.value as? [String: Any] else {return}
//            let postId = post.key
            print(postDict)
            
//            let topShoutOut = shoutOutArray[0] as! [String: Any]
            
            shoutOutArray.insert(postDict, at: 0)
            
//            if topShoutOut["shoutOutID"] != postDict["shoutOutID"] {
//                shoutOutArray.insert(postDict, at: 0)
//            }
            
//            if topShoutOut != postDict {
//                shoutOutArray.insert(postDict, at: 0)
//            }
            
//            if(!shoutOutArray.contains {($0 as! [String: Any]) == postDict} &&
//               shoutOutArray.contains {($0 as! [String: Any]) != postDict}){
//                shoutOutArray.insert(postDict, at: 0)
//            }
        })
    }
}

struct ShoutOutView_Previews: PreviewProvider {
    static var previews: some View {
        ShoutOutView()
    }
}
