//
//  Popup.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 30/06/21.
//

import UIKit
import Foundation

enum popupType {
    case APISucces
    case APIError
    
}

class Popup: UIView{
    
    let container : UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = CustomColors.BackGroundColor
        container.layer.cornerRadius = 5
        return container
    }()
    
    let lbPopupTitle: UILabel = {
        var label = UILabel()
        label.textColor = CustomColors.SecondColor
        label.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let lbPopupSecondLabel: UILabel = {
        var label = UILabel()
        label.textColor = CustomColors.ThirdColor
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    let btPopupConfirm: UIButton = {
        var button = UIButton()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(CustomColors.SecondColor!, for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.24)
        self.frame = UIScreen.main.bounds
        
        
        self.addSubview(container)
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalToConstant: 281).isActive = true
        container.heightAnchor.constraint(equalToConstant: 211).isActive = true
        
        
        container.addSubview(lbPopupTitle)
        lbPopupTitle.topAnchor.constraint(equalTo: container.topAnchor, constant: 30).isActive = true
        lbPopupTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30).isActive = true
        
        
        container.addSubview(lbPopupSecondLabel)
        lbPopupSecondLabel.topAnchor.constraint(equalTo: lbPopupTitle.bottomAnchor, constant: 8).isActive = true
        lbPopupSecondLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30).isActive = true
        lbPopupSecondLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30).isActive = true
        lbPopupSecondLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -71).isActive = true
        
        
        self.container.addSubview(self.btPopupConfirm)
        self.btPopupConfirm.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.btPopupConfirm.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -17).isActive = true
    }
    
    func showPopup(popupType:popupType){
        
        if(popupType == .APISucces ){
            DispatchQueue.main.async {
                
                self.lbPopupTitle.text = "Feitos!"
                self.lbPopupSecondLabel.text = "Sua inscrição foi enviada. \n\nEsperamos você no evento."
                
            }
        }else if(popupType == .APIError){
            DispatchQueue.main.async {
                self.lbPopupTitle.text = "Ops algo deu errado..."
                self.lbPopupSecondLabel.text = "Sua inscrição não foi enviada. \n\nTente novamente por favor."
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
