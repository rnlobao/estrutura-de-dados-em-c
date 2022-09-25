//
//  Register2ViewController.swift
//  carteirada-front-end
//
//  Created by Robson Novato Lobao on 22/09/22.
//

import UIKit

protocol ServiceDelegate {
    func dataSucess()
    func dataFail(error: Error)
    func showLoad()
    func removeLoad()
}

class Register2ViewController: UIViewController {

    @IBOutlet weak var registerButtonEdit: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var confirmPWTF: UITextField!
    @IBOutlet weak var alreadyHasAccountEdit: UIButton!
    @IBOutlet weak var errorEmailLabel: UILabel!
    
    @IBAction func AlreadyHasAccount(_ sender: Any) {
        let myViewController = LoginViewController()
        myViewController.modalPresentationStyle = .fullScreen
        self.present(myViewController, animated: false, completion: nil)
    }
    
    private var viewModel: Register2ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = Register2ViewModel(delegate: self)
        setupButton()
        setupPWTextFields()
        setupToolBar()
        errorEmailLabel.isHidden = true
        registerButtonEdit.isEnabled = true
    }
    
    private func setupPWTextFields() {
        pwTF.isSecureTextEntry = true
        confirmPWTF.isSecureTextEntry = true
    }
    
    @IBAction func sendUser(_ sender: Any) {
        viewModel.postDataUser(login: userTF.text ?? "", email: emailTF.text ?? "", password: pwTF.text ?? "")
    }
    
    func setupButton() {
        registerButtonEdit.layer.cornerRadius = 20
        registerButtonEdit.layer.shadowColor = UIColor.black.cgColor
        registerButtonEdit.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        registerButtonEdit.layer.shadowRadius = 4.0
        registerButtonEdit.layer.shadowOpacity = 0.5
        registerButtonEdit.layer.masksToBounds = false
    }
    
    func setupToolBar() {
        setupToolBarPW()
        setupToolBarUser()
        setupToolBarEmail()
        setupToolBarConfirmPW()
    }
    
    private func setupToolBarEmail() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let closeButtonItemEmail = UIBarButtonItem(title: "fechar", style: .done, target: self, action: #selector(closeKeyboardEmail))
        let nextButtonItemEmail = UIBarButtonItem(title: "próximo", style: .done, target: self, action: #selector(nextTextFieldEmail))
        keyboardToolbar.items = [flexBarButton, closeButtonItemEmail, nextButtonItemEmail]
        emailTF.inputAccessoryView = keyboardToolbar
    }
    
    private func setupToolBarUser() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let closeButtonItemUser = UIBarButtonItem(title: "fechar", style: .done, target: self, action: #selector(closeKeyboardUser))
        let nextButtonItemUser = UIBarButtonItem(title: "próximo", style: .done, target: self, action: #selector(nextTextFieldUser))
        keyboardToolbar.items = [flexBarButton, closeButtonItemUser, nextButtonItemUser]
        userTF.inputAccessoryView = keyboardToolbar
    }
    
    private func setupToolBarPW() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let closeButtonItemPW = UIBarButtonItem(title: "fechar", style: .done, target: self, action: #selector(closeKeyboardPW))
        let nextButtonItemPW = UIBarButtonItem(title: "próximo", style: .done, target: self, action: #selector(nextTextFieldPW))
        keyboardToolbar.items = [flexBarButton, closeButtonItemPW, nextButtonItemPW]
        pwTF.inputAccessoryView = keyboardToolbar
    }
    
    private func setupToolBarConfirmPW() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
       
        
        let closeButtonItemconfirmPW = UIBarButtonItem(title: "fechar", style: .done, target: self, action: #selector(closeKeyboardConfirmPW))
        keyboardToolbar.items = [flexBarButton, closeButtonItemconfirmPW]
        confirmPWTF.inputAccessoryView = keyboardToolbar
    }
    
    
    @objc func closeKeyboardEmail() {
        emailTF.endEditing(true)
    }
    
    @objc func closeKeyboardUser() {
        userTF.endEditing(true)
    }
    
    @objc func closeKeyboardPW() {
        pwTF.endEditing(true)
    }
    
    @objc func closeKeyboardConfirmPW() {
        confirmPWTF.endEditing(true)
    }
    
    @objc func nextTextFieldEmail() {
        emailTF.resignFirstResponder()
        userTF.becomeFirstResponder()
    }
    
    @objc func nextTextFieldUser() {
        userTF.resignFirstResponder()
        pwTF.becomeFirstResponder()
    }
    
    @objc func nextTextFieldPW() {
        pwTF.resignFirstResponder()
        confirmPWTF.becomeFirstResponder()
    }
    
    
}

extension Register2ViewController: ServiceDelegate {
    func dataSucess() {
        let alert = UIAlertController(title: "Sucesso", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continuar", style: .destructive, handler: {(action:UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
        UserDefaults.standard.set(true, forKey: "logado")
        UserDefaults.standard.set(emailTF.text, forKey: "email")
        UserDefaults.standard.set(userTF.text, forKey: "usuario")
    }
        
    func dataFail(error: Error) {
        let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        self.present(alert, animated: true)
    }
        
    func showLoad() {
        showSpinner(onView: view)
    }
        
    func removeLoad() {
        removeSpinner()
    }
}
