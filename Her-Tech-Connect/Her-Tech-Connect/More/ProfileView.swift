//
//  Profile.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/23/21.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth
import Firebase

struct ProfileView: View {
    let ref = Database.database().reference()
    @State var userId: String = ""
    @State var userName: String = ""
    @State var userImage: String = ""
    @State var image: Image?
    @State var jobDescription: String = ""
    @State var userEmail: String = ""
    @State var name: String = ""
    @State var job: String = ""
    @State var loadingProgress = 0.0
    @State var isChanged = true
    @State var isChangeMade = true
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var imageHasChanged = false
    @State private var savingBtnState = "Save"
    
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false){
                if loadingProgress != 0.0{
                    ProgressView("Uploading...", value: self.loadingProgress, total: 100)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color.green))
                        .padding(.vertical)
                        .padding(.horizontal, 55)
                }
                if image != nil {
                    image?
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                } else {
                    RoundedImage(urlImage: self.userImage, imageWidth: 120, imageHeight: 120)
                }
                Group{
                    if !imageHasChanged {
                        Text("Change")
                        .padding(10)
                        .clipShape(Rectangle())
                        .background(Color("LightBlueSwitch"))
                        .cornerRadius(5)
                        .overlay( RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("LightBlue"), lineWidth: 1))
                        .onTapGesture {
                            self.showingImagePicker = true
                        }
                        .fullScreenCover(isPresented: $showingImagePicker, onDismiss:
                            loadImage
                            ) {
                            ImagePicker(image: self.$inputImage)
                        }
                    } else {
                        Text(self.savingBtnState)
                        .padding(10)
                        .clipShape(Rectangle())
                        .background(Color("LightBlueSwitch"))
                        .cornerRadius(5)
                        .overlay( RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("LightBlue"), lineWidth: 1))
                        .onTapGesture {
                            self.savingBtnState = "Uploading..."
                            saveImage()
                        }
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
                        .background(Color("LightBlueSwitch"))
                        .cornerRadius(40)
                        .overlay( RoundedRectangle(cornerRadius: 40)
                        .stroke(Color("LightBlue"), lineWidth: 2))
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
    
    /*
     Function to save image to the database
     */
    func saveImage() {
        if self.inputImage != nil{
            let data = self.inputImage!.jpegData(compressionQuality: 0.8)!
            let userImageId = Auth.auth().currentUser!.uid
            let uploadRef = Storage.storage().reference(withPath: "profileImage/\(userImageId).jpg")
            let metadata = StorageMetadata.init()
            metadata.contentType = "image/jpeg"
            
            //Saving image into the database
            let taskRef = uploadRef.putData(data, metadata: metadata){(data, error) in
                if error != nil {
                    print("An error has occured: \(String(describing: error?.localizedDescription))")
                    return
                } else {
                    // Create a reference to the file you want to download
                    let starsRef = Storage.storage().reference().child((data?.path)!)

                    // Fetch the download URL
                    starsRef.downloadURL { url, error in
                      if let error = error {
                        // Handle any errors
                          print("An error has occured: \(error)")
                      } else {
                          // Get the download URL for 'images/stars.jpg'
                          DispatchQueue.main.async {
                              self.imageHasChanged = false
                              loadingProgress = 0.0
                              inputImage = nil
                              UserHandler.updateUserInfo(userId: self.userId, userName: self.name, userEmail: self.userEmail, image: url!.absoluteString, jobDescription: self.job)
                              print("the URL: \(String(describing: url?.absoluteString))")
                          }
                      }
                    }
                }
            }
            
            //Tracking the progress of the upload
            taskRef.observe(.progress) {(snap) in
                self.loadingProgress = Double(snap.progress!.fractionCompleted) * 100
                print("Already completed \(self.loadingProgress)")
            }
        }
    }
    
    /*
     Function to get image from library
     */
    func loadImage() {
        guard let inputImage = inputImage else { return }
        print("image: \(inputImage)")
        image = Image(uiImage: inputImage)
        self.imageHasChanged = true
    }
    
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
