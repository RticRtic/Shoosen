//
//  CategoryView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI
import Firebase

struct CategoryView: View {
    
    var db = Firestore.firestore()
    @State var brandLogos = [BrandLogo]()
    
    var body: some View {
        VStack {
            List {
                ForEach(brandLogos) { logo in
                    NavigationLink(destination: ShoeBrandView(brandName: logo)) {
                        AsyncImage(url: URL(string: logo.image)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                                .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                            
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                
                        } placeholder: {
                            Image(systemName: "photo")

                        }
                    }
                    .listRowBackground(Color(UIColor(named: "SecondBackground")!))
                }
            }
            .onAppear() {
                listenToFireStore()
            }
        }
    }
    
    func listenToFireStore() {
        db.collection("BrandLogos").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                
                print("Could not find document: \(err)")
                
            } else {
                brandLogos.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: BrandLogo.self)
                    }
                    switch result {
                    case.success(let brandLogo):
                        
                        if let brandLogo = brandLogo {
                            print("BrandLogos: \(brandLogo)")
                            brandLogos.append(brandLogo)
                            
                        } else {
                            print("Document does not exist")
                        }
                    case.failure(let error):
                        print("Error decoding brandLogos \(error)")
                    }
                }
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}



