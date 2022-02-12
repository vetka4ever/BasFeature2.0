//
//  ViewController.swift
//  createTeamViewTest
//
//  Created by Daniil on 10.02.2022.
//

import UIKit

class CreateTeamsView: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    private let presenter = CreateTeamsPresenter()
    
    private var heightForFields: CGFloat = 0
    private var widthForFields: CGFloat = 0
    private var sizeForFields: CGSize = CGSize(width: 0, height: 0)
    
    private let fieldOfName = UITextField()
    private let slider = UISlider()
    private var tableOfPlayers = UITableView()
    private let createTeamButton = UIButton()
    
    private var numsOfPlayers: Array<String> = Array.init(repeating: "", count: 5)
    
    private var countOfPlayers = 5
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setView()
        setSizeVariables()
        setFieldOfName()
        setSlider()
        setTableOfPlayer()
        setButton()
        for item in [fieldOfName, slider, tableOfPlayers, createTeamButton]
        {
            self.view.addSubview(item)
        }
        
    }
    
    private func setView()
    {
        presenter.setView(view: self)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.largeTitleDisplayMode = .never
    }
    private func setSizeVariables()
    {
        heightForFields = self.view.frame.height / 14
        widthForFields = self.view.frame.width * 0.9
        sizeForFields = CGSize(width: widthForFields, height: heightForFields)
    }
    
    func setFieldOfName()
    {
        fieldOfName.frame.size = sizeForFields
        fieldOfName.center.x = self.view.center.x
        fieldOfName.frame.origin.y = self.navigationController!.navigationBar.frame.height
        fieldOfName.layer.borderWidth = 1
        
        fieldOfName.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        fieldOfName.placeholder = "Team name"
        
    }
    
    func setSlider()
    {
        slider.frame.size = fieldOfName.frame.size
        slider.center.x = fieldOfName.center.x
        slider.frame.origin.y = fieldOfName.frame.height + fieldOfName.frame.origin.y + 10
        slider.maximumValue = 15
        slider.minimumValue = 5
        slider.value = 5
        slider.addTarget(self, action: #selector(sliderSelector(_:)), for: .valueChanged)
    }
    
    @objc func sliderSelector(_ sender: UISlider)
    {
        sender.value = Float(Int(sender.value))
        if Int(sender.value) > numsOfPlayers.count
        {
            while Int(sender.value) != numsOfPlayers.count
            {
                numsOfPlayers.append("")
            }
            
        }
        else
        {
            
            while Int(sender.value) != numsOfPlayers.count
            {
                numsOfPlayers.removeLast()
            }
        }
        
        self.tableOfPlayers.reloadData()
        self.countOfPlayers = Int(sender.value)
        
        
    }
    
    
    func setTableOfPlayer()
    {
        tableOfPlayers = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .insetGrouped)
        tableOfPlayers.frame.size = CGSize(width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.6)
        tableOfPlayers.center.x = self.view.center.x
        tableOfPlayers.frame.origin.y = slider.frame.height + slider.frame.origin.y + 10
        tableOfPlayers.dataSource = self
        tableOfPlayers.delegate = self
        tableOfPlayers.register(UITableViewCell.self, forCellReuseIdentifier: "idCell")
    }
    
    func alertAboutEmptyNameOfTeam()
    {
        fieldOfName.text = ""
        let alert = UIAlertController(title: "Attention", message: "You didn't write name of team", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideView()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setButton()
    {
        createTeamButton.setTitle("Create team", for: .normal)
        createTeamButton.backgroundColor = .systemBlue
        createTeamButton.frame.size = fieldOfName.frame.size
        createTeamButton.center.x = self.view.center.x
        createTeamButton.frame.origin.y = tableOfPlayers.frame.height + tableOfPlayers.frame.origin.y + 10
        createTeamButton.addTarget(self, action: #selector(createTeam(_:)), for: .touchDown)
    }
    
    @objc func createTeam(_ sender: UIButton)
    {
        var idOfVisibleCell = 0
        var textFieldFromVisibleCell = UITextField()
        for item in tableOfPlayers.visibleCells
        {
            idOfVisibleCell = (tableOfPlayers.indexPath(for: item))!.row
            textFieldFromVisibleCell = tableOfPlayers.cellForRow(at: IndexPath(row: idOfVisibleCell, section: 0))!.contentView.subviews[0] as! UITextField
            numsOfPlayers[idOfVisibleCell] = textFieldFromVisibleCell.text!
        }
        presenter.addTeam(nameOfTeam: fieldOfName.text!, players: &numsOfPlayers)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numsOfPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)
        
        if cell.contentView.subviews.count == 0
        {
            let textField = UITextField()
            textField.frame.size = cell.frame.size
            textField.placeholder = "Enter num of player"
//            textField.text = "\(indexPath.row + 1)"
            textField.keyboardType = .numberPad
            cell.contentView.addSubview(textField)
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let newCell = cell.contentView.subviews[0] as? UITextField
        newCell!.text = numsOfPlayers[indexPath.row]
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let newCell = cell.contentView.subviews[0] as? UITextField
        if indexPath.row < numsOfPlayers.count
        {
        numsOfPlayers[indexPath.row] = newCell!.text!
        }
        
        
    }
    
}

