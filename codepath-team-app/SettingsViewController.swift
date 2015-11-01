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

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var unlinkView: UIView!
    @IBOutlet weak var disconnectLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var themeView: UIView!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var themeLabel: UILabel!

    @IBOutlet weak var fontView: UIView!
    @IBOutlet weak var fontLabel: UILabel!
    
    @IBOutlet weak var fontSmallLabel: UILabel!
    
    @IBOutlet weak var fontMediumLabel: UILabel!
    
    @IBOutlet weak var fontLargeLabel: UILabel!
    
    @IBOutlet weak var fontSlider: UISlider!
    @IBOutlet weak var fontSample: UILabel!
    
    var dataObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the switch by default
        let userSettings = UserSettings()
        themeSwitch.setOn(Bool(userSettings.theme!), animated: false)
        fontSample.sizeToFit()

        updateTheme(0)
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
        updateTheme(0.2)
    }
    
    func updateTheme(duration: Double) {
        // Get user defaults and set theme
        let userSettings = UserSettings()
        
        UIView.animateWithDuration(duration) { () -> Void in
            userSettings.setBackgroundTheme(self.view)
            /* Navigation Bar Color */
            if (userSettings.theme == 0) {
                UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
            } else {
                UIApplication.sharedApplication().statusBarStyle = .LightContent

            }
            
            /* Font view */
            self.fontView.layer.backgroundColor = userSettings.backgroundColor().CGColor
            self.fontLabel.textColor = userSettings.foregroundColor()
            self.fontSmallLabel.textColor = userSettings.foregroundColor().colorWithAlphaComponent(0.7)
            self.fontMediumLabel.textColor = userSettings.foregroundColor().colorWithAlphaComponent(0.7)
            self.fontLargeLabel.textColor = userSettings.foregroundColor().colorWithAlphaComponent(0.7)
            self.fontSample.textColor = userSettings.foregroundColor()

            
            /* Theme view */
            self.themeView.layer.backgroundColor = userSettings.backgroundColor().CGColor
            self.themeView.layer.borderWidth = 1
            self.themeView.layer.borderColor = userSettings.foregroundColor().colorWithAlphaComponent(0.3).CGColor
            self.themeLabel.textColor = userSettings.foregroundColor()
            
            /* Unlink account view */
            self.unlinkView.layer.backgroundColor = userSettings.backgroundColor().CGColor
            self.unlinkView.layer.borderWidth = 1
            self.unlinkView.layer.borderColor = userSettings.foregroundColor().colorWithAlphaComponent(0.3).CGColor
            
            self.usernameLabel.text = PocketAPI.sharedAPI().username
            self.usernameLabel.textColor = userSettings.foregroundColor().colorWithAlphaComponent(0.5)
            self.disconnectLabel.textColor = userSettings.foregroundColor()
        }
        


    }
    
    @IBAction func onSliderValueChange(sender: UISlider) {
        let userSettings = UserSettings()

        sender.value = roundf(sender.value)
        let fontValue = Int(roundf(sender.value))
        fontSample.font = UIFont(name: fontSample.font.fontName, size: userSettings.fontSizes[fontValue])
        fontSample.sizeToFit()
        userSettings.setFont(fontValue)
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
