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

class EducationViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    var window: UIWindow?
    var authStartObserver: NSObjectProtocol?
    var homeViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.frame.size.width = 320
        scrollView.contentSize.width = 960
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
    
    // Scroll functions
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // This method is called when the scrollview finally stops scrolling.
        let page : Int = Int(round(scrollView.contentOffset.x / 320))
        pageControl.currentPage = page
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
