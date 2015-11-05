//
//  UserSettings.swift
//  codepath-team-app
//
//  Created by mmuno on 10/31/15.
//  Copyright © 2015 angel-magnolia-manuel. All rights reserved.
//

import Foundation
import Hex

class UserSettings {
    let prefs = NSUserDefaults.standardUserDefaults()
    var fontSize: Int!
    var theme: Int!
    
    // Colors
    var lightHex:String = "#EFF3F5"
    var darkHex:String = "#343A44"
    var lightColor = UIColor(hex: "#EFF3F5")
    var darkColor = UIColor(hex: "#343A44")
    
    // Font size values
    var fontSizes = [CGFloat(14), CGFloat(16), CGFloat(18)]

    init() {
        let fontSize = self.prefs.objectForKey("FontSize")
        let theme = self.prefs.objectForKey("Theme")

        self.fontSize = ((fontSize == nil) ? 1 : fontSize!) as! Int
        self.theme = ((theme == nil) ? 0 : theme!) as! Int
    }
    
    // Theme:
    // 0 is light (default), 1 is dark
    func setTheme(value:Int) {
        prefs.setObject(value, forKey: "Theme")
        self.theme = value
    }


    // FontSize:
    // 0 is small, 1 is medium (default), 2 is large
    func setFont(value:Int) {
        prefs.setObject(value, forKey: "FontSize")
        self.fontSize = value
    }
    
    
    func backgroundColor() -> UIColor {
        let color = (self.theme == 0) ? self.lightColor : self.darkColor
        return color
    }

    func foregroundColor() -> UIColor {
        let color = (self.theme == 0) ? self.darkColor : self.lightColor
        return color
    }

    func backgroundHex() -> String {
        let color = (self.theme == 0) ? self.lightHex : self.darkHex
        return color
    }

    func foregroundHex() -> String {
        let color = (self.theme == 0) ? self.darkHex : self.lightHex
        return color
    }
    
    // Setting the Background Color
    func setBackgroundTheme(view:UIView){
        view.backgroundColor = self.backgroundColor()
    }
}