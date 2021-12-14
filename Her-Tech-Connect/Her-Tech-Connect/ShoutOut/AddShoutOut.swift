//
//  AddShoutOut.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 12/11/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct AddShoutOut: View {
    let ref = Database.database().reference()
    @Environment(\.presentationMode) var presentationMode
    @State var areFieldEmpty: Bool = false
    @State var title: String = ""
    @State var story: String = ""
    @State var posterID: String = ""
    
    var body: some View {
        VStack{
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.red)
            })
                .padding([.trailing, .top])
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            
            Text("Create a Shout Out")
                .bold()
                .font(.title)
                .padding(.top, 5)
            
            VStack(alignment: .leading) {
                
                Text("Title")
                    .foregroundColor(Color("Black"))
                    .font(.body)
                
                HStack {
                    
                    Image(systemName: "pencil.tip")
                        .foregroundColor(Color("DarkBlue"))
                    
                    TextField("Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay( RoundedRectangle(cornerRadius: 6)
                        .stroke(Color("DarkBlue"), lineWidth: 2))
                }
            }
            .padding()
            .padding(.leading, 15)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading) {
                
                Text("Story")
                    .foregroundColor(Color("Black"))
                    .font(.body)
                HStack {
                    
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(Color("DarkBlue"))
                        .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
                    TextEditor(text: $story)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay( RoundedRectangle(cornerRadius: 6)
                        .stroke(Color("DarkBlue"), lineWidth: 2))
                }
            }
            .padding()
            .padding(.leading, 15)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            if areFieldEmpty{
                HStack{
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(Color("DarkRed"))
                    Text("Please add title and story!")
                        .foregroundColor(Color("DarkRed"))
                        .font(.body)
                }
                .padding(.leading, 55)
            }
            Button(action: {
                if title.isEmpty || story.isEmpty{
                    areFieldEmpty = true
                } else {
                    DispatchQueue.main.async {
                        UserHandler.createShoutOut(posterId: self.posterID, title: title, story: story)
                    }
                    areFieldEmpty = false
                    presentationMode.wrappedValue.dismiss()
                }
                
            }, label: {
                Text("Post")
                    .padding()
                    .foregroundColor(Color("Black"))
                    .font(.title3)
                    .frame(minWidth: 0, maxWidth: 250, alignment: .center)
                    .background(Color("LightBlue"))
                    .cornerRadius(40)
            })
                .padding(.horizontal)
                .padding(.leading, 55)
                
        }
        .onAppear(perform: {
            ref.child("Users").observeSingleEvent(of: .value, with: {(users) in
                for aUser in users.children {
                    let snap = aUser as! DataSnapshot
                    let userDict = snap.value as! [String: Any]
                    let userEmail = userDict["email"] as! String
                    if userEmail == Auth.auth().currentUser!.email {
                        self.posterID = userDict["userId"] as! String
                    }
                }
            })
        })
    }
}

struct AddShoutOut_Previews: PreviewProvider {
    static var previews: some View {
        AddShoutOut()
    }
}
