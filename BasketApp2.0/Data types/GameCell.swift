//
//  GameCell.swift
//  BasketApp2.0
//
//  Created by Daniil on 03.12.2021.
//

import UIKit
import SnapKit
class GameCell: UITableViewCell
{
    private var titleOfGame = UILabel()
    private var dateOfGame = UILabel()
    
    override func layoutSubviews()
    {
        setLabels()
        
    }
    private func setLabels()
    {
        self.contentView.addSubview(titleOfGame)
        self.contentView.addSubview(dateOfGame)
        
        for item in [titleOfGame, dateOfGame]
        {
           
            item.snp.makeConstraints
            { maker in
                maker.height.equalTo(self.contentView.frame.height * 0.9)
                maker.centerY.equalTo(self.contentView)
                
                if item == titleOfGame
                {
                    maker.width.equalTo(self.contentView.frame.width * 0.5)
                    maker.left.equalTo(10)
                }
                else
                {
                    maker.width.equalTo(self.contentView.frame.width * 0.2)
                    maker.right.equalTo(-10)
                }
            }
        }
    }
    
    var accessToTitleOfGame: String
    {
        get
        {
            return self.titleOfGame.text!
        }
        set
        {
//            self.titleOfGame.text = newValue
            self.titleOfGame.attributedText = NSAttributedString(string: newValue, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        }
    }
    
    var accessToDateOfGame: String
    {
        get
        {
            return self.dateOfGame.text!
        }
        set
        {
            self.dateOfGame.attributedText = NSAttributedString(string: newValue, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        }
    }
    
}

