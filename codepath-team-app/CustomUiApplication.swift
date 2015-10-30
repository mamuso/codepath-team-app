//
//  CustomUiApplication.swift
//  codepath-team-app
//
//  Created by Manuel Muñoz Solera on 10/29/15.
//  Copyright © 2015 angel-magnolia-manuel. All rights reserved.
//

import Foundation
import UIKit

@objc(CustomUiApplication) class CustomUiApplication: UIApplication {
    override func openURL(url: NSURL) -> Bool {
        if let host = url.host {
            if host == "getpocket.com" {
                NSNotificationCenter.defaultCenter().postNotificationName("PocketAuthStartNotification",
                    object: url
                )
                return false
            }
        }
        return super.openURL(url)
    }
}