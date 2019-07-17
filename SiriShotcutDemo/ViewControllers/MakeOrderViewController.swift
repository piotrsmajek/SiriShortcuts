//
//  MakeOrderViewController.swift
//  SiriShotcutDemo
//
//  Created by Piotr Smajek on 02/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import OrderKit

class MakeOrderViewController: UIViewController {
    
    @IBOutlet weak var burgerTitleTextField: DefaultTextField!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var baconSwitch: UISwitch!
    @IBOutlet weak var nachosSwitch: UISwitch!
    @IBOutlet weak var jalapenoSwitch: UISwitch!
    @IBOutlet weak var button: UIButton!
    
    private let pickerView = UIPickerView()
    
    private let viewModel = OrderViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    private func setup() {
        setupView()
        setupRx()
        setupViewModelRx()
    }
    
    private func setupView() {
        burgerTitleTextField.tintColor = .clear
        burgerTitleTextField.inputView = pickerView
    }

    private func setupRx() {
        quantityStepper.rx.controlEvent(.valueChanged)
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.setQuantityValue()
            })
            .disposed(by: disposeBag)
        
        Observable.just(viewModel.items)
            .bind(to: pickerView.rx.items) { _, text, _ in
                let label = UILabel()
                label.text = text
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 18.0)
                label.textAlignment = .center
                return label
            }
            .disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(String.self)
            .subscribe(onNext: { [weak self] values in
                guard let selectedValue = values.first else { return }
                self?.burgerTitleTextField.text = selectedValue
                self?.viewModel.setSelectedBurger(with: selectedValue)
            })
            .disposed(by: disposeBag)
        
        burgerTitleTextField.rx.controlEvent(.editingDidBegin)
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let firstElement = self?.viewModel.items.first else { return }
                self?.burgerTitleTextField.text = firstElement
                self?.viewModel.setSelectedBurger(with: firstElement)
            })
            .disposed(by: disposeBag)
        
        baconSwitch.rx.isOn.changed
            .subscribe(onNext: { [weak self] state in
                self?.viewModel.setAdditionalBacon(with: state)
            })
            .disposed(by: disposeBag)
        
        nachosSwitch.rx.isOn.changed
            .subscribe(onNext: { [weak self] state in
                self?.viewModel.setAdditionalNachos(with: state)
            })
            .disposed(by: disposeBag)
        
        jalapenoSwitch.rx.isOn.changed
            .subscribe(onNext: { [weak self] state in
                self?.viewModel.setAdditionalJalapeno(with: state)
            })
            .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.order()
                self?.navigateToSuccess()
            })
            .disposed(by: disposeBag)
    }
    
    private func setupViewModelRx() {
        viewModel.quantityDriver
            .drive(onNext: { [weak self] value in
                self?.quantityLabel.text = "\(Int(value)) pcs."
            })
            .disposed(by: disposeBag)
        
        viewModel.selectedBurgerDriver
            .drive(onNext: { [weak self] value in
                self?.burgerTitleTextField.text = value
            })
            .disposed(by: disposeBag)
    }
    
    private func setQuantityValue() {
        guard let quantityStepperValue = quantityStepper?.value else { return }
        viewModel.setQuantityValue(with: Int(quantityStepperValue))
    }
    
    private func navigateToSuccess() {
        guard let order = viewModel.burgerOrder else { return }
        let viewController: SuccessOrderViewController = UIStoryboard.instantiateVC(Scene.SuccessOrder)
        viewController.viewModel = SuccessOrderViewModel(with: order)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
