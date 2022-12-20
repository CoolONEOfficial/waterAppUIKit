//
//  ViewController.swift
//  waterAppUIKit
//
//  Created by Nikolay Truhin on 20/12/22.
//

import UIKit

private enum Constants {
    static let target: Float = 3000
    static let animationDuration: CGFloat = 0.3
}

class ViewController: UIViewController {

    private let screen = UIScreen.main.bounds
    
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var middleLabel: UILabel!
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var addButton: UIButton!
    
    private var value: Float = 0 {
        didSet {
            updateUI()
            UIView.animate(withDuration: Constants.animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
}

private extension ViewController {
    var scale: Float {
        value / Constants.target
    }
    
    @IBAction func didTapAdd(_ sender: Any) {
        value += 250
    }
    
    func updateUI() {
        heightConstraint.constant = screen.height * CGFloat(scale)
        topLabel.text = "Осталось:\n\(Int(Constants.target - value)) ml"
        middleLabel.text = "Выпито:\n\(Int(value)) ml"
        addButton.isEnabled = value < Constants.target
        
        UIView.transition(with: middleLabel, duration: Constants.animationDuration, options: .transitionCrossDissolve) {
            self.middleLabel.textColor = self.value < Constants.target / 2 ? .textColor : .white
        }
        
        UIView.transition(with: topLabel, duration: Constants.animationDuration, options: .transitionCrossDissolve) {
            self.topLabel.textColor = self.value < Constants.target / 8 * 7 ? .textColor : .white
        }
    }
}

extension UIColor {
    static let textColor = UIColor(red: 0.008, green: 0.467, blue: 0.741, alpha: 1)
    static let secondaryColor = UIColor(red: 0.557, green: 0.831, blue: 0.969, alpha: 1)
    static let primaryColor = UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 1)
}
