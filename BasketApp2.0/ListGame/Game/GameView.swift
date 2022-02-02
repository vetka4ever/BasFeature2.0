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
    
    //    private let valuesForTime = ["1", "2", "3", "4", "+"]
    //    private let valuesForModeOfPresenting = ["all", "scored", "will", "end"]
    
    private var time = UISegmentedControl.init(items: ["1", "2", "3", "4", "+"])
    private let controlOfModeOfPresenting = UISegmentedControl.init(items: ["input", "all", "scored", "shot", "end"])
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
        self.height = min(self.view.frame.height, self.view.frame.width)
        self.width = max(self.view.frame.height, self.view.frame.width)
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        for item in [tableTeamA, tableTeamB, field, labelTeamA, labelTeamB, time, controlOfModeOfPresenting]
        {
            self.view.addSubview(item)
        }
        presenter.setView(view: self)
        setTableViews()
        setField()
        setSegmentedControlls()
    }
    
    func reloadTableView(teamA: Bool)
    {
        (teamA) ? (tableTeamA.reloadData()) : (tableTeamB.reloadData())
    }
    /// changeVisibleOfField - func for turn on/off labels of zones and repoint field in default colors
    func changeVisibleElementsOfField(turnOn: Bool)
    {
        field.paintZoneByTap(point: CGPoint(x: -1, y: -1))
        field.isUserInteractionEnabled = !turnOn
        field.turnLabels(on: turnOn)
    }
    
    @objc func paintZone(_ sender: UITapGestureRecognizer)
    {
         field.paintZoneByTap(point: sender.location(in: field))
        presenter.setNumOfZone(zone: field.getNumOfPaintedZone())
        
        
    }
    
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
    
    private func setField()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(paintZone(_:)))
        field.addGestureRecognizer(tap)
        field.frame.size = CGSize(width: width * 6 / 8, height: width * 6 / 16)
        print(field.frame.width / field.frame.height)
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
    
    @objc func changeTime(_ sender: UISegmentedControl)
    {
        presenter.setTime(time: sender.selectedSegmentIndex + 1)
    }
    
    @objc func changeMode(_ sender: UISegmentedControl)
    {
        presenter.setMode(mode: sender.selectedSegmentIndex)
    }
    
//    func askResultOfThrow(result: @escaping (Bool) -> ())
//    {
//        var status = false
//        let alert = UIAlertController(title: "Input", message: "Enter result of shot", preferredStyle: .alert)
//        let win = UIAlertAction(title: "Win", style: .default) { UIAlertAction in
//            status = true
//        }
//        
//        let no = UIAlertAction(title: "Lose", style: .cancel, handler: nil)
//        alert.addAction(win)
//        alert.addAction(no)
//        present(alert, animated: true, completion: nil)
//        
//        result(status)
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        //        return (tableView == tableTeamA ? (presenter.getCountOfPlayers(teamA: true)) : (presenter.getCountOfPlayers(teamA: false)) )
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
        if tableView == tableTeamA
        {
            tableTeamB.reloadData()
        }
        else
        {
            tableTeamA.reloadData()
        }
//        tableView.cellForRow(at: indexPath)!.selectedBackgroundView?.backgroundColor = .red
//        tableView.cellForRow(at: indexPath)!.backgroundColor = .red
        tableView.cellForRow(at: indexPath)!.contentView.backgroundColor = .red
        presenter.setPlayer(teamA: (tableView == tableTeamA), player: tableView.cellForRow(at: indexPath)!.textLabel!.text!)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        
        tableView.cellForRow(at: indexPath)!.contentView.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
    }
    
}



