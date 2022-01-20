//
//  ImagePickerView.swift
//  Shoosen
//
//  Created by Manne Sahlin on 2022-01-19.
//

import Foundation
import UIKit
import SwiftUI


struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    var sourceType : UIImagePickerController.SourceType
    
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    //connecting the coordinator class with this struct
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
    

}
