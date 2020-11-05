//
//  LaunchScreenVC.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 17-10-04.
//  Copyright © 2017-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import FirebaseAnalytics

class LaunchScreenVC: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let alreadyLogged = Defaults.bool(forKey: "loggedIn")
        if alreadyLogged {
            self.dismiss(animated: true, completion: nil)
        } else {
            Analytics.logEvent("first_launch", parameters: nil)
        }
        
        var localImagesURL: [String] = []
        var localType: [String] = []
        for i in 1...31 {
            localImagesURL.append("chat\(i).jpeg")
            localType.append("img")
        }
        print(localImagesURL)
        Defaults.set(localImagesURL, forKey: "imagesArray")
        Defaults.set(localType, forKey: "imagesTypeArray")
        
        nextButton.backgroundColor = globalUIVariables.colorUserBoy
        nextButton.setTitleColor(UIColor.white, for: .normal)
        nextButton.layer.cornerRadius = 5
        
        
        
        navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
    }
}
