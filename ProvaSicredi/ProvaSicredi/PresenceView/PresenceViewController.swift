

import UIKit
import Foundation

final class PresenceViewController: UIViewController {
    
    var viewModel: PresenceViewModel
    let pop = Popup()
    
    init(viewModel: PresenceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Inscrição"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow"), style: .plain, target: self, action: #selector(popToPrevious))
        setupConstraints()
        submitButton.addTarget(self, action: #selector(validateTextFields), for: .touchDown)
        pop.btPopupConfirm.addTarget(self, action: #selector(popPopup), for: .touchDown)
    }
    @objc func popToPrevious(){
        viewModel.coordinator.popToPrevius()
    }
    private let nameLabel: UILabel = {
        var Label = UILabel()
        Label.numberOfLines = 0
        Label.text = "Nome:"
        Label.lineBreakMode = .byWordWrapping
        Label.textColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 1)
        Label.font = UIFont(name: "Montserrat-Bold", size: 18)
        return Label
    }()
    private let nameTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "Nome ex: Miguel da Silva"
        tf.font = UIFont(name: "Montserrat-Light", size: 18)
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 6
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(1, 0, 30)
        let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
        tf.bounds.inset(by: padding)
        return tf
    }()
    private let nameErrorLabel: UILabel = {
        var Label = UILabel()
        Label.numberOfLines = 0
        Label.text = "Insira um nome válido."
        Label.lineBreakMode = .byWordWrapping
        Label.textColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 0)
        Label.font = UIFont(name: "Montserrat-Light", size: 12)
        return Label
    }()
    private let emailLabel: UILabel = {
        var Label = UILabel()
        Label.numberOfLines = 0
        Label.text = "Email:"
        Label.lineBreakMode = .byWordWrapping
        Label.textColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 1)
        Label.font = UIFont(name: "Montserrat-Bold", size: 18)
        return Label
    }()
    private let emailTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "Email ex: xxxx@gmail.com"
        tf.font = UIFont(name: "Montserrat-Light", size: 18)
        tf.layer.borderWidth = 2
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(1, 0, 30)
        tf.layer.borderColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 6
        return tf
    }()
    private let emailErrorLabel: UILabel = {
        var Label = UILabel()
        Label.numberOfLines = 0
        Label.text = "Insira um email válido."
        Label.lineBreakMode = .byWordWrapping
        Label.textColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 0)
        Label.font = UIFont(name: "Montserrat-Light", size: 12)
        return Label
    }()
    private let submitButton: UIButton = {
        var button = UIButton()
        button.setTitle("Enviar", for: .normal)
        button.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        button.backgroundColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 1)
        return button
    }()
    
    private func setupConstraints(){
        view.backgroundColor = .white
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 27).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27).isActive = true
        view.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 27).isActive = true
        
        
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27).isActive = true
        view.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 27).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        
        view.addSubview(nameErrorLabel)
        nameErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        nameErrorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 4).isActive = true
        nameErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27).isActive = true
        view.trailingAnchor.constraint(equalTo: nameErrorLabel.trailingAnchor, constant: 27).isActive = true
        
        
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: nameErrorLabel.bottomAnchor, constant: 10).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27).isActive = true
        view.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 27).isActive = true
        
        
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27).isActive = true
        view.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: 27).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        
        view.addSubview(emailErrorLabel)
        emailErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        emailErrorLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 4).isActive = true
        emailErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27).isActive = true
        view.trailingAnchor.constraint(equalTo: emailErrorLabel.trailingAnchor, constant: 27).isActive = true
        
        
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.topAnchor.constraint(equalTo: emailErrorLabel.bottomAnchor, constant: 10).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 47).isActive = true
        view.trailingAnchor.constraint(equalTo: submitButton.trailingAnchor, constant: 47).isActive = true
        
    }
    
    @objc func validateTextFields() {
        submitButton.isUserInteractionEnabled = false
        if nameTextField.text != "" {
            nameErrorLabel.textColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 0)
            if emailTextField.text != "" && ((emailTextField.text?.isValidEmail) == true) {
                guard let emailText = emailTextField.text,let name = nameTextField.text else {return}
                viewModel.postPresence(email: emailText, name: name) { (error) in
                    self.verifyError(error: error)
                }
                emailErrorLabel.textColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 0)
            }else{
                submitButton.isUserInteractionEnabled = true
                emailErrorLabel.textColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 1)
            }
        }else {
            submitButton.isUserInteractionEnabled = true
            nameErrorLabel.textColor = UIColor(red: 252/255, green: 25/255, blue: 63/255, alpha: 1)
        }
    }
    func verifyError(error: ErrorType?){
        if error == nil {
            DispatchQueue.main.async {
                self.submitButton.isUserInteractionEnabled = true
                self.pop.showPopup(popupType: .APISucces)
                self.view.addSubview(self.pop)
            }
        }else{
            DispatchQueue.main.async {
                self.submitButton.isUserInteractionEnabled = true
                self.pop.showPopup(popupType: .APIError)
                self.view.addSubview(self.pop)
            }
           
        }
    }
    @objc func popPopup(){
        pop.removeFromSuperview()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

