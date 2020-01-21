//
//  Extensions.swift
//  OnlyHelp
//
//  Created by VEERA NARAYANA GUTTI on 29/10/19.
//  Copyright © 2019 VEERA NARAYANA GUTTI. All rights reserved.
//

import Foundation
extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
