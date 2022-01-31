//
//  Extention NavigationController.swift
//  BasketApp2.0
//
//  Created by Daniil on 31.01.2022.
//

import UIKit

extension UINavigationController
{
    open override var shouldAutorotate: Bool
    {
        return visibleViewController!.shouldAutorotate
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return visibleViewController!.supportedInterfaceOrientations
    }
}

extension UITabBarController
{
    open override var shouldAutorotate: Bool
    {
        return selectedViewController!.shouldAutorotate
    }

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return selectedViewController!.supportedInterfaceOrientations

    }
}
