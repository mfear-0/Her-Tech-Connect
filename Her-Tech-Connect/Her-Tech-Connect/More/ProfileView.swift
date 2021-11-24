//
//  Profile.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/23/21.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct ProfileView: View {
    let ref = Database.database().reference()
    @State var userId: String = ""
    @State var userName: String = ""
    @State var userImage: String = ""
    @State var jobDescription: String = ""
    @State var userEmail: String = ""
    @State var name: String = ""
    @State var job: String = ""
    @State var isChanged = true
    @State var isChangeMade = true
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false){
                RoundedImage(urlImage: self.userImage, imageWidth: 120, imageHeight: 120)
                
                Group{
                    Text("Change")
                    .padding(10)
                    .clipShape(Rectangle())
                    .background(Color("LightBlue"))
                    .cornerRadius(5)
                    .onTapGesture {
                        self.showingImagePicker = true
                    }
                    .fullScreenCover(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: self.$inputImage)
                    }
                    Text(self.userName)
                        .bold()
                        .font(.system(size: 22))
                    Text(self.userEmail)
                        .font(.system(size: 14))
                    Text(self.jobDescription)
                        .font(.system(size: 14))
                        .padding(.bottom, 10)
                }
                HStack{
                    Image(systemName: "pencil")
                        .foregroundColor(Color.red)
                        .padding(.leading, 10)
                    Text("Edit")
                        .foregroundColor(Color.red)
                        .font(.system(size: 16))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading) {
                    
                    Text("Name")
                        .foregroundColor(Color("Black"))
                        .font(.body)
                    
                    HStack {
                        
                        Image(systemName: "person.fill")
                            .foregroundColor(Color("DarkBlue"))
                        
                        TextField("New Name", text: $name)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay( RoundedRectangle(cornerRadius: 6)
                            .stroke(Color("DarkBlue"), lineWidth: 2))
                    }
                }
                .padding()
                
                VStack(alignment: .leading) {
                    
                    Text("Job Description")
                        .foregroundColor(Color("Black"))
                        .font(.body)
                    
                    HStack {
                        
                        Image(systemName: "suitcase")
                            .foregroundColor(Color("DarkBlue"))
                        
                        TextField("New Job Description", text: $job)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay( RoundedRectangle(cornerRadius: 6)
                            .stroke(Color("DarkBlue"), lineWidth: 2))
                    }
                }
                .padding()
                
                if !isChanged {
                    Text("There is no changes to be made!")
                        .foregroundColor(Color.red)
                        .font(.body)
                }
                
                if !isChangeMade {
                    Text("Changes were successfully made!")
                        .foregroundColor(Color.green)
                        .font(.body)
                }
                
                Button(action: {
                    if name != userName || job != jobDescription {
                        self.isChanged = true
                        self.isChangeMade = false
                        UserHandler.updateUserInfo(userId: self.userId, userName: self.name, userEmail: self.userEmail, image: self.userImage, jobDescription: self.job)
                        self.userName = self.name
                        self.jobDescription = self.job
                    } else {
                        self.isChanged = false
                        self.isChangeMade = true
                    }
                }, label: {
                    Text("Save")
                        .padding()
                        .foregroundColor(Color("Black"))
                        .font(.title3)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("LightBlue"))
                        .cornerRadius(40)
                })
                    .padding(.horizontal)
            }
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
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
                        self.name = self.userName
                        self.job = self.jobDescription
                    }
                    
                }
            })
        })
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        print("image: \(inputImage)")
//        image = Image(uiImage: inputImage)
    }
    
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
