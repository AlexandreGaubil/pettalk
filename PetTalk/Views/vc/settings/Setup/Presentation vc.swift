//
//  PresentViewController.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 18-01-08.
//  Copyright © 2018-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

class PresentViewController: UIViewController {

    @IBOutlet weak var privacyPolicyLabel: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var agreeButton: UIButton!
    
    
    @objc func buttonAction() {
        self.view.sendSubview(toBack: view1)
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        view1.isHidden = true
        navigationItem.leftBarButtonItem = nil
    }
    
    
    
    @objc func handleTap() {
        let alertVC = UIAlertController(title: "What do you wish to read?", message: "Please select the contract you wish to view.", preferredStyle: .actionSheet)
        /*let viewPrivacyPolicy = UIAlertAction(title: "Privacy Policy", style: .default, handler: { (handler) in self.createWebView(resourceName: "PrivacyPolicy") })
        let viewLicenceAgreement = UIAlertAction(title: "Licence Agreement", style: .default, handler: { (handler) in self.createWebView(resourceName: "LicenceAgreement") })
        let viewGoogleLicenceAgreement = UIAlertAction(title: "Firebase's Licence Agreement", style: .default, handler: { (handler) in self.createWebView(resourceName: "GoogleLicenceAgreement") })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: {(handler) in alertVC.dismiss(animated: true, completion: nil)})*/
        
        let viewPrivacyPolicy = UIAlertAction(title: "Privacy Policy", style: .default, handler: { (handler) in self.openWebPage("https://pettalkapp.wordpress.com/privacy-policy/") })
        let viewLicenceAgreement = UIAlertAction(title: "Licence Agreement", style: .default, handler: { (handler) in self.openWebPage("https://pettalkapp.wordpress.com/licence-agreement/") })
        let viewGoogleLicenceAgreement = UIAlertAction(title: "Firebase's Licence Agreement", style: .default, handler: { (handler) in self.openWebPage("https://pettalkapp.wordpress.com/google-licence-agreement/") })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: {(handler) in alertVC.dismiss(animated: true, completion: nil)})
        
        alertVC.addAction(viewPrivacyPolicy)
        alertVC.addAction(viewLicenceAgreement)
        alertVC.addAction(viewGoogleLicenceAgreement)
        alertVC.addAction(cancelButton)
        
        self.present(alertVC, animated: true)
    }
    
    func openWebPage(_ URLString: String) { 
        if let url = URL(string: URLString),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    /*func createWebView(resourceName: String) {
        view1.isHidden = false
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        }
        let webView = UIWebView(frame: CGRect(x: 0, y: 10, width: self.view.frame.width, height: self.view.frame.height))
        
        let barButtonOK = UIBarButtonItem(title: "Dismiss", style: .done, target: self, action: #selector(buttonAction))
        
        navigationItem.leftBarButtonItem = barButtonOK
        
        do {
            guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "html")
                else {
                    // File Error
                    print ("File reading error")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Defaults.bool(forKey: UserDefaultsKeys.loggedIn) {
            self.dismiss(animated: false, completion: nil)
        }
        
        
        agreeButton.backgroundColor = globalUIVariables.colorUserBoy
        agreeButton.setTitleColor(UIColor.white, for: .normal)
        agreeButton.layer.cornerRadius = 5
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        privacyPolicyLabel.addGestureRecognizer(tap)
        privacyPolicyLabel.isUserInteractionEnabled = true
        
        navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
}
