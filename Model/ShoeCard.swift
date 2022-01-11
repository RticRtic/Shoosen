//
//  ShoeCard.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-11.
//

import SwiftUI

struct ShoeCard: View {
    
    var shoeInfo: Shoe? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                if let shoeInfo = shoeInfo {
                    AsyncImage(url: URL(string: shoeInfo.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fill)
                            .overlay(alignment: .bottom) {
                                Text(shoeInfo.brand)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .shadow(color: .black, radius: 3, x: 0, y: 0)
                                    .frame(maxWidth: 136)
                                    .padding()
                                
                            }
                        
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40, alignment: .center)
                            .foregroundColor(.white.opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .overlay(alignment: .bottom) {
                                Text(shoeInfo.brand)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 3, x: 0, y: 0)
                                    .frame(maxWidth: 136)
                                    .padding()
                            }
                    }
                }
            }
            
            .frame(width: 200, height: 217, alignment: .top)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
            
            .navigationTitle("Shoe info")
            
            
            
        }
        .navigationViewStyle(.stack)
    }
}

struct ShoeCard_Previews: PreviewProvider {
    static var previews: some View {
        ShoeCard()
    }
}
