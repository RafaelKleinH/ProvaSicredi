//
//  DetailsViewController.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 28/06/21.
//

import UIKit

final class DetailsViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {
    
    var viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        configureView()
        
        eventScrollView.delegate = self
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Descrição do evento"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow"), style: .plain, target: self, action: #selector(popToPrevious))
        let shareBar: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem:.action, target: self, action: #selector(userDidTapShare))
        
        self.navigationItem.rightBarButtonItem = shareBar
        
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
    }
    private let eventScrollView: UIScrollView = {
        let scrollView =  UIScrollView()
        return scrollView
    }()
    private let viewInScroll: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    private let eventImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return imageView
    }()
    private let eventTitleLabel: UILabel = {
        var Label = UILabel()
        Label.textColor = .white
        Label.numberOfLines = 0
        Label.lineBreakMode = .byWordWrapping
        Label.font = UIFont(name: "system", size: 18)
        return Label
    }()
    private let eventDescriptionLabel: UILabel = {
        var Label = UILabel()
        Label.textColor = .white
        Label.numberOfLines = 0
        Label.lineBreakMode = .byWordWrapping
        return Label
    }()
    private let eventDateLabel: UILabel = {
        var Label = UILabel()
        Label.textColor = .white
        Label.numberOfLines = 0
        Label.lineBreakMode = .byWordWrapping
        return Label
    }()
    private let eventPriceLabel: UILabel = {
        var Label = UILabel()
        Label.textColor = .white
        Label.numberOfLines = 0
        Label.lineBreakMode = .byWordWrapping
        return Label
    }()
    private let eventLocalLabel: UILabel = {
        var Label = UILabel()
        Label.textColor = .white
        Label.numberOfLines = 0
        Label.lineBreakMode = .byWordWrapping
        return Label
    }()
    private let presenceButton: UIButton = {
        var button = UIButton()
        button.setTitle("Marcar Presença", for: .normal)
        button.layer.borderColor =  UIColor(red: 53/255, green: 149/255, blue: 204/255, alpha: 1).cgColor
        button.layer.borderWidth = 2
        button.layer.masksToBounds = true
        return button
    }()
    
    
    func setupConstraints(){
        
        view.addSubview(eventImageView)
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,constant: 10).isActive = true
        eventImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        view.trailingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10).isActive = true
        eventImageView.heightAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        
        view.addSubview(eventScrollView)
        eventScrollView.translatesAutoresizingMaskIntoConstraints = false
        eventScrollView.topAnchor.constraint(equalTo: eventImageView.bottomAnchor,constant: 10).isActive = true
        eventScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        eventScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        eventScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        eventScrollView.addSubview(viewInScroll)
        viewInScroll.translatesAutoresizingMaskIntoConstraints = false
        viewInScroll.topAnchor.constraint(equalTo: eventScrollView.topAnchor, constant: 0).isActive = true
        viewInScroll.leadingAnchor.constraint(equalTo: eventScrollView.leadingAnchor, constant: 0).isActive = true
        viewInScroll.trailingAnchor.constraint(equalTo: eventScrollView.trailingAnchor, constant: 0).isActive = true
        viewInScroll.widthAnchor.constraint(equalTo: eventScrollView.widthAnchor).isActive = true
        viewInScroll.bottomAnchor.constraint(equalTo: eventScrollView.bottomAnchor).isActive = true
        
        
        
        
        
        viewInScroll.addSubview(eventTitleLabel)
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTitleLabel.topAnchor.constraint(equalTo: viewInScroll.topAnchor, constant: 10).isActive = true
        eventTitleLabel.leadingAnchor.constraint(equalTo: eventScrollView.leadingAnchor, constant: 12).isActive = true
        eventTitleLabel.trailingAnchor.constraint(equalTo: eventScrollView.trailingAnchor, constant: 12).isActive = true
        
        
        viewInScroll.addSubview(eventDescriptionLabel)
        eventDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        eventDescriptionLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: 10).isActive = true
        eventDescriptionLabel.leadingAnchor.constraint(equalTo: eventScrollView.leadingAnchor, constant: 12).isActive = true
        view.trailingAnchor.constraint(equalTo: eventDescriptionLabel.trailingAnchor, constant: 12).isActive = true
        
        
        viewInScroll.addSubview(eventDateLabel)
        eventDateLabel.translatesAutoresizingMaskIntoConstraints = false
        eventDateLabel.topAnchor.constraint(equalTo: eventDescriptionLabel.bottomAnchor, constant: 10).isActive = true
        eventDateLabel.leadingAnchor.constraint(equalTo: eventScrollView.leadingAnchor, constant: 12).isActive = true
        view.trailingAnchor.constraint(equalTo: eventDateLabel.trailingAnchor, constant: 12).isActive = true
        
        
        viewInScroll.addSubview(eventPriceLabel)
        eventPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        eventPriceLabel.topAnchor.constraint(equalTo:  eventDateLabel.bottomAnchor, constant: 10).isActive = true
        eventPriceLabel.leadingAnchor.constraint(equalTo: eventScrollView.leadingAnchor, constant: 12).isActive = true
        view.trailingAnchor.constraint(equalTo: eventPriceLabel.trailingAnchor, constant: 12).isActive = true
        
        viewInScroll.addSubview(eventLocalLabel)
        eventLocalLabel.translatesAutoresizingMaskIntoConstraints = false
        eventLocalLabel.topAnchor.constraint(equalTo:  eventPriceLabel.bottomAnchor, constant: 10).isActive = true
        eventLocalLabel.leadingAnchor.constraint(equalTo: eventScrollView.leadingAnchor, constant: 12).isActive = true
        view.trailingAnchor.constraint(equalTo: eventLocalLabel.trailingAnchor, constant: 12).isActive = true
        
        
        
        viewInScroll.addSubview(presenceButton)
        presenceButton.translatesAutoresizingMaskIntoConstraints = false
        presenceButton.leadingAnchor.constraint(equalTo: viewInScroll.leadingAnchor, constant: 47).isActive = true
        view.trailingAnchor.constraint(equalTo: presenceButton.trailingAnchor, constant: 47).isActive = true
        presenceButton.topAnchor.constraint(equalTo: eventLocalLabel.bottomAnchor,constant: 10).isActive = true
        
        
        presenceButton.bottomAnchor.constraint(lessThanOrEqualTo: viewInScroll.bottomAnchor,constant: -10).isActive = true
        
    }
    func configureView(){
        eventScrollView.contentSize = viewInScroll.frame.size
        eventScrollView.isScrollEnabled = true
        eventTitleLabel.text = viewModel.event.title
        eventDescriptionLabel.text = viewModel.event.description
        let date = Components().convertEpochDate(epoch: viewModel.event.date)
        eventDateLabel.text = "\(date)"
        eventPriceLabel.text = "R$: \(viewModel.event.price)"
        viewModel.getLocation { (location) in
            self.eventLocalLabel.text = location
        }
        let url = URL(string: viewModel.event.image)
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
    @objc func popToPrevious(){
        viewModel.coordinator.popToPrevius()
    }
    @objc func userDidTapShare(_ sender: UIButton) {
        let title = viewModel.event.title
        let date = Components().convertEpochDate(epoch: viewModel.event.date)
        let price = "RS: \(viewModel.event.price)"
        let activityController = UIActivityViewController(activityItems: [title, price, date], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {( nil, completed, _, error ) in
            
            if completed {
                print("Deu certin")
            }else{
                print("canceled")
                
            }
            
        }
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true){
            
        }
    }
    
}
