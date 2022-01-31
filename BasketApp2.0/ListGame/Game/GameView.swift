//
//  Game.swift
//  BasketApp2.0
//
//  Created by Daniil on 16.12.2021.
//

import UIKit
import SnapKit
class GameView: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    private var presenter = GamePresenter()
    
    var height: CGFloat = 0
    var width: CGFloat = 0
    
    private var labelTeamA = UILabel()
    private var labelTeamB = UILabel()
    private var tableTeamA = UITableView(frame: CGRect(), style: .insetGrouped)
    private var tableTeamB = UITableView(frame: CGRect(), style: .insetGrouped)
    
    private var field = Field()
    
    private var idCell = "idForCellInGame"
    
    override var shouldAutorotate: Bool
    {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {

        return .landscape
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
    {

        return .landscapeRight
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        for item in [tableTeamA, tableTeamB, field, labelTeamA, labelTeamB]
        {
            self.view.addSubview(item)
        }
        setSizeVariables()
        setTableViews()
        setField()
    }
    
    
    @objc func paintZone(_ sender: UITapGestureRecognizer)
    {
        field.paintZoneByTap(point: sender.location(in: field))
    }
    func setSizeVariables()
    {
        height = self.view.frame.height
        width = self.view.frame.width
        
        if height > width
        {
            let a = height
            height = width
            width = a
        }
        
    }
    func setTableViews()
    {
       
        for item in [tableTeamA, tableTeamB]
        {
            item.register(UITableViewCell.self, forCellReuseIdentifier: idCell)
            item.backgroundColor = .white
            item.delegate = self
            item.dataSource = self
            item.showsHorizontalScrollIndicator = false
            item.showsVerticalScrollIndicator = false
            item.sectionHeaderHeight = 0
            item.sectionFooterHeight = 10
            item.snp.makeConstraints
            { maker in
                maker.width.equalTo(width / 7.9)
                maker.height.equalTo(height * 0.95)
                maker.bottomMargin.equalTo(0)
                item == tableTeamA ? (maker.leftMargin.equalTo(0)) : (maker.rightMargin.equalTo(0))
            }
        }
        
        for item in [labelTeamA, labelTeamB]
        {
            item.numberOfLines = 1
            item.textColor = .black
            item.text = ( item == labelTeamA ? (presenter.getNameOfTeam(teamA: true)) : (presenter.getNameOfTeam(teamA: false)))
            item.snp.makeConstraints
            { maker in
                maker.height.equalTo(height * 0.1)
                item == labelTeamA ? (maker.leftMargin.equalTo(0)) : (maker.rightMargin.equalTo(0))
            }
        }
    }
    
    func setField()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(paintZone(_:)))
        field.addGestureRecognizer(tap)
        field.frame.size = CGSize(width: width * 6 / 8, height: width * 6 / 16)
        print(field.frame.width / field.frame.height) 
        field.center = CGPoint(x: width / 2, y: height / 2)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return (tableView == tableTeamA ? (presenter.getCountOfPlayers(teamA: true)) : (presenter.getCountOfPlayers(teamA: false)) )
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath)
        cell.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
        cell.textLabel!.text = (tableView == tableTeamA ? (presenter.getNumOfPlayer(teamA: true, id: indexPath.section)) : (presenter.getNumOfPlayer(teamA: false, id: indexPath.section)) )
        cell.textLabel!.textAlignment = .center
        cell.layer.cornerRadius = 10
        return cell
    }
  
}



