//
//  HelpFeedViewController.swift
//  OnlyHelp
//
//  Created by VEERA NARAYANA GUTTI on 29/10/19.
//  Copyright © 2019 VEERA NARAYANA GUTTI. All rights reserved.
//

import UIKit

class HelpFeedViewController: UIViewController {

    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
