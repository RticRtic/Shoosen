//
//  StorageManager.swift
//  Shoosen
//
//  Created by Manne Sahlin on 2022-01-19.
//

import Foundation
import SwiftUI
import Firebase

public class StorageManager: ObservableObject{
    let storage = Storage.storage()
    
    func upload(image : UIImage, completion :  @escaping (String) -> () ){
        
        let id = UUID()
        let storageRef = storage.reference().child("Default Pictures/\(id).jpg")
        
        let rezisedImage = image
        
        let data = rezisedImage.jpegData(compressionQuality: 0.2)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data{
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file:", error)
                }
                if let metadata = metadata{
                    print("Metadata:", metadata)
                    storageRef.downloadURL { url, error in
                    
                        if let url = url{
                            completion(url.absoluteString)
                            print("!!! ! ! !!!!! ! !", url.absoluteString)
                            
                        }
                    }
                }
            }
        }
    }

    
    func deleteItem(item: StorageReference){
        item.delete { error in
            if let error = error{
                print("Error deleting item", error)
        }
    }
}
}
