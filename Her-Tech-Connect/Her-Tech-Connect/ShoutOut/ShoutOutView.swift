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
    @ObservedObject var shoutOutArray: AllShoutOuts = AllShoutOuts()
    var body: some View {
       ZStack{
           ScrollView(.vertical, showsIndicators: false){
               if #available(iOS 14.0, *) {
                   LazyVStack(alignment: .leading, spacing: 0){
                       ForEach(self.shoutOutArray.Shoutdata.indices, id: \.self){ index in
                           ShoutOutCard(shoutOut: shoutOutArray.Shoutdata[index])
                       }
                   }
               } else {
                   // Fallback on earlier versions
               }
           }
           .onAppear(perform: {
               if shoutOutArray.Shoutdata.isEmpty {
                   DispatchQueue.main.async {
                       LoadShoutOut()
                       updateShoutOuts()
                   }
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
                               updateShoutOuts()
                               
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
    
    //load the view with existing shoutouts
    func LoadShoutOut() {
        let sorted = ref.child("ShoutOut").queryOrdered(byChild: "timeCreated")
        sorted.observeSingleEvent(of: .value, with: {(post) in
            for aPost in post.children {
                let snap = aPost as! DataSnapshot
                let postDict = snap.value as! [String: Any]
                
                shoutOutArray.Shoutdata.append(ShoutOut(shoutOutID: postDict["shoutOutID"] as! String, posterID: postDict["posterID"] as! String, title: postDict["title"] as! String, story: postDict["story"] as! String, timeCreated: postDict["timeCreated"] as! Double, upvotes: postDict["upVotes"]))
            }
            
//            guard let postDict = post.value as? [String: Any] else {return}
//            print("Here is the key: \(post.key)")
//            print(postDict)
            
//            shoutOutArray.append(postDict)
            shoutOutArray.Shoutdata.reverse()
            
        })
    }
    
    //Update the UI when a new shoutOut is added
    func updateShoutOuts() {
        
        let sorted = ref.child("ShoutOut").queryOrdered(byChild: "timeCreated")
        sorted.observe(.childAdded, with: {(shoutOut) in
            if !shoutOut.exists() {return}
            guard let shoutOutDict = shoutOut.value as? [String: Any] else {return}
            
            print(shoutOutDict)
            
            let newShoutOut = ShoutOut(shoutOutID: shoutOutDict["shoutOutID"] as! String, posterID: shoutOutDict["posterID"] as! String, title: shoutOutDict["title"] as! String, story: shoutOutDict["story"] as! String, timeCreated: shoutOutDict["timeCreated"] as! Double, upvotes: shoutOutDict["upVotes"])
            
            if(!shoutOutArray.Shoutdata.contains(where: {$0.shoutOutID == newShoutOut.shoutOutID}) &&
               shoutOutArray.Shoutdata.contains(where: {$0.shoutOutID != newShoutOut.shoutOutID})){
                shoutOutArray.Shoutdata.insert(newShoutOut, at: shoutOutArray.Shoutdata.count)
            }
        })
    }
}

struct ShoutOutView_Previews: PreviewProvider {
    static var previews: some View {
        ShoutOutView()
    }
}
