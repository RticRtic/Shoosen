//
//  ColorButtonsView.swift
//  Shoosen
//
//  Created by vatran robert on 2022-06-06.
//

import SwiftUI

struct ColorButtonsView: View {
    
    @State private var isSelectedBrown = false
    @State private var isSelectedBlack = false
    @State private var isSelectedWhite = false
    @State private var isSelectedGray = false
    @State private var isSelectedGreen = false
    @State private var isSelectedBlue = false
    @State private var isSelectedRed = false
    @State private var isSelectedYellow = false
    @State private var isSelectedOrange = false
    @State private var isSelectedPurple = false
    @State private var isSelectedMulti = false
    @Binding var colorInput : String
    
    var body: some View {
        VStack {
            HStack{
                Button(isSelectedBrown ? "X" : "Brown") {
                    isSelectedBrown.toggle()
                    //if the button is deselected color input is empty and all the availeble shoes appear again
                    if(isSelectedBrown == true){
                        colorInput = "brown"
                    }else{
                        colorInput = ""
                    }
                }
                .background(.brown)
                .modifier(PrimaryLabel())
                
                
                Button(isSelectedBlack ? "X" : "Black") {
                    isSelectedBlack.toggle()
                    if(isSelectedBlack == true){
                        colorInput = "black"
                    }else{
                        colorInput = ""
                    }
                    
                }
                .background(.black)
                .buttonStyle(.bordered)
                .cornerRadius(25)
                .padding(10)
                .foregroundColor(.white)
                
                Button(isSelectedWhite ? "X" : "White") {
                    isSelectedWhite.toggle()
                    if(isSelectedWhite == true){
                        colorInput = "white"
                    }else{
                        colorInput = ""
                    }
                    
                }
                .background(.white)
                .modifier(PrimaryLabel())
            }
            HStack {
                Button(isSelectedGray ? "X" : "Gray") {
                    isSelectedGray.toggle()
                    if(isSelectedGray == true){
                        colorInput = "gray"
                    }else{
                        colorInput = ""
                    }
                    
                }
                .background(.gray)
                .modifier(PrimaryLabel())
                
                Button(isSelectedGreen ? "X" : "Green") {
                    isSelectedGreen.toggle()
                    if(isSelectedGreen == true){
                        colorInput = "green"
                    }else{
                        colorInput = ""
                    }
                    
                }
                .background(.green)
                .modifier(PrimaryLabel())
                
                
                Button(isSelectedBlue ? "X" : "Blue") {
                    isSelectedBlue.toggle()
                    if(isSelectedBlue == true){
                        colorInput = "blue"
                    }else{
                        colorInput = ""
                    }
                    
                }
                .background(.blue)
                .modifier(PrimaryLabel())
            }
            HStack {
                Button(isSelectedRed ? "X" : "Red") {
                    isSelectedRed.toggle()
                    if(isSelectedRed == true){
                        colorInput = "red"
                    }else{
                        colorInput = ""
                    }
                    
                }
                .background(.red)
                .modifier(PrimaryLabel())
                
                Button(isSelectedYellow ? "X" : "Yellow") {
                    isSelectedYellow.toggle()
                    if(isSelectedYellow == true){
                        colorInput = "yellow"
                    }else{
                        colorInput = ""
                    }
                    
                }
                .background(.yellow)
                .modifier(PrimaryLabel())
                
                Button(isSelectedOrange ? "X" : "Orange") {
                    isSelectedOrange.toggle()
                    if(isSelectedOrange == true){
                        colorInput = "orange"
                    }else{
                        colorInput = ""
                    }
                    
                }
                .background(.orange)
                .modifier(PrimaryLabel())
            }
            HStack {
                
                Button(isSelectedPurple ? "X" : "Purple") {
                    isSelectedPurple.toggle()
                    if(isSelectedPurple == true){
                        colorInput = "purple"
                    }else{
                        colorInput = ""
                    }
                    
                }
                .background(.purple)
                .modifier(PrimaryLabel())
                
                
                Button(isSelectedMulti ? "X" : "Multi") {
                    isSelectedMulti.toggle()
                    if(isSelectedMulti == true){
                        colorInput = "multi"
                    }else{
                        colorInput = ""
                    }
                    
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color(.yellow).opacity(0.3), Color(.purple)]), startPoint: .top, endPoint: .bottom)).background(LinearGradient(gradient: Gradient(colors: [Color(.green).opacity(0.3), Color(.red)]), startPoint: .top, endPoint: .bottom))
                .modifier(PrimaryLabel())
            }
        }
        
    }
}

struct PrimaryLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .foregroundColor(.black)
            .cornerRadius(25)
            .padding(10)
    }
}

struct ColorButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ColorButtonsView(colorInput: .constant(""))
    }
}
