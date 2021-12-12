//
//  ViewController.swift
//  BasketApp2.0
//
//  Created by Daniil on 01.12.2021.
//

import UIKit
import SnapKit
class SignView: UIViewController {
    
    private var presenter = SignPresenter()
    
    private var emailField = UITextField()
    private var passwordField = UITextField()
    
    private var heightForFields: CGFloat = 0
    private var widthForFields: CGFloat = 0
    
    private var logInButton = UIButton(type: .system)
    private var forgotPasswordButton = UIButton(type: .system)
    private var dontHaveAccountButton = UIButton(type: .system)
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setSizeVariables()
        setView()
        
        for item in [emailField, passwordField, forgotPasswordButton, logInButton, dontHaveAccountButton]
        {
            self.view.addSubview(item)
        }

        setPositionOfViews(ratioAndView: [3:emailField, 4.3:passwordField, 6:logInButton, 6.7: forgotPasswordButton, 8.3: dontHaveAccountButton])
        setTextFields(fields: [emailField, passwordField])
        setLoginButton()
        setForgottenPasswordButton()
        setDontHaveAccountdButton()
    }
    
    func setSizeVariables()
    {
        heightForFields = self.view.frame.height / 10
        widthForFields = self.view.frame.width * 0.9
    }
    
    func setView()
    {
        self.title = "Login"
        self.navigationItem.titleView?.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
    }
    
    func setPositionOfViews(ratioAndView: [Double:UIView])
    {
        for (key, value) in ratioAndView
        {
            value.layer.cornerRadius = 14
            value.snp.makeConstraints
            {
                maker in
                maker.width.equalTo(widthForFields)
                maker.height.equalTo(heightForFields)
                maker.centerX.equalToSuperview()
                maker.topMargin.equalTo(key * heightForFields)
            }
        }
    }
    
    func setTextFields(fields: [UITextField])
    {
        for item in fields
        {
            item.layer.borderWidth = 1
            
            item.layer.borderColor = UIColor.black.cgColor
            item.attributedPlaceholder = ((item == emailField) ?  (NSAttributedString(string: "E-mail", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])):  (NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])))
//            item.bounds.size = CGSize(width: item.frame.width * 0.9, height: item.frame.height)
            
            
        }
    }
    
    func setLoginButton()
    {
        logInButton.backgroundColor = UIColor(red: 253/255, green: 121/255, blue: 192/255, alpha: 1)
        logInButton.setTitle("Login", for: .normal)
        logInButton.titleLabel?.attributedText = NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        logInButton.setTitleColor(.black, for: .normal)
        logInButton.addTarget(self, action: #selector(signIn(_:)), for: .touchDown)
    }
    @objc func signIn(_ sender: UIButton)
    {
        
        let controller = presenter.getTabBarController()
//        let controller = ProfileView()
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
        
    }
    
    func setForgottenPasswordButton()
    {
        forgotPasswordButton.setTitle("Forgotten your password?", for: .normal)
        forgotPasswordButton.titleLabel?.textAlignment = .center
        forgotPasswordButton.setTitleColor(.black, for: .normal)
    }
    
    func setDontHaveAccountdButton()
    {
        dontHaveAccountButton.setTitle("Don't have an account? Register", for: .normal)
        dontHaveAccountButton.titleLabel?.textAlignment = .center
        dontHaveAccountButton.setTitleColor(.black, for: .normal)
        dontHaveAccountButton.addTarget(self, action: #selector(goToRegisterView(_:)), for: .touchDown)
    }
    
    @objc func goToRegisterView(_ sender: UIButton)
    {
        let view = presenter.getRegisterView()
//        self.present(view, animated: true, completion: nil)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
}


