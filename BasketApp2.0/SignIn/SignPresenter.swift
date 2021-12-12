//
//  SignPresenter.swift
//  BasketApp2.0
//
//  Created by Daniil on 01.12.2021.
//
import UIKit
import SnapKit
class SignPresenter
{
    private var model = SignModel()
//    private var
    func forgetPassword()
    {
        
    }
   
    func getRegisterView() -> UIViewController
    {
        let view = RegisterView()
        return view
    }
    
    func getTabBarController() -> UITabBarController
    {
        let tabBar = UITabBarController()
        let profile = ProfileView()
        
        let dictionaryOfController = ["Profile": UINavigationController(rootViewController: ProfileView()), "Teams": UINavigationController(rootViewController: TeamsView()), "Games":UINavigationController(rootViewController: GamesView())]
        
        tabBar.setViewControllers(Array(dictionaryOfController.values), animated: true)
        for i in 0..<tabBar.tabBar.items!.count
        {
            tabBar.tabBar.items![i].title = Array(dictionaryOfController.keys)[i]
        }
        
        tabBar.tabBar.backgroundColor = .white
        
        return tabBar
    }
   
}
