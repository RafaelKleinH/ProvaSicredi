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
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    private let eventTitleLabel : UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Montserrat-SemiBold", size: 18)
        label.textColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 1)
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
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        return label
    }()
    private let eventPriceLabel : UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        return label
    }()
    func setupConstraints(){
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        addSubview(eventImageView)
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        
        eventImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
        eventImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        eventImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.trailingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10).isActive = true
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
        eventTitleLabel.text = event.title
        let date = Components().convertEpochDate(epoch: event.date)
        eventDateLabel.text = "Data: \(date)"
        eventPriceLabel.text = "R$: \(event.price)"
        let url = URL(string: event.image)
        if let url = url {
            DispatchQueue.main.async {
                if let data = try? Data(contentsOf: url){
                    
                    self.eventImageView.image = UIImage(data:data)
                }else{
                    self.eventImageView.image = UIImage(named: "imageError")
                }
            }
        }
        
    }
}
