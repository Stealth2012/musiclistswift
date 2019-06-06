//
//  UINavigationController.swift
//  musiclist
//
//  Created by Artem Shuba on 06/06/2019.
//  Copyright © 2019 ashuba. All rights reserved.
//

import UIKit

extension UINavigationController {
    override open var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
