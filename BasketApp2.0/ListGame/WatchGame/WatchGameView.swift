//
//  WatchGameView.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.03.2022.
//

import UIKit
import SnapKit

class WatchGameView: UIViewController
{
    private var modeControl = UISegmentedControl(items: ["All", "Scored", "Shots"])
    private var field = Field()
    private var timeControl = UISegmentedControl(items: ["1", "2", "3", "4", "+"])
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setView()
        setRightBarButtonItem()
        
        for item in [modeControl, field, timeControl]
        {
            self.view.addSubview(item)
        }
        
        setModeControll()
        setField()
        setTimeControll()
        
    }
    
    func setModeControll()
    {
        modeControl.snp.makeConstraints
        {
            make in
            make.topMargin.equalTo(10)
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(self.view.frame.height / 14)
            make.centerX.equalToSuperview()
        }
    }
    
    func setField()
    {
        
        field.snp.makeConstraints
        {
            make in
            make.width.equalToSuperview()
            make.height.equalTo(self.view.frame.width / 2)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(modeControl.snp.bottom).offset(15)
        }
        
        
//        field.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.width / 2)
//        field.center = self.view.center
        
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
//
//        field.changeTitleOfLabels(score: arr)
//        field.turnLabels(on: true)
    }
    
    
    func setTimeControll()
    {
        timeControl.snp.makeConstraints
        {
            make in
            make.topMargin.equalTo(field.snp.bottom).offset(15)
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(self.view.frame.height / 14)
            make.centerX.equalToSuperview()
        }
    }
    
    
    func setView()
    {
        self.view.backgroundColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func setRightBarButtonItem()
    {
        let item = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(setTitles(_:)))
        item.tintColor = UIColor(red: 243/100, green: 63/100, blue: 162/100, alpha: 1)
        self.navigationItem.rightBarButtonItem = item
        self.navigationController?.navigationBar.tintColor = UIColor(red: 243/100, green: 63/100, blue: 162/100, alpha: 1)
        
        
    }
    
    @objc func setTitles(_ sender: UIBarButtonItem)
    {
        let arr = Array.init(repeating: "25/50\n100%", count: 14)
        self.field.turnLabels(on: true)
        self.field.changeTitleOfLabels(score: arr)
    }
    
}
