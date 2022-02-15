//
//  HomeView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    @State var changeColorOfHomeButton = false
    @State var shoeIntrestImage = [Shoe]()
    
    let columns = [
        GridItem(.adaptive(minimum: 150)),
        
    ]
    
    var body: some View {
        
        VStack {
            Text("SellView")
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(shoeIntrestImage) { shoe in
                        NavigationLink(destination: BuyerInformationView(reciveBuyerInformation: shoe)) {
                            AsyncImage(url: URL(string: shoe.image)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                                
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                    .padding()
                                

                                
                            } placeholder: {
                                Image(systemName: "photo")
                            }

                            
                            
                        }

                            .listRowBackground(Color(UIColor(named: "SecondBackground")!))

                    }
                    
                }
                
            }
            
            
            
            
        }
        .onAppear{
            getPropsalBuyerImage()
            //listenIfChecked()
            
        }
        .background(Color(UIColor(named: "Background")!))

        
        
        
        
        
    }
    
    func getPropsalBuyerImage() {
        shoeIntrestImage.removeAll()
        guard let uid = auth.currentUser?.uid else {return}
        var favoritesId: [String] = []
        
        db.collection("UserCollection").document(uid).collection("buyingProposal")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Could not find document: \(err)")
                    //db.collection("UserCollection").document(uid).collection("favorites").addDocument(data: ["favorite" : shoe.id])
                } else {
                    for document in querySnapshot!.documents {

                        
                        if let data = document.data() as? [String: Any] {
                            if let id = data["shoeId"] as? String {

                                favoritesId.append(id)
                                print(favoritesId[0])
                            }
                            db.collection("UserCollection").document(uid).collection("buyingProposal").document(document.documentID).updateData(["checked" : true])
                            
                        }
                        
                    }
                    
                    for id in favoritesId {
                        db.collection("Shoes").document(id).getDocument() {
                            (document, err) in
                            
                            
                            let result = Result {
                                try document?.data(as: Shoe.self)
                            }
                            
                            switch result {
                            case .success(let shoe):
                                if let shoe = shoe {
                                    shoeIntrestImage.append(shoe)
                                    print("Potential shoesell: \(shoe)")
                                    
                                } else {
                                    print("document does not exist")
                                }
                            case .failure(let error):
                                print("ERROR: \(error)")
                            }
                            
                        }
                    }
                    
                }
                
            }
        
        
    }
    
    
    
    
    
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

