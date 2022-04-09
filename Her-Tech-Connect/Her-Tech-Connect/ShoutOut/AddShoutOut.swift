//
//  AddShoutOut.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 12/11/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import Firebase

struct AddShoutOut: View {
    let ref = Database.database().reference()
    @Environment(\.presentationMode) var presentationMode
    @State var areFieldEmpty: Bool = false
    @State var title: String = ""
    @State var story: String = ""
    @State var posterID: String = ""
    @State var image: Image?
    @State var imageURL: String = ""
    @State var loadingProgress = 0.0
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State var isDisable = false
    
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
                Group{
                    Text("Add image ")
                        .foregroundColor(Color("Black"))
                        .font(.body) +
                    Text("(Optional)")
                        .foregroundColor(Color.red)
                        .font(.body)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                if loadingProgress != 0.0 && loadingProgress < 100.0{
                    ProgressView("Uploading...", value: self.loadingProgress, total: 100)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color.green))
                        .padding(.vertical)
                        .padding(.horizontal, 55)
                } else if self.loadingProgress == 100.0{
                    ProgressView("Ready to post in a sec", value: self.loadingProgress, total: 100)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color.green))
                        .padding(.vertical)
                        .padding(.horizontal, 55)
                }
                if image != nil {
                    image?
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .foregroundColor(Color("LightBlue"))
                        .clipShape(Rectangle())
                        .cornerRadius(15)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .onTapGesture {
                            self.showingImagePicker = true
                        }
                        .fullScreenCover(isPresented: $showingImagePicker, onDismiss:{
                            if image != nil{
                                loadImage()
                                saveImage()
                            }
                        }
                            
                            ) {
                            ImagePicker(image: self.$inputImage)
                        }
                } else {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150, alignment: .center)
                        .foregroundColor(Color("LightBlue"))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .onTapGesture {
                            self.showingImagePicker = true
                        }
                        .fullScreenCover(isPresented: $showingImagePicker, onDismiss: {
                            loadImage()
                            saveImage()
                        }
                            ) {
                            ImagePicker(image: self.$inputImage)
                        }
                }
                    
            }
            .padding()
            .padding(.leading, 15)
            
            
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
                        UserHandler.createShoutOut(posterId: self.posterID, title: title, story: story, image: imageURL)
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
            }).disabled(isDisable)
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
    
    /*
     Function to get image from library
     */
    func loadImage() {
        guard let inputImage = inputImage else { return }
        print("image: \(inputImage)")
        image = Image(uiImage: inputImage)
        self.isDisable = true
    }
    
    /*
     Function to save image to the database
     */
    func saveImage() {
        if self.inputImage != nil{
            let data = self.inputImage!.jpegData(compressionQuality: 0.8)!
//            let userImageId = Auth.auth().currentUser!.uid
            let uploadRef = Storage.storage().reference(withPath: "shoutoutImage/\(UUID().uuidString).jpg")
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
//                              self.imageHasChanged = false
                              loadingProgress = 0.0
                              self.imageURL = url!.absoluteString
                              print("the URL: \(String(describing: url?.absoluteString))")
                              self.isDisable = false
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
}

struct AddShoutOut_Previews: PreviewProvider {
    static var previews: some View {
        AddShoutOut()
    }
}
