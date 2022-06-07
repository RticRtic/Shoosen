//
//  ColorButtonsView.swift
//  Shoosen
//
//  Created by Malcolm Lennartsson on 2022-06-07.
//

import SwiftUI

struct ColorButtonsView: View {
    
    
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
    
    @Binding var colorInput : String
    
    var body: some View {
        VStack {
            HStack{
                Button(self.brownButton) {
                    colorInput = "brown"
                    brownButton = "X"
                    
                }
                .background(.brown)
                .buttonStyle(.bordered)
                .foregroundColor(.black)
                
                
                Button(self.blackButton) {
                    colorInput = "black"
                    blackButton = "X"
                    
                }
                .background(.black)
                .buttonStyle(.bordered)
                .foregroundColor(.white)
                
                Button(self.whiteButton) {
                    colorInput = "white"
                    whiteButton = "X"
                    
                }
                .background(.white)
                .buttonStyle(.bordered)
                .foregroundColor(.black)
            }
            HStack {
                Button(self.greyButton) {
                    colorInput = "grey"
                    greyButton = "X"
                    
                }
                .background(.white)
                .buttonStyle(.bordered)
                .foregroundColor(.black)
                
                Button(self.greenButton) {
                    greenButton = "X"
                    colorInput = "green"
                    
                }
                .background(.green)
                .buttonStyle(.bordered)
                .foregroundColor(.black)
                
                
                Button(self.blueButton) {
                    colorInput = "blue"
                    blueButton = "X"
                    
                }
                .background(.blue)
                .buttonStyle(.bordered)
                .foregroundColor(.black)
            }
            HStack {
                Button(self.redButton) {
                    colorInput = "red"
                    redButton = "X"
                    
                }
                .background(.red)
                .buttonStyle(.bordered)
                .foregroundColor(.black)
                
                Button(self.yellowButton) {
                    colorInput = "yellow"
                    yellowButton = "X"
                    
                }
                .background(.yellow)
                .buttonStyle(.bordered)
                .foregroundColor(.black)
                
                Button(self.orangeButton) {
                    colorInput = "orange"
                    orangeButton = "X"
                    
                }
                .background(.orange)
                .buttonStyle(.bordered)
                .foregroundColor(.black)
            }
            HStack {
                
                Button(self.purpleButton) {
                    colorInput = "purple"
                    purpleButton = "X"
                    
                }
                .background(.purple)
                .buttonStyle(.bordered)
                .foregroundColor(.black)
                
                Button(self.multiButton) {
                    colorInput = "multi"
                    multiButton = "X"
                    
                }
                .buttonStyle(.bordered)
                .foregroundColor(.black)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.yellow).opacity(0.3), Color(.purple)]), startPoint: .top, endPoint: .bottom)).background(LinearGradient(gradient: Gradient(colors: [Color(.green).opacity(0.3), Color(.red)]), startPoint: .top, endPoint: .bottom))
            }
        }
    }
}

struct ColorButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ColorButtonsView(colorInput: .constant(""))
    }
}
