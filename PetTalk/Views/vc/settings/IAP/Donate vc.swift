//
//  DonateViewController.swift
//  PetTalk
//
//  Created by Alexandre Gaubil on 17-10-10.
//  Copyright © 2017-2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import StoreKit
import FirebaseAnalytics

class DonateViewController: UIViewController {

    @IBOutlet weak var donate199Button: UIButton!
    @IBOutlet weak var leaveReviewButton: UIButton!
    
    var timer = Timer()
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        //if timerTest == nil {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updatePrice), userInfo: nil, repeats: true)
        //}
    }
    
    func stopTimer() { timer.invalidate() }
    
    @objc func updatePrice(){
        self.donate199Button.setTitle("Donate " + globalPrice, for: .normal)
        //print(globalPrice)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donate199Button.setTitleColor(UIColor.white, for: .normal)
        donate199Button.layer.cornerRadius = 5
        leaveReviewButton.setTitleColor(UIColor.white, for: .normal)
        leaveReviewButton.layer.cornerRadius = 5
        
        scheduledTimerWithTimeInterval()
        
        IAPHandler.shared.fetchAvailableProducts()
        IAPHandler.shared.purchaseStatusBlock = {[weak self] (type) in
            guard let strongSelf = self else{ return }
            if type == .purchased {
                let alertView = UIAlertController(title: "", message: type.message(), preferredStyle: .alert)
                let action = UIAlertAction(title: TextForAlerts.ok, style: .default, handler: { (alert) in
                    
                })
                self?.present(createDismissableAlert(title: "Thank you!", text: "Thank you very much for your support! 😄", buttonText: "You're welcome!"), animated: true, completion: nil)
                alertView.addAction(action)
                strongSelf.present(alertView, animated: true, completion: nil)
            } else if type == .disabled {
                self?.present(createDismissableAlert(title: "Purchases are disabled on this device", text: "Please enable purchases first", buttonText: TextForAlerts.ok), animated: true, completion: nil)
            }
        }
        
        
        if globalInformation.color == "blue" {
            self.navigationController?.navigationBar.tintColor = globalUIVariables.colorUserBoy
            self.view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 1, blue: 1, alpha: 1)
            donate199Button.backgroundColor = globalUIVariables.colorUserBoy
            leaveReviewButton.backgroundColor = globalUIVariables.colorUserBoy
        } else {
            self.navigationController?.navigationBar.tintColor = globalUIVariables.colorUserGirl
            self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9490196078, alpha: 1)
            donate199Button.backgroundColor = globalUIVariables.colorUserGirl
            leaveReviewButton.backgroundColor = globalUIVariables.colorUserGirl
        }
        
        Analytics.logEvent("donate_view_opened", parameters: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
    @IBAction func Donate199USD(_ sender: Any) {
        IAPHandler.shared.purchaseMyProduct(index: 0)
        Analytics.logEvent("make_donation_button_clicked", parameters: nil)
    }
    
    @IBAction func leaveReview(_ sender: Any) {
        let urlStr = "itms-apps://itunes.apple.com/app/id1347714415" // (Option 2) Open App Review Tab
        
        
        if let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        Analytics.logEvent("leave_review_button_clicked", parameters: nil)
    }
}
