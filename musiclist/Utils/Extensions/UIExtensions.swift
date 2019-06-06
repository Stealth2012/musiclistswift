//
//  UIExtensions.swift
//  musiclist
//
//  Created by Artem Shuba on 09/05/16.
//  Copyright © 2016 ashuba. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setKerning(kerning: Double) {
        let text = self.text
        if text == nil || text!.isEmpty
        {
            return
        }
        
        self.attributedText = NSMutableAttributedString(string: text!, attributes: [NSAttributedString.Key.kern : kerning])
    }
}
