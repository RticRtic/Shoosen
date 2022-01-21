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
        
        let reziedImage = image
        
        let data = reziedImage.jpegData(compressionQuality: 0.2)
        
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

    func listAllFiles(){
        let storageRef = storage.reference().child("images")
        
        storageRef.listAll{ (result, error) in
            if let error = error {
                print("Error while listing all files", error)
            }
            for item in result.items {
                print("Item in images folder", item)
            }
        }
    }
 
    
    func listItem(){
        
        let storageRef = storage.reference().child("images")
        
        let handler : (StorageListResult, Error?) -> Void = {(result, error) in
            if let error = error{
                print("error", error)
            }
            
            let item = result.items
            print("item: ", item )
        }
    
        storageRef.list(maxResults: 1, completion: handler)
    }
    
    func deleteItem(item: StorageReference){
        item.delete { error in
            if let error = error{
                print("Error deleting item", error)
        }
    }
}
}
