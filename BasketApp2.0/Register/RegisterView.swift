//
//  RegisterView.swift
//  BasketApp2.0
//
//  Created by Daniil on 02.12.2021.
//
import UIKit
import SnapKit

class RegisterView: UIViewController
{
    private var heightForFields: CGFloat = 0
    private var widthForFields: CGFloat = 0
    
    private var surnameTextField = UITextField()
    private var nameTextField = UITextField()
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    private var registerButton = UIButton(type: .system)
    
    private var titles = ["Surname", "Name", "E-mail", "Password"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setView()
        setSizeVariables()
        
        for item in [surnameTextField, nameTextField, emailTextField, passwordTextField, registerButton]
        {
            self.view.addSubview(item)
        }
        
        setPositionOfViews(ratioAndView: [1:surnameTextField, 2.3:nameTextField, 3.6:emailTextField, 4.9:passwordTextField, 7: registerButton])
        setTextFields(textFields: [surnameTextField, nameTextField, emailTextField, passwordTextField])
        setRegisterButton()
    }
    
    
    func setView()
    {
        self.title = "Registration"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
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
    
    func setTextFields(textFields: [UITextField])
    {
        for i in 0...3
        {
            textFields[i].layer.borderWidth = 1
            textFields[i].layer.borderColor = UIColor.black.cgColor
//            textFields[i].attributedText = (NSAttributedString(string: titles[i], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]))
//            textFields[i].attributedPlaceholder = (NSAttributedString(string: titles[i], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]))
            textFields[i].placeholder = titles[i]
        }
    }
    
    func setRegisterButton()
    {
        registerButton.backgroundColor = UIColor(red: 253/255, green: 121/255, blue: 192/255, alpha: 1)
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.attributedText = NSAttributedString(string: "Register", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        registerButton.setTitleColor(.black, for: .normal)
    }
    
    
    func setSizeVariables()
    {
        heightForFields = self.view.frame.height / 14
        widthForFields = self.view.frame.width * 0.9
    }
    
}
