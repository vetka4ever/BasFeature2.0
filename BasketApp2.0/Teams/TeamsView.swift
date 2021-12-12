//
//  TeamsView.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.12.2021.
//

import UIKit
import SnapKit
class TeamsView: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    private var teams = Array(repeating: "TEAM A", count: 5)
    
    private var idCell = "teamCell"
    private var tableOfTeams = UITableView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setView()
        setTableOfTeams()
        self.view.addSubview(tableOfTeams)
        
    }
    
    func setView()
    {
        self.title = "Teams"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "plus"), style: .done, target: self, action: nil)
    }
    
    func setTableOfTeams()
    {
        tableOfTeams = UITableView(frame: self.view.frame, style: .insetGrouped)
        tableOfTeams.dataSource = self
        tableOfTeams.delegate = self
        tableOfTeams.backgroundColor = .white
        tableOfTeams.register(UITableViewCell.self, forCellReuseIdentifier: idCell)
    }
    
    //MARK: SET TABLE OF TEAMS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return teams.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath)
        cell.backgroundColor = UIColor(red: 243/255, green: 51/255, blue: 155/255, alpha: 1)
        cell.textLabel?.attributedText = NSAttributedString(string: teams[indexPath.section], attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return self.view.frame.height / 11
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
