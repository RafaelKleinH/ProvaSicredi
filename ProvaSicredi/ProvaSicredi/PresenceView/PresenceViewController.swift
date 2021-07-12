import UIKit
import Foundation
import MaterialComponents
import RxSwift
import RxCocoa


final class PresenceViewController: UIViewController {
    
    var viewModel: PresenceViewModel
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
        view.backgroundColor = CustomColors.BackGroundColor
        navigationItem.title = viewModel.presenceViewString.navigationItemText
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: viewModel.presenceViewString.leftBarButtonImage), style: .plain, target: self, action: #selector(popToPrevious))
        setupConstraints()
        setTexts()
        setRxFunctions()
        let textAttributes = [NSAttributedString.Key.foregroundColor: CustomColors.BackGroundColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = CustomColors.BackGroundColor
    }
    
    @objc func popToPrevious(){
        viewModel.coordinator.popToPrevius()
    }
    
    func setRxFunctions(){
        nameTextField.rx.text.map { $0 ?? ""}.bind(to: viewModel.nameTextFieldText).disposed(by: viewModel.disposeBag)
        emailTextField.rx.text.map { $0 ?? ""}.bind(to: viewModel.emailTextFieldText).disposed(by: viewModel.disposeBag)
        
        viewModel.validateTextFields().bind(to: submitButton.rx.isUserInteractionEnabled).disposed(by: viewModel.disposeBag)
        viewModel.validateTextFields().map { $0 ? 1 : 0.5}.bind(to: submitButton.rx.alpha).disposed(by: viewModel.disposeBag)
        
        submitButton.rx.tap.bind { [weak self] in
            self?.validateTextFields()
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.pop.btPopupConfirm.rx.tap.bind { [weak self] in
            self?.popPopup()
        }.disposed(by: viewModel.disposeBag)
    }
    
    private let nameTextField: MDCFilledTextField = {
        var tf = MDCFilledTextField()
        tf.tag = 1
        return tf
    }()
    
    private let emailTextField: MDCFilledTextField = {
        var tf = MDCFilledTextField()
        tf.tag = 2
        return tf
    }()
    
    private let submitButton: UIButton = {
        var button = UIButton()
        button.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: CustomFont.MontserratSemiBold, size: 16)
        button.backgroundColor = CustomColors.SecondColor
        button.setTitleColor(CustomColors.BackGroundColor!, for: .normal)
        return button
    }()
    
    func setTexts() {
        submitButton.setTitle(PresenceViewStrings().submitButtonTitle, for: .normal)
        viewModel.components.styleTextFields(textfield: emailTextField, placeHolderText: viewModel.presenceViewString.emailTextFieldPlaceHolder)
        viewModel.components.styleTextFields(textfield: nameTextField, placeHolderText: viewModel.presenceViewString.nameTextFieldPlaceHolder)
    }
    
    private func setupConstraints(){
        
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
    func postPresence(email: String, name: String){
        viewModel.postPresence(email: email, name: name) { [weak self] (error) in
            self?.verifyAPIResponseHaveError(error: error)
        }
    }
    
    func validateTextFields() {
        submitButton.isUserInteractionEnabled = false
        
        
        if emailTextField.text?.isValidEmail == true{
            emailTextField.leadingAssistiveLabel.text = ""
            
            guard let emailText = emailTextField.text, let name = nameTextField.text else {return}
            postPresence(email: emailText, name: name)
            
            
        }else{
            submitButton.isUserInteractionEnabled = true
            emailTextField.leadingAssistiveLabel.text = viewModel.presenceViewString.emailErrorText
            
        }
    }
    
    func verifyAPIResponseHaveError(error: ErrorType?){
        
        if error == nil {
            DispatchQueue.main.async {
                self.view.endEditing(true)
                self.submitButton.isUserInteractionEnabled = true
                self.viewModel.pop.showPopup(popupType: .APISucces)
                self.view.addSubview(self.viewModel.pop)
            }
        }else{
            DispatchQueue.main.async {
                self.view.endEditing(true)
                self.submitButton.isUserInteractionEnabled = true
                self.viewModel.pop.showPopup(popupType: .APIError)
                self.view.addSubview(self.viewModel.pop)
            }
        }
    }
    
    func popPopup(){
        viewModel.pop.removeFromSuperview()
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


