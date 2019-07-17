//
//  MenuViewController.swift
//  SiriShotcutDemo
//
//  Created by Piotr Smajek on 13/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import Foundation
import UIKit
import Intents
import CoreSpotlight
import CoreServices
import OrderKit

class MenuViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if (segue.identifier == "makeOrder") { donate() }
    }
    
    @IBAction func clearClicked(_ sender: Any) {
        Defaults.clear()
        showAlert()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Success", message: "Orders deleted", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func donate() {
        let orderActivity = NSUserActivity(activityType: Identifiers.NSUserActivity)
        orderActivity.persistentIdentifier =
            NSUserActivityPersistentIdentifier(Identifiers.NSUserActivity)
        orderActivity.isEligibleForSearch = true
        orderActivity.isEligibleForPrediction = true
        orderActivity.title = "Make an order"
        orderActivity.suggestedInvocationPhrase = "Burger time"
        
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        attributes.contentDescription = "Delicious burgers 🍔!"
        attributes.thumbnailData = UIImage(named: "logo")?.pngData()
        orderActivity.contentAttributeSet = attributes
        userActivity = orderActivity
    }
}
