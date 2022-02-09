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

struct MailView: UIViewControllerRepresentable {
    
    @EnvironmentObject var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    
}




