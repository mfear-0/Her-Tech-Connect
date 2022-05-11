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
    @ObservedObject var newShoutouts: AllShoutOuts = AllShoutOuts()
    var body: some View {
       ZStack{
           ScrollView(.vertical, showsIndicators: false){
               RefreshControl(coordinateSpace: .named("RefreshControl")) {
                   //refresh view
                   DispatchQueue.main.async {
//                       LoadShoutOut()
                       updateShoutOuts()
                   }
                   
               }
               
               if #available(iOS 14.0, *) {
                   if !newShoutouts.Shoutdata.isEmpty{
                       LazyVStack(alignment: .leading, spacing: 0){
                           ForEach(self.newShoutouts.Shoutdata.indices, id: \.self){ index in
                               ShoutOutCard(shoutOut: newShoutouts.Shoutdata[index])
                           }
                       }
                       
                       HStack{
                           Rectangle()
                               .fill(Color.blue)
                               .frame(maxWidth: .infinity, maxHeight: 2.0)
                           Text("new")
                               .foregroundColor(Color.blue)
                           Rectangle()
                               .fill(Color.blue)
                               .frame(maxWidth: .infinity, maxHeight: 2.0)
                       }
                       .padding()
                   }
                   
                   LazyVStack(alignment: .leading, spacing: 0){
                       ForEach(self.shoutOutArray.Shoutdata.indices, id: \.self){ index in
                           ShoutOutCard(shoutOut: shoutOutArray.Shoutdata[index])
                       }
                   }
               } else {
                   // Fallback on earlier versions
               }
           }
           .coordinateSpace(name: "RefreshControl")
           .onAppear(perform: {
               if shoutOutArray.Shoutdata.isEmpty {
                   DispatchQueue.main.async {
                       LoadShoutOut()
//                       updateShoutOuts()
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
                
                if let image = postDict["image"] as? String {
                    shoutOutArray.Shoutdata.append(ShoutOut(shoutOutID: postDict["shoutOutID"] as! String, posterID: postDict["posterID"] as! String, title: postDict["title"] as! String, story: postDict["story"] as! String, timeCreated: postDict["timeCreated"] as! Double, upvotes: postDict["upVotes"], image: image))
                } else {
                    shoutOutArray.Shoutdata.append(ShoutOut(shoutOutID: postDict["shoutOutID"] as! String, posterID: postDict["posterID"] as! String, title: postDict["title"] as! String, story: postDict["story"] as! String, timeCreated: postDict["timeCreated"] as! Double, upvotes: postDict["upVotes"], image: ""))

                }
                
            }
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
            
            if let image = shoutOutDict["image"] as? String{
                let newShoutOut = ShoutOut(shoutOutID: shoutOutDict["shoutOutID"] as! String, posterID: shoutOutDict["posterID"] as! String, title: shoutOutDict["title"] as! String, story: shoutOutDict["story"] as! String, timeCreated: shoutOutDict["timeCreated"] as! Double, upvotes: shoutOutDict["upVotes"], image: image)
                
                if(!shoutOutArray.Shoutdata.contains(where: {$0.shoutOutID == newShoutOut.shoutOutID}) &&
                   shoutOutArray.Shoutdata.contains(where: {$0.shoutOutID != newShoutOut.shoutOutID})){

                    if(!newShoutouts.Shoutdata.contains(where: {$0.shoutOutID == newShoutOut.shoutOutID}) ||
                       newShoutouts.Shoutdata.contains(where: {$0.shoutOutID != newShoutOut.shoutOutID})){
                        newShoutouts.Shoutdata.append(newShoutOut)
                    }
                }
            } else {
                let newShoutOut = ShoutOut(shoutOutID: shoutOutDict["shoutOutID"] as! String, posterID: shoutOutDict["posterID"] as! String, title: shoutOutDict["title"] as! String, story: shoutOutDict["story"] as! String, timeCreated: shoutOutDict["timeCreated"] as! Double, upvotes: shoutOutDict["upVotes"], image: "")
                
                
                if(!shoutOutArray.Shoutdata.contains(where: {$0.shoutOutID == newShoutOut.shoutOutID}) &&
                   shoutOutArray.Shoutdata.contains(where: {$0.shoutOutID != newShoutOut.shoutOutID})){
                    
                    if(!newShoutouts.Shoutdata.contains(where: {$0.shoutOutID == newShoutOut.shoutOutID}) ||
                       newShoutouts.Shoutdata.contains(where: {$0.shoutOutID != newShoutOut.shoutOutID})){
                        newShoutouts.Shoutdata.append(newShoutOut)
                    }
                }
            }
            
        })
    }
}

struct ShoutOutView_Previews: PreviewProvider {
    static var previews: some View {
        ShoutOutView()
    }
}
