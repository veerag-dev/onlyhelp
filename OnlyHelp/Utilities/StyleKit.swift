//
//  StyleKit.swift
//
//  Created by VEERA NARAYANA GUTTI on 04/09/16.
//  Copyright © 2016 VEERA NARAYANA GUTTI. All rights reserved.
//

import UIKit

open class StyleKit : NSObject {
    
    //MARK: Color
    struct Color {
        static let white = UIColor.white
        static let black = UIColor.black
        static let lightGray = UIColor(hex: 0xEBEBED)
        static let gray = UIColor(hex: 0x45474A)
        static let orange = UIColor(hex: 0xE17901)

        static let darkTextColor = Color.gray
        static let subtitleTextColor = UIColor(hex: 0x53585F)
        static let lightSubtitleTextColor = UIColor(hex: 0x949494)
        static let disabledButtonTextColor = UIColor(hex: 0x949494)
        static let pageIndicatorTintColor = UIColor(hex: 0xBFC1C3)
        static let currentPageIndicatorTintColor = Color.orange
        static let imageBorderColor = UIColor(hex: 0xC5C5C5)
        static let defaultBlueTint = UIColor(hex: 0x007AFF)
        
        static let loginScreenBackgroundColor = Color.gray
        static let loginInsetBackgroundColor = UIColor(hex: 0xCBCBCB)
        static let loginSignInButtonBackgroundColor = Color.orange
        static let loginInputFieldBackgroundColor = Color.white
        static let loginHeadingTextColor = Color.black
        static let loginInputFieldTextColor = Color.black
        
        static let selectedCellBackgroundColor = UIColor(hex: 0xE0E0E0)
        static let cellAccessoryColor = UIColor(hex: 0x6D6D6D)
        
        static let searchBarTintColor = UIColor(hex: 0xE6E6E9)
        static let alertsHeaderLabelTextColor = UIColor(hex: 0x6D6D6D)
    }
    
    //MARK: Font
    struct Font {
        static let commonDoneButton = UIFont.boldSystemFont(ofSize: 17)
        static let categoryCellTitleLabel = UIFont.systemFont(ofSize: 32)
        static let categoryCellLabel = UIFont.systemFont(ofSize: 32)
        static let priorityAnnotationFont = UIFont.systemFont(ofSize: 12)
        static let workOrderDetailsStartButton = UIFont.boldSystemFont(ofSize: 17)
        static let workOrderCompleteSubmitButton = UIFont.boldSystemFont(ofSize: 17)
        static let loginHeadingLabelFont = UIFont.boldSystemFont(ofSize: 17)
        static let loginInputTextFieldFont = UIFont.boldSystemFont(ofSize: 17)
        static let loginFooterLabelFont = UIFont.systemFont(ofSize: 11)
        static let causeCodeCellLabelFont = UIFont.systemFont(ofSize: 17)
        static let timeerDisplayButtonFont = UIFont.systemFont(ofSize: 13)
        static let alertsTableHeaderLabelFont = UIFont.systemFont(ofSize: 13)
        static let alertsCellLabelFont = UIFont.systemFont(ofSize: 15)
        static let timePickerFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        static let timePickerUnitFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)
        static let addJobSubmitButtonFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)
    }

    //MARK: Localized String
    struct localizedString {
        
        //MARK: Authentication
        static let loginVersionVOText: String = NSLocalizedString("login:version_vo_text", comment: "")
        static let loginUsernamePlaceholder: String = NSLocalizedString("login:username_placeholder", comment: "")
        static let loginPasswordPlaceholder: String = NSLocalizedString("login:password_placeholder", comment: "")
        
        // MARK: Common Localization
        static let cancel: String = NSLocalizedString("common:cancel", comment: "")
        static let submit: String = NSLocalizedString("common:submit", comment: "")
        static let done: String = NSLocalizedString("common:done", comment: "")
        static let edit: String = NSLocalizedString("common:edit", comment: "")
        static let add:String = NSLocalizedString("common:add", comment: "")
        static let selected:String = NSLocalizedString("common:selected", comment: "")
        static let unselected: String = NSLocalizedString("common:unselected", comment: "")
        static let more:String = NSLocalizedString("common:more", comment: "")
        static let dismiss:String = NSLocalizedString("common:dismiss", comment: "")
        static let close: String = NSLocalizedString("common:close", comment: "")
        static let notApplicable: String = NSLocalizedString("common:not_applicable", comment: "")
        static let PreparingArielView:String = NSLocalizedString("PreparingArielView", comment: "")
        static let spinnerVOText:String = NSLocalizedString("common:inprogress", comment: "")

        static let creatingRoute:String = NSLocalizedString("creating_route", comment: "")
        static let sendingMail:String = NSLocalizedString("sending_mail",comment :"")
        static let findingAdress:String = NSLocalizedString("finding_address", comment: "")
        static let alertFuncNotAvailable:String = NSLocalizedString("func_not_available", comment: "")
        static let networkingOfflineMessage:String = NSLocalizedString("offline", comment: "")
        static let alertOk:String = NSLocalizedString("ok", comment: "")
        static let networkingOfflineSettings:String = NSLocalizedString("settings", comment: "")
        static let networkingOfflineTitle:String = NSLocalizedString("offline_title", comment: "")
        static let locationServicesDisabled:String = NSLocalizedString("locationServicesDisabled", comment: "")
        static func mapJobCountTitle(_ count: Int) -> String {
            let format = NSLocalizedString("map:job_count_format %d job(s)", comment:"")
            return String.localizedStringWithFormat(format, count)
        }



        //case 1 : Has submitted n help request

        static let helpRequestAt:String = NSLocalizedString("helpRequestAt", comment: "")
        static let hasSubmitted:String = NSLocalizedString("hasSubmitted", comment: "")
        static let  seeIntheHelpListMore:String =  NSLocalizedString("seeIntheHelpListMore", comment: "")


        //case 2 : Individual submit

        static let seeInTheHelplistSingle:String = NSLocalizedString("seeInTheHelplistSingle", comment: "")
        static let ItsYourTime:String = NSLocalizedString("ItsYourTime", comment: "")

        //case 3 : Going to help

        static let isGoingToHelp:String = NSLocalizedString("isGoingToHelp", comment: "")
        static let neededForHelp:String = NSLocalizedString("neededForHelp", comment: "")
        static let letsAppreciate:String = NSLocalizedString("letsAppreciate", comment: "")
    }
}

