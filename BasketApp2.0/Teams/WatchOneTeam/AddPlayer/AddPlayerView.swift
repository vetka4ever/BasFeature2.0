//
//  AddPlayerView.swift
//  BasketApp2.0
//
//  Created by Daniil on 13.12.2021.
//

import UIKit
import SnapKit
class AddPlayerView: UIViewController
{
    private var presenter = AddPlayerPresenter()
    
    private var heightForFields: CGFloat = 0
    private var widthForFields: CGFloat = 0
    
    private var nameTextField = UITextField()
    private var numberTextField = UITextField()
    private var dateOfBirthTextField = UITextField()
    private var heightTextField = UITextField()
    private var weightTextField = UITextField()
    private var saveButton = UIButton(type: .system)
    
    private let titles = ["Name", "Number", "Date of birth", "Height", "Weight"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        presenter.setView(view: self)
        for item in [nameTextField, numberTextField, dateOfBirthTextField, heightTextField, weightTextField, saveButton]
        {
            self.view.addSubview(item)
        }
        
        setView()
        setSizeVariables()
        setPositionOfViews(ratioAndView: [1:nameTextField, 2.3:numberTextField, 3.6:dateOfBirthTextField, 4.9:heightTextField, 6.2: weightTextField, 8.3: saveButton])
        setTextFields(textFields: [nameTextField, numberTextField, dateOfBirthTextField, heightTextField, weightTextField])
        setSaveButton()
    }

    private func setView()
    {
        self.title = "Create player"
        self.navigationItem.titleView?.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
    }
    
    private func setSizeVariables()
    {
        heightForFields = self.view.frame.height / 14
        widthForFields = self.view.frame.width * 0.9
    }
    
    private func setPositionOfViews(ratioAndView: [Double:UIView])
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

    private func setTextFields(textFields: [UITextField])
    {
        
        for i in 0...textFields.count - 1
        {
            textFields[i].layer.borderWidth = 1
            textFields[i].layer.borderColor = UIColor.black.cgColor


            textFields[i].placeholder = titles[i]
        }
    }
    
    private func setSaveButton()
    {
        saveButton.backgroundColor = UIColor(red: 253/255, green: 121/255, blue: 192/255, alpha: 1)
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.attributedText = NSAttributedString(string: "Save", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.addTarget(self, action: #selector(addPlayerInTeam(_:)), for: .touchDown)
    }
    @objc func addPlayerInTeam(_ sender: UIButton)
    {
        let player = (name: nameTextField.text!, number: numberTextField.text!, dateOfBirth: dateOfBirthTextField.text!, height: heightTextField.text!, weight: weightTextField.text!)
        presenter.addPlayer(player: player)
    }
    
    func popView()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
