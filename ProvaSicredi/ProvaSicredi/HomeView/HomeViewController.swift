//
//  ViewController.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 28/06/21.
//

import UIKit

enum SetupHomeConstraintsEnum {
    case loading
    case table
    case error
}
enum EnumRemoveType {
    case tableView
    case error
}

final class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColors.BackGroundColor
        self.navigationItem.title = viewModel.navigationTitle
        let textAttributes = [NSAttributedString.Key.foregroundColor: CustomColors.BackGroundColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        configureView()
        setTexts()
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: viewModel.eventName)
        errorButton.addTarget(self, action: #selector(configureView), for: .touchDown)
    }
    
    private let eventsTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 460
        tableView.backgroundColor = CustomColors.BackGroundColor
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let loadView = UIActivityIndicatorView()
        loadView.hidesWhenStopped = true
        loadView.style = .large
        return loadView
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.SecondColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let errorButton: UIButton = {
        let button = UIButton()
        button.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: CustomFont.MontserratSemiBold, size: 16)
        button.backgroundColor = CustomColors.SecondColor
        return button
    }()
    
    private func removeItensFromSuperview(toRemove: EnumRemoveType){
        if toRemove == .error{
            errorButton.removeFromSuperview()
            errorLabel.removeFromSuperview()
        }
        else{
            eventsTableView.removeFromSuperview()
        }
    }
    
    private func setupConstraints(method: SetupHomeConstraintsEnum){
        
        if(method == .loading){
            
            view.addSubview(loadingIndicator)
            loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
            loadingIndicator.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
            loadingIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: loadingIndicator.trailingAnchor).isActive = true
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: loadingIndicator.bottomAnchor).isActive = true
            loadingIndicator.startAnimating()
            
        }else if(method == .table){
            
            self.loadingIndicator.stopAnimating()
            view.addSubview(eventsTableView)
            eventsTableView.translatesAutoresizingMaskIntoConstraints = false
            eventsTableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
            eventsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: eventsTableView.trailingAnchor).isActive = true
            eventsTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: eventsTableView.bottomAnchor).isActive = true
            
        }else if(method == .error){
            
            self.loadingIndicator.stopAnimating()
            view.addSubview(errorLabel)
            errorLabel.translatesAutoresizingMaskIntoConstraints = false
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 18).isActive = true
            view.trailingAnchor.constraint(equalTo: errorLabel.trailingAnchor, constant: 18).isActive = true
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            
            view.addSubview(errorButton)
            errorButton.translatesAutoresizingMaskIntoConstraints = false
            errorButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 12).isActive = true
            errorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 47).isActive = true
            view.trailingAnchor.constraint(equalTo: errorButton.trailingAnchor, constant: 47).isActive = true
        }
    }
    
    private func setTexts(){
        errorLabel.text = viewModel.errorLabelText
        errorButton.setTitle(viewModel.errorButtonTitle, for: .normal)
    }
    
    @objc private func configureView() {
        removeItensFromSuperview(toRemove: .error)
        setupConstraints(method: .loading)
        viewModel.getEvents { [weak self] (bool) in
            if(bool){
                DispatchQueue.main.async {
                    self?.removeItensFromSuperview(toRemove: .error)
                    self?.setupConstraints(method: .table)
                    self?.eventsTableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    self?.removeItensFromSuperview(toRemove: .tableView)
                    self?.setupConstraints(method: .error)
                }
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.events.count > 0 ? viewModel.events.count : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.eventName, for: indexPath) as! HomeTableViewCell
        cell.setupConstraints()
        let indexData = viewModel.events[indexPath.row]
        cell.createCell(with: indexData)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let naviC = navigationController{
            DetailsViewCoordinator(navigationController: naviC, event: viewModel.events[indexPath.row]).start()
        }
    }
}
