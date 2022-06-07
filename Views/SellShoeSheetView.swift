//
//  SellShoeSheetView.swift
//  Shoosen
//
//  Created by Manne Sahlin on 2022-02-01.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth


struct SellShoeSheetView : View {
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    var db = Firestore.firestore()
    var auth = Auth.auth()
    @ObservedObject private var autocomplete = AutocompleteObject()
    
    
    @State var brandInput: String = ""
    @State var sizeInput : Int?
    @State var colorInput : String
    @State var priceInput : Int?
    @State var shoetypeInput : String = ""
    @State var storageManager = StorageManager()
    
    var body: some View {
        
        
        TabView {
            
            VStack {
                Spacer()
                Text("Wich brand is it?")
                    .font(.system(size: 32, weight: .light))
                    .padding()
                
                
                TextField("Search by brand", text: $brandInput)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onChange(of: brandInput) { newValue in
                        autocomplete.autocomplete(brandInput)
                    }
                
                List(autocomplete.suggestions, id: \.self) { suggestion in
                    ZStack {
                        Text(suggestion)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .onTapGesture {
                        brandInput = suggestion
                    }
                    .listRowBackground(Color(UIColor(named: "SecondBackground")!))
                }
                
            }
            
            VStack{
                Spacer()
                Text("What type of shoe is it?")
                    .font(.system(size: 32, weight: .light))
                    .padding()
                Spacer()
                
                
                TextField("Input shoe type here", text: $shoetypeInput)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                
            }
            
            VStack {
                Spacer()
                Text("Wich size are they?")
                    .font(.system(size: 32, weight: .light))
                    .padding()
                Spacer()
                
                
                TextField("Input size here", value: $sizeInput, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                Spacer()
            }
            
            VStack {
                Spacer()
                Text("Wich color are they?")
                    .font(.system(size: 32, weight: .light))
                    .padding()
                Spacer()
                ColorButtonsView(colorInput: $colorInput )
                
                Spacer()
                
            }
            
            VStack {
                Spacer()
                Text("How much do you want to sell them for?")
                    .font(.system(size: 32, weight: .light))
                    .padding()
                Spacer()
                TextField("Input price here", value: $priceInput, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                Spacer()
            }
            
            VStack{
                Spacer()
                Text("Add photo")
                    .font(.system(size: 32, weight: .light))
                    .padding()
                Spacer()
                
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                    
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    
                }
                
                HStack{
                    
                    Button("Camera"){
                        self.sourceType = .camera
                        self.isImagePickerDisplay.toggle()
                    }.padding()
                        .buttonStyle(.bordered)
                    
                    
                    Button("Photo"){
                        self.sourceType = .photoLibrary
                        self.isImagePickerDisplay.toggle()
                    }.padding()
                        .buttonStyle(.bordered)
                }
                Spacer()
                
                Button("Save"){
                    addToFireStore()
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(Color(UIColor(named: "SecondBackground")!))
                .cornerRadius(8)
                .padding()
                Spacer()
                
                
            }
        }.tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        
        
        
            .navigationBarTitle("Sell your shoe")
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                
            }
            .background(Color(UIColor(named: "Background")!))
        
    }
    
    func addToFireStore(){
        
        guard let uid = auth.currentUser?.uid else {return}
        print("Color input", self.colorInput)
        
        if priceInput != nil || sizeInput != nil {
            if let selectedImage = selectedImage {
                storageManager.upload(image: selectedImage){ url in
                    
                    let shoes = Shoe(id: "" , brand: brandInput.lowercased(), color: colorInput.lowercased(), shoetype: shoetypeInput.lowercased(), price: priceInput!, size: sizeInput!, image: url, brandlogo: "", showshoe: false, currentSeller: uid )
                    
                    
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



