//
//  ArticleViewController.swift
//  codepath-team-app
//
//  Created by mmuno on 10/22/15.
//  Copyright © 2015 angel-magnolia-manuel. All rights reserved.
//

import UIKit
import SwiftyJSON
import Hex
import Keys


class ArticleViewController: UIViewController {
    //UIScrollViewDelegate
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    //@IBOutlet weak var placeholderArticle: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var archiveButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var doneTextLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var leftEdgeMenuView: UIView! //changed to right side - ignore the references to left!
    
    var leftEdgeMenuOriginalCenter: CGPoint!
    var spaceUnderArticle: CGFloat!
    var articleOriginalCenter: CGPoint!
    var isArticleFavorited: CBool!
    var isArticleArchived: CBool!
    
    var userSettings = UserSettings()
    
    /* Passing a PocketItem */
    var item: PocketItem = PocketItem(id: 0, title: "", url: "", excerpt: nil, imgSrc: nil, timestamp: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTheme(0)
        
        self.navigationItem.title = item.title
        
        // Readability API
        let urlString = "https://www.readability.com/api/content/v1/parser?url=\(item.url)&token=\(String(CodepathKeys().readabilityToken()))"
        
        if let url = NSURL(string: urlString) {
            if let data = try? NSData(contentsOfURL: url, options: []) {
                let json = JSON(data: data)
                if json["content"] != nil {
                    
                    // Where is the CSS
                    let stylesheetUrl = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("article", ofType: "css")!)
                    // Let's make some HTML
                    var html = "<!doctype html><html lang=en-us><head><meta charset=utf-8><head>"
                    html += "<link rel=stylesheet href='\(stylesheetUrl)'>"
                    html += updateArticleConfiguration()
                    html += "</head><body>"
                    html += json["content"].stringValue
                    html += "</body></html>"
                    self.webView.loadHTMLString(html, baseURL: nil)
                    
                }
            }
        }
        
        spaceUnderArticle = 25
        
        //set "all done" text under article
        //        doneTextLabel.frame.origin.y = articleTextLabel.frame.size.height + spaceUnderArticle
        //
        //        //set button options under "all done" text
        //        shareButton.frame.origin.y = articleTextLabel.frame.size.height + spaceUnderArticle * 2
        //        favoriteButton.frame.origin.y = articleTextLabel.frame.size.height + spaceUnderArticle * 2
        //        archiveButton.frame.origin.y = articleTextLabel.frame.size.height + spaceUnderArticle * 2
        //        nextButton.frame.origin.y = articleTextLabel.frame.size.height + spaceUnderArticle * 2 //"next" or "more"
    }
    
    //NEXT:
    //  as scroll down, SAVE greatest scroll position
    //  id for each article?
    //  hide tab controller on this page
    
    
    override func viewDidAppear(animated: Bool) {
        updateTheme(0)
        let script = "document.body.innerHTML += '\(updateArticleConfiguration())';"
        webView.stringByEvaluatingJavaScriptFromString(script)
    }

    
    override func viewWillAppear(animated: Bool) {
        updateTheme(0)
    }
    
    //screen edge gesture
    @IBAction func onLeftScreenEdge(sender: UIScreenEdgePanGestureRecognizer) {
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began
        {
            //print("screen edge BEGAN!")
            leftEdgeMenuOriginalCenter = leftEdgeMenuView.center
            leftEdgeMenuView.alpha = 1
        }
        else if sender.state == UIGestureRecognizerState.Changed
        {
            leftEdgeMenuView.center = CGPoint(x:leftEdgeMenuOriginalCenter.x + translation.x, y:leftEdgeMenuOriginalCenter.y)
        }
        else if sender.state == UIGestureRecognizerState.Ended
        {
            if velocity.x < 0 { //reveal menu
                
                leftEdgeMenuView.center = CGPoint(x:leftEdgeMenuOriginalCenter.x - 300, y:leftEdgeMenuOriginalCenter.y)
            }
            else { //hide
                slideRightMenuToHide()
            }
            
        }

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func slideRightMenuToHide() {
        leftEdgeMenuView.center = CGPoint(x:leftEdgeMenuOriginalCenter.x, y:leftEdgeMenuOriginalCenter.y)
        leftEdgeMenuView.alpha = 0.1
    }
    
    @IBAction func onShare(sender: UIButton) {
        print("share article")
        //fake to fb
        slideRightMenuToHide()
    }
    
    @IBAction func onFavorite(sender: UIButton) {
        print("favorite article")
        if isArticleFavorited != nil {
            print("onFavorite - already favorited")
            
        }
        else {
            print("onFavorite - set")
            isArticleFavorited = true
            //mark as favorite & change icon
            //treat same as in article list
        }
        slideRightMenuToHide()
    }
    
    func updateArticleConfiguration() -> String {
        userSettings = UserSettings()
        let articleConfig = "<style>body{background:\(userSettings.backgroundHex()); color:\(userSettings.foregroundHex()); font-size: \(userSettings.fontSizes[userSettings.fontSize])px}</style>"
        return articleConfig
    }
    
    @IBAction func onArchive(sender: UIButton) {
        if isArticleArchived != nil {
            print("onArchive - already archived")
        }
        else {
            print("onArchive - set")
            isArticleArchived = true
            //add to archived/read list
            
        }
        slideRightMenuToHide()
    }
    
    @IBAction func onNext(sender: UIButton) {
        print("next article")
        //jump to next article in article view list
        slideRightMenuToHide()
    }
    
    
    func updateTheme(duration: Double) {
        // Get user defaults and set theme
        userSettings = UserSettings()

        UIView.animateWithDuration(duration) { () -> Void in
            self.userSettings.setBackgroundTheme(self.view)
            /* Navigation Bar Color */
            if (self.userSettings.theme == 0) {
                UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
            } else {
                UIApplication.sharedApplication().statusBarStyle = .LightContent
            }
            
            // Nav bar
            self.navigationController?.navigationBar.barTintColor = self.userSettings.backgroundColor().colorWithAlphaComponent(0.7)
            self.navigationController?.navigationBar.tintColor = self.userSettings.foregroundColor().colorWithAlphaComponent(0.7)
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: self.userSettings.foregroundColor().colorWithAlphaComponent(0.9)]
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
    
    @IBAction func onTabBack(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
