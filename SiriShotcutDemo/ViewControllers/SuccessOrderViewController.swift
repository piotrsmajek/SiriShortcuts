//
//  SuccessOrderViewController.swift
//  SiriShotcutDemo
//
//  Created by Piotr Smajek on 13/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import Foundation
import UIKit
import OrderKit
import IntentsUI

class SuccessOrderViewController: UIViewController {
    
    @IBOutlet weak var burgerNameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var additionsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var viewModel: SuccessOrderViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addSiriButton()
    }
    
    private func setup() {
        guard let order = viewModel?.order else { return }
        burgerNameLabel.text = order.name
        quantityLabel.text = "\(String(order.quantity)) pcs."

        additionsLabel.text = order.additions.isEmpty ? "-" : order.additions.toString
        dateLabel.text = order.date.toString
    }
    
    private func addSiriButton() {
        guard let order = viewModel?.order else { return }
        let addShortcutButton = INUIAddVoiceShortcutButton(style: .blackOutline)
        addShortcutButton.shortcut = INShortcut(intent: order.intent)
        addShortcutButton.delegate = self
        
        addShortcutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addShortcutButton)
        view.centerXAnchor.constraint(equalTo: addShortcutButton.centerXAnchor).isActive = true
        addShortcutButton.bottomAnchor.constraint(equalTo: button.topAnchor,
                                                  constant: -25.0).isActive = true
    }
    
    @IBAction func showOrders(_ sender: Any) {
        let viewController = UIStoryboard.instantiateVC(Scene.OrdersTableView)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SuccessOrderViewController: INUIAddVoiceShortcutButtonDelegate {
    
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
}

extension SuccessOrderViewController: INUIAddVoiceShortcutViewControllerDelegate {
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController,
                                        didFinishWith voiceShortcut: INVoiceShortcut?,
                                        error: Error?) {
        if let error = error as NSError? { print(error) }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension SuccessOrderViewController: INUIEditVoiceShortcutViewControllerDelegate {
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController,
                                         didUpdate voiceShortcut: INVoiceShortcut?,
                                         error: Error?) {
        if let error = error as NSError? { print(error) }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController,
                                         didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
