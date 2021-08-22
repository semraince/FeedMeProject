//
//  AlertInteraction.swift
//  yemeksepeti
//
//  Created by semra on 22.08.2021.
//

import Foundation
import UIKit
protocol AlertInteractionProtocol: AnyObject {
    func acceptButtonClicked()
}
final class AlertInteraction: UIView {
    static let instance = AlertInteraction()
    @IBOutlet weak var popUPView: UIView!
    @IBOutlet weak var circlerView: UIView!
    @IBOutlet weak var innerCircleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet  var parentView: UIView!
    
    weak var alertedItem: AlertInteractionProtocol?
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertInteraction", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
       popUPView.layer.cornerRadius = 4.0
        popUPView.layer.shadowColor = UIColor.black.cgColor
        popUPView.layer.shadowOpacity = 0.5
        popUPView.layer.shadowOffset = .zero
        popUPView.layer.shadowRadius = 5
        
        circlerView.layer.cornerRadius = circlerView.frame.height / 2
        circlerView.layer.shadowColor = UIColor.black.cgColor
        circlerView.layer.shadowOpacity = 0.5
        circlerView.layer.shadowOffset = .zero
        circlerView.layer.shadowRadius = 5
        
        innerCircleView.layer.cornerRadius = innerCircleView.frame.height / 2
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    @IBAction func acceptButtonPresssed(_ sender: Any) {
        alertedItem?.acceptButtonClicked()
        parentView.removeFromSuperview()
        
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        parentView.removeFromSuperview()
    }
    
    
    func showAlert(title: String, text: String, item: AlertInteractionProtocol){
        titleLabel.text = title
        messageLabel.text = text
        self.alertedItem = item
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
}
