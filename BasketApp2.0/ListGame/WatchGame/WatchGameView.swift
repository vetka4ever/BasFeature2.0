//
//  WatchGameView.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.03.2022.
//

import UIKit
import SnapKit

class WatchGameView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    
    
    private var modeControl = UISegmentedControl(items: ["All", "Scored", "Shots"])
    private var field = Field()
    private var timeControl = UISegmentedControl(items: ["1", "2", "3", "4", "+"])
    private var teamAButton = UIButton(type: .system)
    private var teamACollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private var teamBButton = UIButton(type: .system)
    private var teamBCollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setView()
        setRightBarButtonItem()
        
        for item in [modeControl, field, timeControl, teamAButton, teamACollection, teamBButton, teamBCollection]
        {
            self.view.addSubview(item)
        }
        
        
        setTimeControll()
        setField()
        setModeControll()
        setTeamsButton()
        setCollectionsOfTeams()
        setLayoutsOfViewOfTeams()
        
    }
    
    func setTimeControll()
    {
        timeControl.snp.makeConstraints
        {
            make in

            make.width.equalTo(self.view.frame.width / 1.5)
            make.height.equalTo(self.view.frame.height / 18)
            make.topMargin.equalTo(10)
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
            make.topMargin.equalTo(timeControl.snp.bottom).offset(15)
        }
        
    }
    
    func setModeControll()
    {
        
        
        modeControl.snp.makeConstraints
        {
            make in
            make.topMargin.equalTo(field.snp.bottom).offset(15)
            make.width.equalTo(self.view.frame.width/2)
            make.height.equalTo(self.view.frame.height / 18)
            make.centerX.equalToSuperview()
            
        }
    }
    
    
    func setTeamsButton()
    {
        for item in [teamAButton,teamBButton]
        {
            item.setTitle("TeamA", for: .normal)
            item == teamAButton ? (item.setTitle("TeamA", for: .normal)) : (item.setTitle("TeamB", for: .normal))
            item.backgroundColor = UIColor(red: 255/255, green: 197/255, blue: 242/255, alpha: 1)
            item.layer.cornerRadius = 14
            item.tintColor = .black
            
            item.snp.makeConstraints
            {
                make in
                make.width.equalTo(self.view.frame.width / 2)
                make.height.equalTo(self.view.frame.height / 14)
                make.left.equalToSuperview().offset(20)
                
            }
        }
    }
    
    
    
    func setCollectionsOfTeams()
    {
        
        for item in [teamACollection, teamBCollection]
        {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            item.collectionViewLayout = layout
            
            
            item.showsHorizontalScrollIndicator = false
            item.delegate = self
            item.dataSource = self
            item.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "idCell")
            
            
            
            item.snp.makeConstraints
            {
                make in
                make.width.equalToSuperview()
                make.left.equalTo(10)
                make.height.equalTo(self.view.frame.height / 12)
            }
        }
    }
    
    func setLayoutsOfViewOfTeams()
    {
        
        let arr = [modeControl, teamAButton, teamACollection, teamBButton, teamBCollection]
        
        for i in 1...arr.count-1
        {
            arr[i].snp.makeConstraints
            {
                make in
                make.topMargin.equalTo(arr[i-1].snp.bottom).offset(15)
            }
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
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
        item.tintColor = UIColor(red: 243/255, green: 63/255, blue: 162/255, alpha: 1)
        self.navigationItem.rightBarButtonItem = item
        self.navigationController?.navigationBar.tintColor = UIColor(red: 243/255, green: 63/255, blue: 162/255, alpha: 1)
        
        
    }
    
    @objc func setTitles(_ sender: UIBarButtonItem)
    {
        let arr = Array.init(repeating: "25/50\n100%", count: 14)
        self.field.turnLabels(on: true)
        self.field.changeTitleOfLabels(score: arr)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath)
        cell.backgroundColor = UIColor(red: 243/255, green: 63/255, blue: 162/255, alpha: 1)
        cell.layer.cornerRadius = cell.frame.height / 2
        return cell
    }
    
    
}
