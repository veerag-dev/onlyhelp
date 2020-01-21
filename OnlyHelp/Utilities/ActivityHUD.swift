//
//  ActivityHUD.swift
//  Humanity
//
//  Created by VEERA NARAYANA GUTTI on 24/09/16.
//  Copyright © 2016 VEERA NARAYANA GUTTI. All rights reserved.
//

import UIKit
import Foundation

class ActivityHUD: UIWindow {
    
    static func show(withTitle title: String? = nil) {
        ActivityHUD.sharedWindow.show(withTitle: title)
    }
    
    static func hide() {
        ActivityHUD.sharedWindow.hide()
    }
    
    // Static
    static let backdropColor = UIColor(white: 0, alpha: 0.4)
    static let scaleTransform = CATransform3DMakeScale(0.5, 0.5, 0.5)
    static let sharedWindow: ActivityHUD = {
        let window = ActivityHUD(frame: UIScreen.main.bounds)
        window.windowLevel = UIWindow.Level.statusBar + 1
        window.makeKeyAndVisible()
        window.rootViewController = ActivityRootViewController()
        return window
    }()
    
    // Instance
    var animationDuration: TimeInterval = 0.25
    private(set) var active = false {
        didSet {
            isUserInteractionEnabled = active
        }
    }
    
    var textAttributes: [NSAttributedString.Key : Any]? {
        get {
            return activityView.textAttributes
        }
        set {
            activityView.textAttributes = newValue
        }
    }
    
    private lazy var activityView: ActivityView = {
        let activityView = ActivityView()
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(activityView)
        centerXAnchor.constraint(equalTo: activityView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: activityView.centerYAnchor).isActive = true
        
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        active = false
        activityView.layer.transform = type(of: self).scaleTransform
        activityView.alpha = 0
        
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(ActivityHUD.floatToTop(notification:)),
                                                         name: UIWindow.didBecomeVisibleNotification,
                                                         object: nil
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func floatToTop(notification: NSNotification) {
        if !(notification.object is ActivityHUD) {
            type(of: self).sharedWindow.isHidden = true
            type(of: self).sharedWindow.isHidden = false
        }
    }
    
    func show(withTitle title: String? = nil) {
        active = true
        activityView.title = title
        isHidden = false
        
        UIView.animate(withDuration: animationDuration) {
            self.backgroundColor = type(of: self).backdropColor
            self.activityView.layer.transform = CATransform3DIdentity
            self.activityView.alpha = 1
        }
    }
    
    func hide() {
        active = false
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.backgroundColor = UIColor.clear
            self.activityView.layer.transform = type(of: self).scaleTransform
            self.activityView.alpha = 0
        }) { (finished) -> Void in
            if finished {
                self.isHidden = !self.active
            }
        }
    }
    
    
}

class ActivityView: UIView {
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.accessibilityLabel = "In progress ..."
        return spinner
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriority.required, for: NSLayoutConstraint.Axis.vertical)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.spinner, self.label])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let horizontalPadding: CGFloat = 20
    private let verticalPadding: CGFloat = 16
    private let maxWidth: CGFloat = 200
    private let minLength: CGFloat = 116
    
    private var didCreateConstraints = false
    
    var textAttributes: [NSAttributedString.Key : Any]? {
        didSet {
           // title = (title)
        }
    }
    
    var title: String? {
        get {
            return label.text
        }
        set {
            label.attributedText = NSAttributedString(string: newValue ?? "", attributes: textAttributes)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 1, alpha: 1)
        layer.cornerRadius = 14
        clipsToBounds = true
        addSubview(stackView)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !didCreateConstraints {
            
            stackView.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth - horizontalPadding*2).isActive = true
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: minLength - horizontalPadding*2).isActive = true
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: minLength - verticalPadding*2).isActive = true
            
            leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: -horizontalPadding).isActive = true
            rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: horizontalPadding).isActive = true
            topAnchor.constraint(equalTo: stackView.topAnchor, constant: -verticalPadding).isActive = true
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: verticalPadding).isActive = true
            
            stackView.setNeedsLayout()
            didCreateConstraints = true
        }
    }
}

class ActivityRootViewController: UIViewController {
    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
