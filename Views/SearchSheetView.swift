//
//  SearchSheetView.swift
//  Shoosen
//
//  Created by Manne Sahlin on 2022-02-02.
//

import Foundation
import SwiftUI

struct SearchSheetView : View {
   
    var shoes : [Shoe]
    
    var body: some View {
        
        VStack {
            List {
                ForEach(shoes) { shoe in
                    
                    HStack {
                        NavigationLink(destination: ShoeView(selectedShoe: shoe)) {
                            AsyncImage(url: URL(string: shoe.image)) {image in
                                image
                                
                                    .resizable()
                                    .scaledToFit()
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                                
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                    .padding()
                                }
                            
                        
                        placeholder: {
                            Image(systemName: "photo")
                        }
                            
                            VStack {
                                Text(shoe.brand.uppercased())
                                    .padding()
                                    .font(.headline)
                                Text("\(shoe.price) Kr")
                                    .padding()
                                
                            }
                        }
                    }
                }
            }
        }
    }
}







