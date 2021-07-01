

import UIKit
import Foundation
import MaterialComponents

final class PresenceViewController: UIViewController {
    
    var viewModel: PresenceViewModel
    let pop = Popup()
    var activeTextField : UITextField? = nil
    
    init(viewModel: PresenceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Inscrição"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow"), style: .plain, target: self, action: #selector(popToPrevious))
        setupConstraints()
        submitButton.addTarget(self, action: #selector(validateTextFields), for: .touchDown)
        pop.btPopupConfirm.addTarget(self, action: #selector(popPopup), for: .touchDown)
        let textAttributes = [NSAttributedString.Key.foregroundColor: CustomColors.BackGroundColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = CustomColors.BackGroundColor
    }
    
    @objc func popToPrevious(){
        viewModel.coordinator.popToPrevius()
    }
    
    private let nameTextField: MDCFilledTextField = {
        var tf = MDCFilledTextField()
        tf.placeholder = "Nome"
        Components().styleTextFields(textfield: tf)
        tf.tag = 1
        return tf
    }()
    private let emailTextField: MDCFilledTextField = {
        var tf = MDCFilledTextField()
        tf.placeholder = "Email"
        Components().styleTextFields(textfield: tf)
        tf.tag = 2
        return tf
    }()
    private let submitButton: UIButton = {
        var button = UIButton()
        button.setTitle("Enviar", for: .normal)
        button.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        button.backgroundColor = CustomColors.SecondColor
        button.setTitleColor(CustomColors.BackGroundColor!, for: .normal)
        return button
    }()
    
    private func setupConstraints(){
        view.backgroundColor = CustomColors.BackGroundColor
        
        
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.delegate = self
        nameTextField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 6).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27).isActive = true
        view.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 27).isActive = true
        
        
        
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.delegate = self
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 18).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27).isActive = true
        view.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: 27).isActive = true
        
        
        
        view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 47).isActive = true
        view.trailingAnchor.constraint(equalTo: submitButton.trailingAnchor, constant: 47).isActive = true
        
    }
    
    @objc func validateTextFields() {
        submitButton.isUserInteractionEnabled = false
        if nameTextField.text != "" {
            
            nameTextField.leadingAssistiveLabel.text = ""
            
            if emailTextField.text != "" && ((emailTextField.text?.isValidEmail) == true) {
                
                emailTextField.leadingAssistiveLabel.text = ""
                
                guard let emailText = emailTextField.text,let name = nameTextField.text else {return}
                viewModel.postPresence(email: emailText, name: name) { (error) in
                    self.verifyAPIResponseHaveError(error: error)
                    
                }
            }else{
                
                submitButton.isUserInteractionEnabled = true
                emailTextField.leadingAssistiveLabel.text = "Insira um email válido."
                
            }
        }else {
            
            submitButton.isUserInteractionEnabled = true
            nameTextField.leadingAssistiveLabel.text = "Insira um nome válido"
            
        }
    }
    func verifyAPIResponseHaveError(error: ErrorType?){
   
        if error == nil {
            DispatchQueue.main.async {
                self.view.endEditing(true)
                self.submitButton.isUserInteractionEnabled = true
                self.pop.showPopup(popupType: .APISucces)
                self.view.addSubview(self.pop)
            }
        }else{
            DispatchQueue.main.async {
                self.view.endEditing(true)
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
extension PresenceViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    func textFieldDidEndEditing(_ textfield: UITextField) {
        self.activeTextField = nil
        if let nextField = view.viewWithTag(textfield.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}


