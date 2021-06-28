//
//  ViewController.swift
//  ProvaSicredi
//
//  Created by Rafael Hartmann on 28/06/21.
//

import UIKit

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
        view.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        self.navigationItem.title = "Prova Sicredi"
        setupConstraints()
        configureView()
        
    }
    private let labelTest: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    private func setupConstraints(){
        
        view.addSubview(labelTest)
        labelTest.translatesAutoresizingMaskIntoConstraints = false
        
        labelTest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        view.trailingAnchor.constraint(equalTo: labelTest.trailingAnchor, constant: 18).isActive = true
        labelTest.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    private func configureView() {
        labelTest.text = homeViewModel.test
    }
}

