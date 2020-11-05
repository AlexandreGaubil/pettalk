//
//  AboutViewController.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-02-04.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var view1: UIView!
    var previousTypeOfText = "body"
    
    @objc func tapGesturePP() {
        //self.createWebView(resourceName: "PrivacyPolicy")
        if let url = URL(string: "https://pettalkapp.wordpress.com/privacy-policy/"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    @objc func tapGestureLA() {
        if let url = URL(string: "https://pettalkapp.wordpress.com/licence-agreement/"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
        //self.createWebView(resourceName: "LicenceAgreement")
    }
    @objc func tapGestureGLA() {
        if let url = URL(string: "https://pettalkapp.wordpress.com/google-licence-agreement/"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
        //self.createWebView(resourceName: "GoogleLicenceAgreement")
    }
    
    /*func createWebView(resourceName: String) {
        view1.isHidden = false
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        }
        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - (navigationController?.navigationBar.frame.height)!))
        
        let barButtonOK = UIBarButtonItem(title: "Dismiss", style: .done, target: self, action: #selector(buttonAction))
        
        navigationItem.leftBarButtonItem = barButtonOK
        
        do {
            guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "html")
                else {
                    // File Error
                    self.present(createDismissableAlert(title: "Error while opening the document", text: "Hum... There seems to have been an error while opening this contract. Please contact support at pettalkhelp@gmail.com or try again latter.", buttonText: TextForAlerts.ok), animated: true)
                    return
            }
            
            let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
            let baseUrl = URL(fileURLWithPath: filePath)
            webView.loadHTMLString(contents as String, baseURL: baseUrl)
            view1.addSubview(webView)
            view.bringSubview(toFront: view1)
        }
        catch {
            print ("File HTML error")
        }
    }*/
    
    let textArray : [String] = ["PetTalk", "About the app", "Hi there! PetTalk is a free app, without any ads. I did this as I believe in creating quality products. However, doing an app takes time, energy and money. As such, I would be extremely grateful if you could leave a review or make a small donation. Thank you for using PetTalk!", "", "----------", "Copyright © 2018-2019  Alexandre Gaubil", "All rights reserved", "pettalkhelp@gmail.com", "www.pettalkapp.wordpress.com", "", "----------", "Privacy policy", "Tap here to read our Privacy Policy.", "", "----------", "Licence Agreement", "Tap here to read the Licence Agreement.", "", "----------", "Images", "All images are from Pexels and can be found at www.pexels.com", "", "----------", "AFINN Dataset", "Contains information from AFINN, available at http://www2.imm.dtu.dk/pubdb/views/publication_details.php?id=6010 , which is made available here under the Open Database License (ODbL).", "Spring Keyboard Layout Constraint", "The MIT License (MIT)", "Copyright (c) 2015 James Tang (j@jamztang.com)", "Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:", "The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.", "THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.", "SwiftyGif", "The MIT License (MIT)", "Copyright (c) 2016 Alexis Creuzot", "Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:", "The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.", "THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.", "", "----------", "Firebase Licence Agreement", "Tap here to read Firebase's Licence Agreement.", "", "", ""]
    
    let typeArray: [String] = ["title", "title", "body", "body", "seperation", "body", "body", "body", "body", "body", "seperation", "title", "linkPP", "body", "seperation", "title", "linkLA", "body", "seperation", "title", "body", "body", "seperation", "title", "body", "title", "body", "body", "body", "body", "body", "title", "body", "body", "body", "body", "body", "body", "seperation", "title", "linkGLA", "body", "body", "body"]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        print(textArray.count)
        for i in 0...textArray.count-1 {
            displayNewMessage(text: textArray[i], type: typeArray[i])
            previousTypeOfText = typeArray[i]
        }
        if globalInformation.color == "blue" {
            self.navigationController?.navigationBar.tintColor = globalUIVariables.colorUserBoy
            self.view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 1, blue: 1, alpha: 1)
            view1.backgroundColor = #colorLiteral(red: 0.9568627451, green: 1, blue: 1, alpha: 1)
        } else {
            self.navigationController?.navigationBar.tintColor = globalUIVariables.colorUserGirl
            self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9490196078, alpha: 1)
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9490196078, alpha: 1)
        }
        view1.frame = CGRect(x: 0, y: (navigationController?.navigationBar.frame.height)!, width: view1.frame.width, height: (self.view.frame.height - (navigationController?.navigationBar.frame.height)! - 10))
    }
    
    func displayNewMessage(text: String, type: String){
        var fontOfMessage = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        if type == "title" {
            fontOfMessage = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)
        }
        let xCoordinateMessage = 0
        let widthOfLabel = self.scrollView.frame.width - 10
        let heightOfLabel = text.height(constraintedWidth: widthOfLabel, font: fontOfMessage)
        let newMessageLabel = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: widthOfLabel, height: heightOfLabel))
        var y:CGFloat = 5
        
        if previousTypeOfText == "title" {
            y = 15
        } else if type == "title" {
            y = 40
        }
        let newMessageView = UIView(frame: CGRect(x: CGFloat(xCoordinateMessage), y: scrollView.contentSize.height + y, width: widthOfLabel, height: heightOfLabel))
        newMessageView.addSubview(newMessageLabel)
        newMessageLabel.font = fontOfMessage
        newMessageLabel.textAlignment = .natural
        newMessageLabel.numberOfLines = 0
        newMessageLabel.text = text
        newMessageLabel.isUserInteractionEnabled = false
        
        if type == "linkPP" {
            let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(tapGesturePP))
            newMessageView.addGestureRecognizer(tapRecogniser)
        }
        if type == "linkLA" {
            let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(tapGestureLA))
            newMessageView.addGestureRecognizer(tapRecogniser)
        }
        if type == "linkGLA" {
            let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(tapGestureGLA))
            newMessageView.addGestureRecognizer(tapRecogniser)
        }
        
        if type == "seperation" {
            newMessageLabel.textAlignment = .center
        }
        
        scrollView.contentSize.height = scrollView.contentSize.height + heightOfLabel + y
        self.scrollView.addSubview(newMessageView)
    }
    
    @objc func buttonAction() {
        self.view.sendSubview(toBack: view1)
        view1.isHidden = true
        navigationItem.leftBarButtonItem = nil
    }
}
