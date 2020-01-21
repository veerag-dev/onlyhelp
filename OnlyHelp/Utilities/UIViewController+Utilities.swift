//
//  UIViewController+Utilities.swift
//  Humanity
//
//  Created by VEERA NARAYANA GUTTI on 25/09/16.
//  Copyright © 2016 VEERA NARAYANA GUTTI. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func functionNotAvailable() {
        if presentedViewController == nil {
            let alert = UIAlertController(title: nil, message: StyleKit.localizedString.alertFuncNotAvailable, preferredStyle: .alert)
            let cancel = UIAlertAction(title: StyleKit.localizedString.alertOk, style: .cancel, handler: nil)
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func showOfflineAlertForNetwork() {
        let settingAlert = UIAlertController(title: StyleKit.localizedString.networkingOfflineTitle, message: StyleKit.localizedString.networkingOfflineMessage, preferredStyle: .alert)
        let settings = UIAlertAction(title:StyleKit.localizedString.networkingOfflineSettings, style: .default) { (UIAlertAction) -> Void in
            let url = URL(string: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.openURL(url!)
            }
        }
        let cancel = UIAlertAction(title: StyleKit.localizedString.alertOk, style: .cancel, handler: nil)
        settingAlert.addAction(settings)
        settingAlert.addAction(cancel)
        self.present(settingAlert, animated: true, completion: nil)
    }
    func showAlertForLocationServices() {
        let settingAlert = UIAlertController(title: "", message: StyleKit.localizedString.locationServicesDisabled, preferredStyle: .alert)
        let settings = UIAlertAction(title:StyleKit.localizedString.networkingOfflineSettings, style: .default) { (UIAlertAction) -> Void in
            let url = URL(string: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.openURL(url!)
            }
        }
        let cancel = UIAlertAction(title: StyleKit.localizedString.alertOk, style: .cancel, handler: nil)
        settingAlert.addAction(settings)
        settingAlert.addAction(cancel)
        self.present(settingAlert, animated: true, completion: nil)
    }
    
    func displayAlertMessage(_ message: String, title: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: StyleKit.localizedString.alertOk, style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func displayAlertOnTop(_ title:String?,message:String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: StyleKit.localizedString.alertOk, style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while ((topVC?.presentedViewController) != nil) {
            topVC = topVC?.presentedViewController
        }
        
        topVC?.present(alert, animated: true, completion: nil)
    }
    func setTabBarVisible(visible: Bool, animated: Bool) {
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        
        // bail if the current state matches the desired state
        if (isTabBarVisible == visible) { return }
        
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        
        // zero duration means no animation
        let duration: TimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                return
            }
        }
    }
    
    var isTabBarVisible: Bool {
        return (self.tabBarController?.tabBar.frame.origin.y ?? 0) < self.view.frame.maxY
    }
}
