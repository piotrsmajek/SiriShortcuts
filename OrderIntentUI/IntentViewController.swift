//
//  IntentViewController.swift
//  OrderIntentUI
//
//  Created by Piotr Smajek on 13/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import IntentsUI
import OrderKit

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    @IBOutlet weak var burgerNameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var additionsLabel: UILabel!
    @IBOutlet weak var waitTime: UILabel!
    @IBOutlet weak var everythingIsOkLabel: UILabel!
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>,
                       of interaction: INInteraction,
                       interactiveBehavior: INUIInteractiveBehavior,
                       context: INUIHostedViewContext,
                       completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        
        guard let intent = interaction.intent as? OrderIntent else {
            completion(false, Set(), .zero)
            return
        }
        if interaction.intentHandlingStatus == .ready {
            setup(with: intent)
            waitTime.isHidden = true
            completion(true, parameters, desiredSize)
        } else if interaction.intentHandlingStatus == .success,
            let response = interaction.intentResponse as? OrderIntentResponse {
            setup(with: intent)
            waitTime.isHidden = false
            if let waitTimeText = response.waitTime {
                waitTime.text = "Order will be ready in \(waitTimeText) minutes"
            }
            everythingIsOkLabel.text = "Tap to show orders 😎 🍔"
            completion(true, parameters, desiredSize)
        }
        
        // Do configuration here, including preparing views and calculating a desired size for presentation.
        completion(false, parameters, .zero)
    }
    
    private func setup(with intent: OrderIntent) {
        burgerNameLabel.text = intent.burgerName
        if let quantity = intent.quantity?.stringValue {
            quantityLabel.text = "\(quantity) pcs."
        }
        if let additions = intent.additions {
            additionsLabel.text = additions.elements.toString
        }
    }
    
    private var desiredSize: CGSize {
        let width = extensionContext?.hostedViewMaximumAllowedSize.width ?? 320
        return CGSize(width: width, height: 180)
    }
    
}
