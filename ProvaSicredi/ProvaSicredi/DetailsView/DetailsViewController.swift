import UIKit
import MapKit

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
        navigationItem.title = DetailsViewStrings().navigationTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: DetailsViewStrings().leftBarButtonImage), style: .plain, target: self, action: #selector(popToPrevious))
        let shareBar: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem:.action, target: self, action: #selector(userDidTapShare))
        presenceButton.addTarget(self, action: #selector(goToPresenceView), for: .touchDown)
        self.navigationItem.rightBarButtonItem = shareBar
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        let textAttributes = [NSAttributedString.Key.foregroundColor: CustomColors.BackGroundColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = CustomColors.BackGroundColor
    }
    
    private let eventScrollView: UIScrollView = {
        let scrollView =  UIScrollView()
        scrollView.backgroundColor = CustomColors.BackGroundColor
        return scrollView
    }()
    private let viewInScroll: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColors.BackGroundColor
        return view
    }()
    private let eventImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return imageView
    }()
    private let eventTitleLabel: UILabel = {
        var Label = UILabel()
        Label.numberOfLines = 0
        Label.lineBreakMode = .byWordWrapping
        Label.textColor = CustomColors.SecondColor
        Label.font = UIFont(name: CustomFont.MontserratBold, size: 18)
        return Label
    }()
    private let eventDescriptionLabel: UILabel = {
        var Label = UILabel()
        Label.textColor = .white
        Label.numberOfLines = 0
        Label.lineBreakMode = .byWordWrapping
        Label.textColor = CustomColors.ThirdColor
        Label.font = UIFont(name: CustomFont.MontserratLight, size: 14)
        return Label
    }()
    private let eventDateLabel: UILabel = {
        var Label = UILabel()
        Label.textColor = .white
        Label.numberOfLines = 0
        Label.lineBreakMode = .byWordWrapping
        Label.textColor = CustomColors.SecondColor
        Label.font = UIFont(name: CustomFont.MontserratSemiBold, size: 14)
        return Label
    }()
    private let eventPriceLabel: UILabel = {
        var Label = UILabel()
        Label.textColor = .white
        Label.numberOfLines = 0
        Label.lineBreakMode = .byWordWrapping
        Label.textColor = CustomColors.SecondColor
        Label.font = UIFont(name: CustomFont.MontserratSemiBold, size: 14)
        return Label
    }()
    private let eventLocalLabel: UILabel = {
        var Label = UILabel()
        Label.textColor = .white
        Label.numberOfLines = 0
        Label.lineBreakMode = .byWordWrapping
        Label.textColor = CustomColors.SecondColor
        Label.font = UIFont(name: CustomFont.MontserratSemiBold, size: 14)
        return Label
    }()
    private let mapView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        return view
    }()
    private let eventMap = MKMapView()
    
    private let presenceButton: UIButton = {
        var button = UIButton()
        
        button.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: CustomFont.MontserratSemiBold, size: 16)
        button.backgroundColor = CustomColors.SecondColor
        return button
    }()
    
    
    func setupConstraints(){
        
        view.addSubview(eventScrollView)
        eventScrollView.translatesAutoresizingMaskIntoConstraints = false
        eventScrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
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
        
        
        viewInScroll.addSubview(eventImageView)
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.topAnchor.constraint(equalTo: viewInScroll.topAnchor,constant: 0).isActive = true
        eventImageView.leadingAnchor.constraint(equalTo: viewInScroll.leadingAnchor, constant: 0).isActive = true
        viewInScroll.trailingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 0).isActive = true
        eventImageView.heightAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        
        
        viewInScroll.addSubview(eventTitleLabel)
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTitleLabel.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 10).isActive = true
        eventTitleLabel.leadingAnchor.constraint(equalTo: eventScrollView.leadingAnchor, constant: 12).isActive = true
        eventScrollView.trailingAnchor.constraint(equalTo: eventTitleLabel.trailingAnchor, constant: 12).isActive = true
        
        
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
        
        
        viewInScroll.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: eventLocalLabel.bottomAnchor, constant: 12).isActive = true
        mapView.leadingAnchor.constraint(equalTo: eventScrollView.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: 0).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        
        
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = (view.frame.size.width)
        let mapHeight:CGFloat = (view.frame.size.width)
        
        eventMap.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        eventMap.mapType = MKMapType.standard
        eventMap.isZoomEnabled = true
        eventMap.isScrollEnabled = true
        mapView.addSubview(eventMap)
        
        viewInScroll.addSubview(presenceButton)
        presenceButton.translatesAutoresizingMaskIntoConstraints = false
        presenceButton.leadingAnchor.constraint(equalTo: viewInScroll.leadingAnchor, constant: 47).isActive = true
        view.trailingAnchor.constraint(equalTo: presenceButton.trailingAnchor, constant: 47).isActive = true
        presenceButton.topAnchor.constraint(equalTo: eventMap.bottomAnchor,constant: 24).isActive = true
        presenceButton.bottomAnchor.constraint(lessThanOrEqualTo: viewInScroll.bottomAnchor,constant: -24).isActive = true
        
    }
    
    func configureView(){
        eventLocalLabel.text = "Buscando..."
        eventImageView.image = UIImage(named: "imageError")
        presenceButton.setTitle(DetailsViewStrings().presenceButtonText, for: .normal)
        eventScrollView.isScrollEnabled = true
        eventTitleLabel.text = viewModel.event.title
        eventDescriptionLabel.text = viewModel.event.description
        let date = Components().convertEpochDateToString(epoch: viewModel.event.date)
        eventDateLabel.text = date
        eventPriceLabel.text = "\(DetailsViewStrings().priceLabelText) \(viewModel.event.price)"
        viewModel.eventPinLocation(eventMap: eventMap)
        viewModel.getEventLocation() { [weak self] (location) in
            let localLabelText = DetailsViewStrings().localLabelText 
            self?.eventLocalLabel.text = "\(localLabelText) \(location)"
        }
        viewModel.decodeImageFromAPI { [weak self] (image) in
            DispatchQueue.main.async {
                self?.eventImageView.image = image
            }
        }
    }
    
    @objc func popToPrevious(){
        viewModel.coordinator.popToPrevius()
    }
    @objc func goToPresenceView(){
        viewModel.coordinator.goToPresenceView()
    }
    @objc func userDidTapShare() {
        viewModel.shareEvent(with: viewModel.event, image: eventImageView.image) { (ActivityViewController) in
            self.present(ActivityViewController, animated: true) {
                
            }
        }
    }
}
