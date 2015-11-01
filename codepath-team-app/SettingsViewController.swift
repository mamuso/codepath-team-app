//
//  SettingsViewController.swift
//  codepath-team-app
//
//  Created by mmuno on 10/22/15.
//  Copyright © 2015 angel-magnolia-manuel. All rights reserved.
//

import UIKit
import Hex
import PocketAPI

class SettingsViewController: ViewController {
    
    @IBOutlet weak var unlinkView: UIView!
    @IBOutlet weak var disconnectLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var themeView: UIView!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var themeLabel: UILabel!
    
    var dataObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the swithc by default
        let userSettings = UserSettings()
        themeSwitch.setOn(Bool(userSettings.theme!), animated: false)

        updateTheme()
    }
    
    override func viewDidAppear(animated: Bool) {
        /* Getting Pocket Data */
        let pocketQuery = PocketApiQuery()
        pocketQuery.fetchData()
        
        dataObserver = NSNotificationCenter.defaultCenter().addObserverForName("PAAFetchCompleteNotification",
            object: nil,
            queue: nil,
            usingBlock: { notification in
                print(pocketQuery.items[1].excerpt)
            }
        )

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onDisconnectAccount(sender: UIButton) {
        PocketAPI.sharedAPI().logout()
        performSegueWithIdentifier("logoutSegue", sender: nil)
    }
    
    @IBAction func onSwitchTheme(sender: AnyObject) {
        let userSettings = UserSettings()
        userSettings.setTheme(Int(themeSwitch.on))
        updateTheme()
    }
    
    func updateTheme() {
        // Get user defaults and set theme
        let userSettings = UserSettings()
        userSettings.setBackgroundTheme(self.view)
        
        
        /* Theme view */
        themeView.layer.backgroundColor = userSettings.backgroundColor().CGColor
        themeView.layer.borderWidth = 1
        themeView.layer.borderColor = userSettings.foregroundColor().colorWithAlphaComponent(0.3).CGColor
        themeLabel.textColor = userSettings.foregroundColor()
        
        /* Unlink account view */
        unlinkView.layer.backgroundColor = userSettings.backgroundColor().CGColor
        unlinkView.layer.borderWidth = 1
        unlinkView.layer.borderColor = userSettings.foregroundColor().colorWithAlphaComponent(0.3).CGColor
        
        usernameLabel.text = PocketAPI.sharedAPI().username
        usernameLabel.textColor = userSettings.foregroundColor().colorWithAlphaComponent(0.5)
        disconnectLabel.textColor = userSettings.foregroundColor()

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
