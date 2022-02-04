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
    
    private var height: CGFloat = 0
    private var width: CGFloat = 0
    
    private var field = Field()
    private var idCell = "idForCellInGame"
    private var time = UISegmentedControl.init(items: ["1", "2", "3", "4", "+"])
    private let controlOfModeOfPresenting = UISegmentedControl.init(items: ["input", "all", "scored", "shot", "end"])
    private var labelTeamA = UIButton(type: .system)
    private var labelTeamB = UIButton(type: .system)
    private var tableTeamA = UITableView(frame: CGRect(), style: .insetGrouped)
    private var tableTeamB = UITableView(frame: CGRect(), style: .insetGrouped)
    
    
    //MARK: SET ORIENTATION
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
        self.height = min(self.view.frame.height, self.view.frame.width)
        self.width = max(self.view.frame.height, self.view.frame.width)
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        for item in [tableTeamA, tableTeamB, field, labelTeamA, labelTeamB, time, controlOfModeOfPresenting]
        {
            self.view.addSubview(item)
        }
        presenter.setView(view: self)
        setField()
        setSegmentedControlls()
        setTableViews()
        
    }
    
    //MARK: FUNCS FOR PRESENTER
    
    /// reloadTableView - func for changing color of cell to default
    /// Using when user tap on selected player
    /// - Parameter teamA: Which team has this player
    func reloadTableView(teamA: Bool)
    {
        for item in (teamA ? (tableTeamA):(tableTeamB)).visibleCells
        {
            item.contentView.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
        }
    }
    
    /// changeVisibleOfField - func for turn on/off labels of zones and repoint field in default colors
    /// - Parameter turnOn: turn on/or visible of field and its labels
    func changeVisibleElementsOfField(turnOn: Bool)
    {
        field.paintZoneByTap(point: CGPoint(x: -1, y: -1))
        field.isUserInteractionEnabled = !turnOn
        field.turnLabels(on: turnOn)
    }
    
    func changeTitleOfLabelOfField(titles: [String])
    {
        field.changeTitleOfLabels(score: titles)
    }
    
    func changeEnableForTeamButtons(turnOn: Bool)
    {
        for item in [labelTeamA, labelTeamB]
        {
            item.isEnabled = turnOn
            item.backgroundColor = (turnOn ? (UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)) : (.white))
        }
        
    }
    //MARK: SETTING VIEWS FUNCS
    private func setTableViews()
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
            item.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
            item.frame.size = CGSize(width: field.frame.origin.x, height: field.frame.height)
            
            item.center = (item == tableTeamA) ? (CGPoint(x: field.frame.origin.x / 2, y: field.center.y)) : (CGPoint(x: self.width - (field.frame.origin.x / 2), y: field.center.y))

        }
        
        for item in [labelTeamA, labelTeamB]
        {
            item.setTitle(presenter.getNameOfTeam(teamA: item == labelTeamA), for: .normal)
            item.setTitleColor(.black, for: .normal)
            item.backgroundColor = .white
            item.layer.cornerRadius = 10
            item.frame.size = CGSize(width: time.frame.origin.x * 0.9, height: tableTeamA.frame.origin.y * 0.9)
            item.center = item == labelTeamA ? (CGPoint(x: time.frame.origin.x/2, y: tableTeamA.frame.origin.y/2)) : (CGPoint(x: self.width - time.frame.origin.x/2, y: tableTeamA.frame.origin.y/2))
            item.addTarget(self, action: #selector(selectTeam(_:)), for: .touchDown)
            item.isEnabled = false
        }
    }
    
    private func setField()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(paintZone(_:)))
        field.addGestureRecognizer(tap)
        field.frame.size = CGSize(width: width * 6 / 8, height: width * 6 / 16)
//        print(field.frame.width / field.frame.height)
        field.center = CGPoint(x: width / 2, y: height / 2)
        
    }
    
    private func setSegmentedControlls()
    {
        time.frame.size = CGSize(width: field.frame.width / 1.8, height: field.frame.minY)
        time.center = CGPoint(x: self.width/2, y: time.frame.height / 2)
        time.selectedSegmentIndex = 0
        time.addTarget(self, action: #selector(changeTime(_:)), for: .valueChanged)
        
        controlOfModeOfPresenting.frame.size = time.frame.size
        controlOfModeOfPresenting.center = CGPoint(x: self.width/2, y: self.height - time.frame.height / 2 )
        
        controlOfModeOfPresenting.selectedSegmentIndex = 0
        controlOfModeOfPresenting.addTarget(self, action: #selector(changeMode(_:)), for: .valueChanged)
    }
    
    //MARK: OBJC FUNCS
    @objc func selectTeam(_ sender: UIButton)
    {
        presenter.setPlayer(teamA: sender == labelTeamA, player: "")
        if sender == labelTeamA
        {
            labelTeamA.backgroundColor = .red
            labelTeamB.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
        }
        else
        {
            labelTeamB.backgroundColor = .red
            labelTeamA.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
        }
        if let team = presenter.getSelectedTeam()
        {
            reloadTableView(teamA: team)
        }
        
            
    }
    
    @objc func paintZone(_ sender: UITapGestureRecognizer)
    {
        field.paintZoneByTap(point: sender.location(in: field))
        presenter.setNumOfZone(zone: field.getNumOfPaintedZone())
    }
    
    @objc func changeTime(_ sender: UISegmentedControl)
    {
        presenter.setTime(time: sender.selectedSegmentIndex + 1)
    }
    
    @objc func changeMode(_ sender: UISegmentedControl)
    {
        presenter.setMode(mode: sender.selectedSegmentIndex)
    }
    

    //MARK: SETTING TABLE VIEWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return presenter.getCountOfPlayers(teamA: tableView == tableTeamA )
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath)
        cell.contentView.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
        cell.textLabel!.text = presenter.getNumOfPlayer(teamA: tableView == tableTeamA, id: indexPath.section)
        cell.textLabel!.textAlignment = .center
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        reloadTableView(teamA: tableView != tableTeamA)
        if presenter.getCurrentMode() != .input
        {
        labelTeamA.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
        labelTeamB.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
        }
        tableView.cellForRow(at: indexPath)!.contentView.backgroundColor = .red
        presenter.setPlayer(teamA: (tableView == tableTeamA), player: tableView.cellForRow(at: indexPath)!.textLabel!.text!)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        
        tableView.cellForRow(at: indexPath)!.contentView.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        (tableView.frame.height/5 - tableView.sectionFooterHeight)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return view
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0
//    }
}



