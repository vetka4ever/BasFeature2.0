//
//  GamesView.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.12.2021.
//

import UIKit

class GamesView: UIViewController, UITableViewDelegate, UITableViewDataSource
{
   
    
    private var games = Array(repeating: "GAME 1", count: 5)
    private var dateOfGames = Array(repeating: "19/11", count: 5)
    
    private var idCell = "gameCell"
    private var tableOfGames = UITableView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setView()
        setTableOfGames()
        self.view.addSubview(tableOfGames)
    }
   
    func setView()
    {
        self.title = "Games"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "plus"), style: .done, target: self, action: nil)
    }
    
    func setTableOfGames()
    {
        tableOfGames = UITableView(frame: self.view.frame, style: .insetGrouped)
        tableOfGames.dataSource = self
        tableOfGames.delegate = self
        tableOfGames.backgroundColor = .white
        tableOfGames.register(CellWithTwoTitles.self, forCellReuseIdentifier: idCell)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! CellWithTwoTitles
        cell.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 218/255, alpha: 1)
        cell.accessToLeftTitle = games[indexPath.section]
        cell.accessToRightTitle = dateOfGames[indexPath.section]
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return self.view.frame.height / 14
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
// 255 147 218 1
