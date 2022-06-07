//
//  SearchView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI
import Firebase


struct SearchView: View {
    
    
    var db = Firestore.firestore()
    
    @State var shoes = [Shoe]()
    @State var brandInput: String = ""
    @State var sizeInput : Int?
    @State var shoeTypeInput : String = ""
    @State var priceInput : Int?
    @State var colorInput : String = ""
    @ObservedObject private var autoComplete = AutocompleteObject()
    @State private var tabSelection = 1
    @State var isActive = false
    
    @State var brownButton : String = "brown"
    @State var blackButton : String = "black"
    @State var whiteButton : String = "white"
    @State var greyButton : String = "grey"
    @State var greenButton : String = "green"
    @State var blueButton : String = "blue"
    @State var redButton : String = "red"
    @State var yellowButton : String = "yellow"
    @State var orangeButton : String = "orange"
    @State var purpleButton : String = "purple"
    @State var multiButton : String = "multi"
    
    var body: some View {
       TabView(selection: $tabSelection) {
                VStack {
                    TextField("Search by brand", text: $brandInput)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .onChange(of: brandInput) { newValue in
                            autoComplete.autocomplete(brandInput)
                        }
                    
                    List(autoComplete.suggestions, id: \.self) { suggestion in
                        ZStack {
                            Text(suggestion)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .onTapGesture {
                            brandInput = suggestion
                            self.tabSelection = 2
                        }
                        .listRowBackground(Color(UIColor(named: "SecondBackground")!))
                    }
                }
           
                .tag(1)
                
                VStack {
                    
                    Text("Get more specific")
                        .font(.system(size: 32, weight: .light))
                        .padding()
                    
                    TextField("Search by size", value: $sizeInput , formatter: NumberFormatter())
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    
                    Text("Search by price")
                    TextField("Max price", value: $priceInput , formatter: NumberFormatter())
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    TextField("Search by shoetype",text: $shoeTypeInput)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    ColorButtonsView(colorInput: $colorInput)
                    
                    NavigationLink(destination: SearchSheetView(shoes: shoes), isActive: $isActive) { EmptyView() 
                        }
                    
                    Button("Search") {
                        searchForShoe()
                       
                    }
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color(UIColor(named: "SecondBackground")!))
                    .cornerRadius(8)
                    .padding()
                    Spacer()
                    
                }
                .tag(2)
                .onAppear {
             changeColorButtonsToDefault()
            }
                
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .background(Color(UIColor(named: "Background")!))
        
        .navigationViewStyle(.stack)
    }
    
    func changeColorButtonsToDefault() {
        brownButton = "brown"
        blackButton  = "black"
        whiteButton = "white"
        greyButton = "grey"
        greenButton = "green"
        blueButton = "blue"
        redButton  = "red"
        yellowButton  = "yellow"
        orangeButton = "orange"
        purpleButton = "purple"
        multiButton = "multi"
    }
    
    func searchForShoe(){
        
        shoes.removeAll()
        
        var query = db.collection("Shoes").whereField("showshoe", isEqualTo: false)
        
        
        if brandInput != "" {
            query = query.whereField("brand", isEqualTo: brandInput.lowercased())
        }
        if colorInput != "" {
            query = query.whereField("color", isEqualTo: colorInput.lowercased())
        }
        if sizeInput != nil {
            query = query.whereField("size", isEqualTo: sizeInput!)
        }
        
        if priceInput != nil {
            query = query.whereField("price", isLessThanOrEqualTo: priceInput!)
        }
        if shoeTypeInput != ""{
            query = query.whereField("shoetype", isEqualTo: shoeTypeInput.lowercased())
        }
        query.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let result = Result {
                        try document.data(as: Shoe.self)
                    }
                    switch result {
                    case .success(let shoe):
                        if let shoe = shoe {
                            shoes.append(shoe)
                            print("SHOE: \(shoe)")
                        } else {
                            print("Error to get document")
                        }
                    case .failure(let error):
                        print("Error \(error)")
                    }
                    
                }
                print("!!! number of shoes: \(shoes.count)")
                isActive = true
            }
        }
    }
    
    func listenToFireStore() {
        
        db.collection("Shoes").addSnapshotListener { snapshot, err in
            
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Could not find document: \(err)")
                
            } else {
                shoes.removeAll()
                
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: Shoe.self)
                        
                    }
                    switch result {
                    case.success(let shoe):
                        if let shoe = shoe {
                            print("Shoe: \(shoe)")
                            shoes.append(shoe)
                        } else {
                            print("Document does not exist")
                        }
                    case.failure(let error):
                        print("Error decoding shoe \(error)")
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


