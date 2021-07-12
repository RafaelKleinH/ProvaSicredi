
import Foundation
import MaterialComponents
import UIKit

class Components {
    
    func styleTextFields(textfield: MDCFilledTextField, placeHolderText: String){
        textfield.heightAnchor.constraint(greaterThanOrEqualToConstant: 56).isActive = true
        textfield.widthAnchor.constraint(greaterThanOrEqualToConstant: 300).isActive = true
        textfield.adjustsFontSizeToFitWidth = true
        textfield.preferredContainerHeight = 56
        textfield.font = UIFont(name:"Montserrat-Regular", size: 16)
        textfield.placeholder = placeHolderText
        textfield.label.text = textfield.placeholder
        textfield.setTextColor(CustomColors.SecondColor!, for: .normal)
        textfield.setTextColor(CustomColors.SecondColor!, for: .editing)
        textfield.setFilledBackgroundColor(CustomColors.BackGroundColor!, for: .normal)
        textfield.setFilledBackgroundColor(CustomColors.BackGroundColor!, for: .editing)
        textfield.setUnderlineColor(CustomColors.SecondColor!, for: .normal)
        textfield.setUnderlineColor(CustomColors.SecondColor!, for: .editing)
        textfield.setNormalLabelColor(CustomColors.SecondColor!, for: .normal)
        textfield.setFloatingLabelColor(CustomColors.SecondColor!, for: .normal)
        textfield.setFloatingLabelColor(CustomColors.SecondColor!, for: .editing)
        textfield.setLeadingAssistiveLabelColor(CustomColors.SecondColor!, for: .editing)
        textfield.setLeadingAssistiveLabelColor(CustomColors.SecondColor!, for: .normal)
    }
    
    func styleDetailsViewLabels(color: UIColor?, Label: UILabel, fontSize: CGFloat, font: String){
        Label.textColor = .white
        Label.numberOfLines = 0
        Label.lineBreakMode = .byWordWrapping
        Label.textColor = color
        Label.font = UIFont(name: font, size: fontSize)
    }
}
