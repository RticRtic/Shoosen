//
//  ShoeView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-12.
//

import SwiftUI
import Firebase
import UIKit
import MessageUI

struct ShoeView: View {
    
    var selectedShoe: Shoe
    
    @State var isShowingSaveOption = false
    @State var isShowingFavoriteView = false
    @State var showingAlert = false
    @State var savedToFavorites = false
    @State var buyerAlert = false
    @State var sellerIsContacted = false
    @Environment(\.dismiss) var dismiss
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    @StateObject var viewModel = ShoeModelView()
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: selectedShoe.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                    
                    
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                    
                    
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                    
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    
                }
                
                
                VStack(spacing: 30) {
                    HStack {
                        Text(selectedShoe.brand.uppercased())
                            .font(.largeTitle)
                            .bold()
                        
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                        
                        
                        NavigationLink(destination: FavoritesView(), isActive: $isShowingFavoriteView) {
                            Button(action: {
                                
                                saveOrDeleteFavorite(shoe: selectedShoe)
                                
                            }, label: {
                                VStack {
                                    
                                    if !savedToFavorites {
                                        Text("Add to Favorite")
                                        
                                            .bold()
                                        Image(systemName: "heart")
                                            .foregroundColor(.red)
                                        
                                    } else {
                                        Text("Delete Favorite")
                                        
                                            .bold()
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(.red)
                                        
                                    }
                                    
                                }
                                
                            })
                        }
                        .padding(.leading)
                        
                        .actionSheet(isPresented: $isShowingSaveOption) {
                            ActionSheet(title: Text("Added to favorites"), buttons: [
                                .default(Text("Check out your favorites")) {
                                    isShowingFavoriteView = true
                                },
                                .default(Text("Continue shopping")) {
                                    dismiss()
                                }])
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text(""), message: Text("Deleted from favorites"), dismissButton: .default(Text("Got it!")))
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Color: ")
                                .font(.headline)
                                .bold()
                            
                            
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                .padding()
                            
                            Text(selectedShoe.color.uppercased())
                                .font(.headline)
                            
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Shoetype: ")
                                    .font(.headline)
                                    .bold()
                                
                                
                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                    .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                    .padding()
                                
                                
                                Text(selectedShoe.shoeType.uppercased())
                                    .font(.headline)
                            }
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Size:")
                                        .font(.headline)
                                        .bold()
                                    
                                    
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                        .padding()
                                    
                                    
                                    Text("\(selectedShoe.size)")
                                        .font(.headline)
                                }
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Price:")
                                            .font(.headline)
                                            .bold()
                                        
                                        
                                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                            .padding()
                                        
                                        
                                        Text("\(selectedShoe.price):-")
                                            .font(.headline)
                                        
                                    }
                                }
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                Button(action: {
                    
                    viewModel.buyingProposal(shoe: selectedShoe)
                    viewModel.contactSeller(shoe: selectedShoe)
                    sendNotificationToSeller(shoe: selectedShoe)
                    
                    buyerAlert.toggle()
                    
                    
                }) {
                    
                    HStack {
                        Image(systemName: "envelope")
                        if !sellerIsContacted {
                            Text("Contact seller")
                                .font(.headline)
                        } else {
                            Text("Seller is contacted")
                                .font(.headline)
                        }
                        
                        
                        
                    }
                    .alert(isPresented: $buyerAlert) {
                        Alert(title: Text(""), message: Text("Seller is contacted!"), dismissButton: .default(Text("Got it!")))
                        
                    }
                    
                }
                
                
            }
            
            
        }.onAppear{
            fillHeartIf(favorite: selectedShoe)
            listenIfContacted(shoe: selectedShoe)
            
        }
        
        .ignoresSafeArea(.container, edges: .top)
        .background(Color(UIColor(named: "Background")!))
        
    }
    
    
    
    func fillHeartIf(favorite: Shoe) {
        if let id = favorite.id {
            guard let uid = auth.currentUser?.uid else {return}
            db.collection("UserCollection").document(uid).collection("favorites").addSnapshotListener() {(querySnapshot, err) in
                if let err = err {
                    print("Error getting id: \(err)")
                    
                } else {
                    for document in querySnapshot!.documents {
                        if document.documentID == id {
                            savedToFavorites = true
                            print(document.documentID)
                            print("Exist in favorite: heart.fill")
                            
                            return
                        }
                        
                    }
                    savedToFavorites = false
                }
                
            }
            
        }
    }
    
    func listenIfContacted(shoe: Shoe) {
        guard let uid = auth.currentUser?.uid else {return}
        if let shoeId = shoe.id {
            db.collection("UserCollection").document(uid).collection("contactedSellers").addSnapshotListener() {(querySnapshot, err) in
                if let err = err {
                    print("Can not find document!: \(err)")
                    
                } else {
                    for document in querySnapshot!.documents {
                        
                            if let data = document.data() as? [String : String] {
                                if let seller = data["seller"] {
                                    print("Contacted seller: \(seller)" + " Shoe => \(document.documentID)")
                                    
                                    if shoeId == document.documentID {
                                        sellerIsContacted = true


                                        return
                                    }
                                    
                                }
                                
                            }
                            
                            sellerIsContacted = false
                    }
                 
                }
            }
        }
    }
    

    
    func saveOrDeleteFavorite(shoe: Shoe) {
            if savedToFavorites {
                deleteShoe(shoe: selectedShoe)
                showingAlert = true
            
            } else {
                viewModel.saveToFirestore(shoe: selectedShoe)
                isShowingSaveOption = true
            }
    }
    
    func deleteShoe(shoe: Shoe) {
        guard let uid = auth.currentUser?.uid else {return}
        if let shoeId = shoe.id {
            db.collection("UserCollection").document(uid).collection("favorites").document(shoeId).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            
        }
        
    }
    
    func sendNotificationToSeller(shoe: Shoe) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        guard let uid = auth.currentUser?.uid else {return}
        guard let uidEmail = auth.currentUser?.email else {return}
        db.collection("Shoes").whereField("currentSeller", isEqualTo: shoe.currentSeller).getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Cant get document: \(err)")
                
            } else {
                print(shoe.currentSeller)
            }
            let content = UNMutableNotificationContent()
            content.title = "\(uidEmail)"
            content.subtitle = "is interested to buy one of your shoe/s"
            content.sound = .default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
            let request = UNNotificationRequest(identifier: uid, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
            
        }
    }
}

struct ShoeView_Previews: PreviewProvider {
    static var previews: some View {
        ShoeView(selectedShoe: Shoe(id: "", brand: "birkenstock", color: "green", shoeType: "sandal", price: 110, size: 41, image: "https://firebasestorage.googleapis.com/v0/b/shoosen-413a3.appspot.com/o/Default%20Pictures%2Fbirkenstock_green.jpeg?alt=media&token=fca4a817-8a74-4b50-9dda-285d89967616", brandLogo: "", showShoe: false, currentSeller: ""))
    }
}
