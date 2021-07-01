//
//  HomeTableViewCell.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 28/06/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    private let eventTitleLabel : UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Montserrat-SemiBold", size: 18)
        label.textColor = CustomColors.SecondColor
        return label
    }()
    private let eventImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return imageView
    }()
    private let eventDateLabel : UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = CustomColors.ThirdColor
        return label
    }()
    private let eventPriceLabel : UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = CustomColors.ThirdColor
        return label
    }()
    func setupConstraints(){
        backgroundColor = CustomColors.BackGroundColor
        
        addSubview(eventImageView)
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        eventImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        eventImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: eventImageView.trailingAnchor).isActive = true
        eventImageView.heightAnchor.constraint(equalToConstant: self.bounds.width - 20).isActive = true
        
        
        addSubview(eventTitleLabel)
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTitleLabel.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 8).isActive = true
        eventTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.trailingAnchor.constraint(equalTo: eventTitleLabel.trailingAnchor, constant: 8).isActive = true
        
        
        addSubview(eventDateLabel)
        eventDateLabel.translatesAutoresizingMaskIntoConstraints = false
        eventDateLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: 8).isActive = true
        eventDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.trailingAnchor.constraint(equalTo: eventDateLabel.trailingAnchor, constant: 8).isActive = true
        
        
        addSubview(eventPriceLabel)
        eventPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        eventPriceLabel.topAnchor.constraint(equalTo: eventDateLabel.bottomAnchor, constant: 8).isActive = true
        eventPriceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.trailingAnchor.constraint(equalTo: eventPriceLabel.trailingAnchor, constant: 8).isActive = true
        
    }
    
    
    func createCell(with event: Event){
        eventImageView.image = UIImage(named: "imageError")
        eventTitleLabel.text = event.title
        let date = Components().convertEpochDateToString(epoch: event.date)
        eventDateLabel.text = "Data: \(date)"
        eventPriceLabel.text = "R$: \(event.price)"
        let url = URL(string: event.image)
        if let url = url {
        Components().getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.eventImageView.image = UIImage(data:data) ?? UIImage(named: "imageError")
                }
            }
        }
    }
}
