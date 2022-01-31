//
//  RotationNavigationController.swift
//  BasketApp2.0
//
//  Created by Daniil on 31.01.2022.
//

import UIKit

class RotationNavigationController: UINavigationController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override var shouldAutorotate: Bool
    {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return (visibleViewController is GameView) ? (.landscape) :(.portrait)
//        return visibleViewController!.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
    {
        return (visibleViewController is GameView) ? (.landscapeRight) :(.portrait)
//        return visibleViewController!.preferredInterfaceOrientationForPresentation
    }
}

class RotationTabBarController: UITabBarController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override var shouldAutorotate: Bool
    {
        
        return true
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return selectedViewController!.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
    {
        return selectedViewController!.preferredInterfaceOrientationForPresentation
    }
    
}
