//
//  ViewController.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.12.2021.
//

import UIKit
import SnapKit
class ProfileView: UIViewController
{
    private var image = UIImageView()
    private var surnameLabel = UILabel()
    private var nameLabel = UILabel()
    
    private var heightForFields: CGFloat = 0
    private var widthForFields: CGFloat = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        for item in [image, surnameLabel, nameLabel]
        {
            self.view.addSubview(item)
            
        }
        setSizeVariables()
        setViews()
        setLabels()
    }
    
    func setSizeVariables()
    {
        heightForFields = self.view.frame.height / 14
        widthForFields = self.view.frame.width * 0.9
    }
    
    func setViews()
    {
        self.view.backgroundColor = .white
        self.title = "Profile"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let imageForRightBarButtonItem = UIImage(systemName: "pencil")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: imageForRightBarButtonItem, style: .done, target: self, action: nil)
        
        image.backgroundColor = .red
        image.layer.cornerRadius = 10
        image.snp.makeConstraints
        { maker in
            maker.width.equalToSuperview()
            maker.height.equalTo(self.view.frame.height * 0.3)
            maker.centerX.equalToSuperview()
            maker.topMargin.equalTo(10)
        }
        for (key, value)  in [4.9: surnameLabel, 6.2: nameLabel]
        {
            
            value.snp.makeConstraints
            { maker in
                maker.height.equalTo(heightForFields)
                maker.width.equalTo(widthForFields)
                maker.centerX.equalToSuperview()
                maker.topMargin.equalTo(CGFloat(key) * heightForFields)
            }
        }
    }
    
    func setLabels()
    {
        for item in [surnameLabel, nameLabel]
        {
            item.layer.borderWidth = 1
            item.layer.borderColor = UIColor.black.cgColor
            item.layer.cornerRadius = 10
//            item == surnameLabel ? (NSAttributedString(string: "Surname", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])) : (NSAttributedString(string: "Surname", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]))
//            item.attributedText = (item == surnameLabel ? (NSAttributedString(string: "Surname", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])) : (NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])) )
            item.text = (item == surnameLabel ? ("Surname") : ("Name") )
           
        }
    }
    
}
