//
//  AppSettings.swift
//  OnlyHelp
//
//  Created by VEERA NARAYANA GUTTI on 29/10/19.
//  Copyright © 2019 VEERA NARAYANA GUTTI. All rights reserved.
//

import Foundation

class AppSettings {
    static let sharedInstance = AppSettings()
    var currentUserId : String = String()
    var currentUsername : String = String()
    var currentUserFullName : String = String()
    var currentUserPhoneNo : String = String()
    var currentUserSex : String = String()
    var currentUserEMail : String = String()
    var currentUserProfileImageData : Data = Data()
    var isAcceptedTnC:Bool = Bool()
}
