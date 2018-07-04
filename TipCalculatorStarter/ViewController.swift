//
//  ViewController.swift
//  TipCalculatorStarter
//
//  Created by Chase Wang on 9/19/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - View Lifecycle
    
    var isDefaultStatusBar = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDefaultStatusBar ? .default : .lightContent
    }
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var themeswich: UISwitch!
    
    @IBOutlet weak var inputCard: UIView!
    
    @IBOutlet weak var billAmountTextField: BillAmountTextField!
    @IBOutlet weak var tipPercentSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var outputCard: UIView!
    @IBOutlet weak var tipAmLabel: UILabel!
    @IBOutlet weak var tipValueLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        billAmountTextField.calculateButtonAction = {
             self.calculate()
        }
    }
    
    @IBAction func themeToggled(_ sender: UISwitch) {
        if sender.isOn {
            print("switch toggled on")
        } else {
            print("switch toggled off")
        }
    }
    
    @IBAction func tipPercentChanged(_ sender: UISegmentedControl) {
        calculate()
    }
    
    @IBAction func resetButtonTap(_ sender: Any) {
        clear()
    }
    
    func calculate() {
        if self.billAmountTextField.isFirstResponder {
            self.billAmountTextField.resignFirstResponder()
        }
        
        guard let billAmountText = self.billAmountTextField.text,
            let billAmount = Double(billAmountText) else {
                clear()
                return
        }
        
        let roundedBillAmount = (100 * billAmount).rounded() / 100
        
        let tipPercent: Double
        
        switch tipPercentSegmentedControl.selectedSegmentIndex {
            case 0:
                tipPercent = 0.15
                print("15")
            case 1:
                tipPercent = 0.18
                print("18")
            case 2:
                tipPercent = 0.20
                print("20")
            default:
                preconditionFailure("Unexpected index.")
        }
        
        let tipAmount = roundedBillAmount * tipPercent
        let roundedTipAmount = (100 * tipAmount).rounded() / 100
        
        let totalAmount = roundedBillAmount + roundedTipAmount
        self.billAmountTextField.text = String(format: "%.2f", roundedBillAmount)
        self.tipValueLabel.text = String(format: "%.2f", roundedTipAmount)
        self.totalValueLabel.text = String(format: "%.2f", totalAmount)
    }
    
    func clear() {
        billAmountTextField.text = nil
        tipPercentSegmentedControl.selectedSegmentIndex = 0
        tipValueLabel.text = "$0.00"
        totalValueLabel.text = "$0.00"
    }
    
    func setupViews() {
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        headerView.layer.shadowOpacity = 0.05
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowRadius = 35
        
        inputCard.layer.cornerRadius = 8
        inputCard.layer.masksToBounds = true
        
        outputCard.layer.cornerRadius = 8
        outputCard.layer.masksToBounds = true
        
        resetButton.layer.cornerRadius = 8
        resetButton.layer.masksToBounds = true
    }
    
    func setTheme(isDark: Bool) {
        let theme = isDark ? ColorTheme.dark : ColorTheme.light
        
        view.backgroundColor = theme.viewControllerBackgroundColor
        
        headerView.backgroundColor = theme.primaryColor
        headerTitle.textColor = theme.primaryTextColor
        
        inputCard.backgroundColor = theme.secondaryColor
        
        billAmountTextField.tintColor = theme.accentColor
        tipPercentSegmentedControl.tintColor = theme.accentColor
        
        outputCard.backgroundColor = theme.primaryColor
        outputCard.layer.borderColor = theme.accentColor.cgColor
        
        tipValueLabel.textColor = theme.primaryTextColor
        totalValueLabel.textColor = theme.primaryTextColor
        
        tipAmLabel.textColor = theme.outputTextColor
        totalLabel.textColor = theme.outputTextColor
        
        resetButton.backgroundColor = theme.secondaryColor
        
        isDefaultStatusBar = theme.isDefaultStatusBar
        setNeedsStatusBarAppearanceUpdate()
    }
    
}

