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
    private var presenter = WatchGamePresenter()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setView()
        setRightBarButtonItem()
        presenter.setView(view: self)
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
    
    private func setTimeControll()
    {
        timeControl.snp.makeConstraints
        {
            make in

            make.width.equalTo(self.view.frame.width / 1.5)
            make.height.equalTo(self.view.frame.height / 18)
            make.topMargin.equalTo(10)
            make.centerX.equalToSuperview()
            
        }
        
        timeControl.addTarget(self, action: #selector(changeTime(_:)), for: .valueChanged)
    }
    
    @objc func changeTime(_ sender: UISegmentedControl)
    {
        presenter.setTime(time: sender.selectedSegmentIndex + 1)
    }
    
    private func setField()
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
    
    private func setModeControll()
    {
        
        
        modeControl.snp.makeConstraints
        {
            make in
            make.topMargin.equalTo(field.snp.bottom).offset(15)
            make.width.equalTo(self.view.frame.width/2)
            make.height.equalTo(self.view.frame.height / 18)
            make.centerX.equalToSuperview()
            
        }
        modeControl.addTarget(self, action: #selector(changeMode(_:)), for: .valueChanged)
    }
    
    @objc func changeMode(_ sender: UISegmentedControl)
    {
        let index = sender.selectedSegmentIndex
        let title = sender.titleForSegment(at: index)
        presenter.setMode(mode: title!)
    }
    
    
    private func setTeamsButton()
    {
        var title = ""
        for item in [teamAButton,teamBButton]
        {
            title = presenter.getNameOfTeam(teamA: item == teamAButton)
//            item == teamAButton ? (item.setTitle("TeamA", for: .normal)) : (item.setTitle("TeamB", for: .normal))
            item.setTitle(title, for: .normal)
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
            item.addTarget(self, action: #selector(setPlayer(_:)), for: .touchDown)
        }
    }
    
    @objc func setPlayer(_ sender: UIButton)
    {
        presenter.setPlayer(teamA: sender == teamAButton, player: "")
    }
    
    
    private func setCollectionsOfTeams()
    {
        
        for item in [teamACollection, teamBCollection]
        {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            item.collectionViewLayout = layout
            
            
            item.showsHorizontalScrollIndicator = false
            item.delegate = self
            item.dataSource = self
            item.register(NumOfPlayerCell.self, forCellWithReuseIdentifier: "idCell")
            
            
            
            item.snp.makeConstraints
            {
                make in
                make.width.equalToSuperview()
                make.left.equalTo(10)
                make.height.equalTo(self.view.frame.height / 11)
            }
        }
    }
    
    private func setLayoutsOfViewOfTeams()
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
    
    private func setView()
    {
        self.view.backgroundColor = .white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setRightBarButtonItem()
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
    
    
    
     func setTitlesOfScores(titles: [String])
    {
        field.turnLabels(on: true)
        field.changeTitleOfLabels(score: titles)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        presenter.getCountOfPlayersInTeam(teamA: collectionView == teamACollection)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! NumOfPlayerCell
        cell.backgroundColor = UIColor(red: 243/255, green: 63/255, blue: 162/255, alpha: 1)
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.setLabelView(name: presenter.getNumOfPlayer(teamA: collectionView == teamACollection, id: indexPath.row))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as! NumOfPlayerCell
        let player = cell.accessToNumOfPlayer
        presenter.setPlayer(teamA: collectionView == teamACollection, player: player)
    }
    
    
}
