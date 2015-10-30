//
//  EducationViewController.swift
//  codepath-team-app
//
//  Created by mmuno on 10/22/15.
//  Copyright © 2015 angel-magnolia-manuel. All rights reserved.
//

import UIKit
import PocketAPI
import SafariServices

class EducationViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!

    var window: UIWindow?
    var authStartObserver: NSObjectProtocol?

    var homeViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        authStartObserver = NSNotificationCenter.defaultCenter().addObserverForName("PocketAuthStartNotification",
            object: nil,
            queue: nil,
            usingBlock: { notification in
                self.openPocketLoginScreenBy(notification)
            }
        )
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(authStartObserver!)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openPocketLoginScreenBy(notification: NSNotification) {
        let url: NSURL = notification.object as! NSURL
        let safariViewController: SFSafariViewController = SFSafariViewController(URL: url)
        presentViewController(safariViewController, animated: true, completion: nil)
    }

    @IBAction func onTapLogIn(sender: UIButton) {
        PocketAPI.sharedAPI().loginWithHandler { (api, error) in
            if error != nil {
                self.presentedViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
                    // API Error
                    let alertView = UIAlertController.init(title: "error", message: error.localizedDescription, preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: { action in return })
                    alertView.addAction(okAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                })
            } else {
                // Go to the main screen
                self.presentedViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
                    self.performSegueWithIdentifier("loginSegue", sender: nil)
                })
            }
        }
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
