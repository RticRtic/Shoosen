//
//  ShoeView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-12.
//

import SwiftUI
import Firebase



struct ShoeView: View {
    
    var brandInfo: Shoe
    var db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: brandInfo.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                        
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundColor(.white.opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    VStack(spacing: 30) {
                        Text(brandInfo.brand.uppercased())
                            .font(.largeTitle)
                            .bold()
                            .background()
                            .cornerRadius(5)
                            .shadow(color: .black, radius: 3, x: 3, y: 3)
                            .multilineTextAlignment(.center)
                            .shadow(color: .black, radius: 3, x: 3, y: 3)
                        
                        
                        VStack(alignment: .leading, spacing: 30) {
                            HStack {
                                Text("Color: ")
                                    .font(.headline)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .cornerRadius(10)
                                    .shadow(color: .black, radius: 3, x: 3, y: 3)
                                
                                Text(brandInfo.color.uppercased())
                                
                            }
                            
                            VStack(alignment: .leading, spacing: 30) {
                                HStack {
                                    Text("Shoetype: ")
                                        .font(.headline)
                                        .bold()
                                        .multilineTextAlignment(.center)
                                        .shadow(color: .black, radius: 3, x: 3, y: 3)
                                    
                                    Text(brandInfo.shoetype.uppercased())
                                }
                                
                                VStack(alignment: .leading, spacing: 30) {
                                    HStack {
                                        Text("Size:")
                                            .font(.headline)
                                            .bold()
                                            .multilineTextAlignment(.center)
                                            .shadow(color: .black, radius: 3, x: 3, y: 3)
                                        
                                        Text("\(brandInfo.size)")
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 30) {
                                        HStack {
                                            Text("Price:")
                                                .font(.headline)
                                                .bold()
                                                .multilineTextAlignment(.center)
                                                .shadow(color: .black, radius: 3, x: 3, y: 3)
                                            
                                            Text("\(brandInfo.price):-")
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    Button(action: {
                        print("Contacting seller")
                    }, label: {
                        Text("Buy!")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(Color.gray)
                            .cornerRadius(15)
                            .shadow(color: .white, radius: 10, x: 3, y: 3)
                            .padding(80)
                    })
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
                .background(.brown)
                .cornerRadius(30)
            }
            .ignoresSafeArea(.container, edges: .top)
            
        }
        .padding(.horizontal)
        
        
    }
    
    
    
    
    
}

struct ShoeView_Previews: PreviewProvider {
    static var previews: some View {
        ShoeView(brandInfo: Shoe(id: "", brand: "birkenstock", color: "green", shoetype: "sandal", price: 110, size: 41, image: "https://firebasestorage.googleapis.com/v0/b/shoosen-413a3.appspot.com/o/Default%20Pictures%2Fbirkenstock_green.jpeg?alt=media&token=fca4a817-8a74-4b50-9dda-285d89967616", brandlogo: "", showshoe: false))
    }
}
