//
//  SendMail.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-02-09.
//

import Foundation
import MessageUI
import SwiftUI
import UIKit


    
    //@EnvironmentObject var presentation
    //@Binding var result: Result<MFMailComposeResult, Error>?
    
    
    class Coorinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        init(presentation: Binding <PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
            
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
                
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
        
        func makeCoordinator() -> Coordinator {
            
        }
        
        
        
        
    }
    





