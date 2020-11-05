//
//  Internet Connection Alert.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 2018-05-27.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

extension ConversationViewController {
    
    func checkForInternet() {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        }else{
            print("Internet Connection not Available!")
            self.present(createNonDismissableAlert(title: "No Internet Connection", text: "An internet connection is requiered for PetTalk to work."), animated: true)
        }
    }
    
    func checkForUpdate() {
        _ = try? isUpdateAvailable { (update, error) in
            if let error = error {
                print("Error: \(error)")
                if error as! VersionError != VersionError.invalidResponse {
                    if error as! VersionError != VersionError.invalidBundleInfo {
                        self.present(createNonDismissableAlert(title: "Update available", text: "Please update PetTalk from the App Store before using it"), animated: true)
                    }
                }
            } else if let update = update {
                print(update)
            }
        }
    }
}