extension UIColor {
    //Prefix Hex with 0x
    convenience init(hex: Int) {
        self.init(hex: hex, alpha: 1)
    }
    convenience init(hex: Int, alpha: Double) {
        self.init(
            red: CGFloat((hex >> 16) & 0xff) / 255,
            green: CGFloat((hex >> 8) & 0xff) / 255,
            blue: CGFloat(hex & 0xff) / 255,
            alpha: CGFloat(alpha))
    }
    func colorWithHue(_ newHue: CGFloat) -> UIColor {
        var saturation: CGFloat = 1.0, brightness: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getHue(nil, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: newHue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    func colorWithSaturation(_ newSaturation: CGFloat) -> UIColor {
        var hue: CGFloat = 1.0, brightness: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getHue(&hue, saturation: nil, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: newSaturation, brightness: brightness, alpha: alpha)
    }
    func colorWithBrightness(_ newBrightness: CGFloat) -> UIColor {
        var hue: CGFloat = 1.0, saturation: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getHue(&hue, saturation: &saturation, brightness: nil, alpha: &alpha)
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
    func colorWithAlpha(_ newAlpha: CGFloat) -> UIColor {
        var hue: CGFloat = 1.0, saturation: CGFloat = 1.0, brightness: CGFloat = 1.0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: newAlpha)
    }
    func colorWithHighlight(_ highlight: CGFloat) -> UIColor {
        var red: CGFloat = 1.0, green: CGFloat = 1.0, blue: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * (1-highlight) + highlight, green: green * (1-highlight) + highlight, blue: blue * (1-highlight) + highlight, alpha: alpha * (1-highlight) + highlight)
    }
    func colorWithShadow(_ shadow: CGFloat) -> UIColor {
        var red: CGFloat = 1.0, green: CGFloat = 1.0, blue: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * (1-shadow), green: green * (1-shadow), blue: blue * (1-shadow), alpha: alpha * (1-shadow) + shadow)
    }
}

