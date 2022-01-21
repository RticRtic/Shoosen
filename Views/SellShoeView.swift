//
//  SellShoeView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI
import Firebase



struct SellShoeView: View {
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    var db = Firestore.firestore()
    
    
    
    @State var brandInput: String = ""
    @State var sizeInput : Int = 0
    @State var colorInput : String = ""
    @State var priceInput : Int = 0
    @State var shoetypeInput : String = ""
    
    
    
    @State var storageManager = StorageManager()
    
    var body: some View {
        NavigationView{
            
            VStack{
                TextField("Wich brand is it?", text: $brandInput)
                TextField("What type of shoe is it?", text: $shoetypeInput)
                TextField("Wich size are they?", value: $sizeInput, formatter: NumberFormatter())
                TextField("Wich color are they?", text: $colorInput)
                TextField("Wich price?", value: $priceInput, formatter: NumberFormatter())
            
            
               
                
               
                
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    
                }
            
                HStack{
                
                    Button("Camera"){
                    self.sourceType = .camera
                    self.isImagePickerDisplay.toggle()
                }.padding()
                
                Button("photo"){
                    self.sourceType = .photoLibrary
                    self.isImagePickerDisplay.toggle()
                }.padding()
                    
                   Button("Save"){
                        addToFireStore()
                    }.padding()
                    Spacer()
                }
            }
        }
                
            
            
                
            .navigationBarTitle("Sell your shoe")
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
        }

    
    func addToFireStore(){
        
        if let selectedImage = selectedImage {
            storageManager.upload(image: selectedImage){ url in
                
                let shoes = Shoe(id: "" , brand: brandInput.lowercased(), color: colorInput.lowercased(), shoetype: shoetypeInput.lowercased(), price: priceInput, size: sizeInput, image: url, brandlogo: "", showshoe: true)
                
                
                do {
                      let _ = try db.collection("Shoes").addDocument(from: shoes)
                    }
                    catch {
                      print(error)
                    }
                }
            }
        }
        
        
        
}

struct SellShoeView_Previews: PreviewProvider {
    static var previews: some View {
        SellShoeView()
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker : ImagePickerView
    
    init(picker: ImagePickerView){
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
    
    
}
