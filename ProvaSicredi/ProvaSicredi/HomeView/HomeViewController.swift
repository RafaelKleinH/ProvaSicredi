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
    
    var homeViewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        homeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.title = "Eventos"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        configureView()
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "eventCell")
        errorButton.addTarget(self, action: #selector(configureView), for: .touchDown)
        
    }
    private let eventsTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 460
        tableView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
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
        label.textColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Ops! \n Ocorreu algum erro. \n Clique no botão para tentar novamente."
        return label
    }()
    private let errorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Recarregar", for: .normal)
        button.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        button.backgroundColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 1)
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
   
    
    @objc private func configureView() {
        removeItensFromSuperview(toRemove: .error)
        setupConstraints(method: .loading)
        
        homeViewModel.getEvents { (bool) in
            if(bool){
                
                DispatchQueue.main.async {
                    self.removeItensFromSuperview(toRemove: .error)
                    self.setupConstraints(method: .table)
                    self.eventsTableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    self.removeItensFromSuperview(toRemove: .tableView)
                    self.setupConstraints(method: .error)
                }
            }
        }
    }
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.events.count > 0 ? homeViewModel.events.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! HomeTableViewCell
        cell.setupConstraints()
        let indexData = homeViewModel.events[indexPath.row]
        cell.createCell(with: indexData)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let naviC = navigationController{
            DetailsViewCoordinator(navigationController: naviC, event: homeViewModel.events[indexPath.row]).start()
        }
    }
    
    
}
