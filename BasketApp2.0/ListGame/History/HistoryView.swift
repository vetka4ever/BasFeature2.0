//
//  HistoryView.swift
//  BasketApp2.0
//
//  Created by Daniil on 14.02.2022.
//

import UIKit

class HistoryView: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    private var selectTeamControl = UISegmentedControl()
    private var tableOfShots = UITableView(frame: CGRect(), style: .insetGrouped)
    private var presenter = HistoryPresenter()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray5
        
        setSegmentControl()
        setTableOfShots()
        
        for item in [selectTeamControl, tableOfShots]
        {
            self.view.addSubview(item)
        }
        
        
        
        
    }
    
    func setSegmentControl()
    {
        let names = presenter.getNamesOfTeam()
        selectTeamControl = UISegmentedControl(items: names )
        selectTeamControl.selectedSegmentIndex = 0
        selectTeamControl.backgroundColor = .green
        selectTeamControl.frame.size = CGSize(width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.1)
        selectTeamControl.center = CGPoint(x: self.view.center.x, y: selectTeamControl.frame.height / 2
        )
//        selectTeamControl.frame.origin = CGPoint(x: 10, y: 10)
        
        
        selectTeamControl.addTarget(self, action: #selector(changeSelectedTeam(_:)), for: .valueChanged)
    }
    
    @objc func changeSelectedTeam(_ sender: UISegmentedControl)
    {
        tableOfShots.reloadData()
    }
    
    
    func setTableOfShots()
    {
        tableOfShots.register(CellToHistory.self, forCellReuseIdentifier: "idCell")
        tableOfShots.delegate = self
        tableOfShots.dataSource = self
        let frameForTable = CGRect(x: 0, y: selectTeamControl.frame.height + (selectTeamControl.frame.origin.y * 2) , width: self.view.frame.width, height: self.view.frame.height)
        tableOfShots.frame = frameForTable
        
        tableOfShots.backgroundColor = .systemRed
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let selectedIndex = selectTeamControl.selectedSegmentIndex
        let selectedTeam = selectTeamControl.titleForSegment(at: selectedIndex)!
        let count = presenter.getCountOfAttacksByTeam(nameOfTeam: selectedTeam)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as! CellToHistory
        cell.backgroundColor = .green
        
        return cell
    }
   
    
}
