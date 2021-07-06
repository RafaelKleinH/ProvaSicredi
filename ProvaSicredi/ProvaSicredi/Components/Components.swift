
import Foundation
import MaterialComponents

class Components {
    func convertEpochDateToString(epoch: Int) -> String{
        let timeInterval = TimeInterval(epoch)
        let myDate = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: -3600*3)
        let ConvertedDate = dateFormatter.string(from: myDate as Date)
        return "\(ConvertedDate)"
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
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
}
