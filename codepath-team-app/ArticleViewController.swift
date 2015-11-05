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

//mag to do:
//  hook up bottom buttons
//  fix swipe
//  mark "left off" position


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
    @IBOutlet weak var navArticleTitle: UINavigationItem!
    
    var spaceUnderArticle: CGFloat!
    var articleOriginalCenter: CGPoint!
    var isArticleFavorited: CBool!
    var isArticleArchived: CBool!
    
    let userSettings = UserSettings()
    
    /* Passing a PocketItem */
    var item: PocketItem = PocketItem(id: 0, title: "", url: "", excerpt: nil, imgSrc: nil, timestamp: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navArticleTitle.title = item.title
        
        // Readability API
        let urlString = "https://www.readability.com/api/content/v1/parser?url=\(item.url)&token=\(String(CodepathKeys().readabilityToken()))"
        
        if let url = NSURL(string: urlString) {
            if let data = try? NSData(contentsOfURL: url, options: []) {
                let json = JSON(data: data)
                if json["content"] != nil {
                    
                    // print(json["content"])
                    
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
        let script = "document.body.innerHTML += '\(updateArticleConfiguration())';"
        let result = webView.stringByEvaluatingJavaScriptFromString(script)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onShare(sender: UIButton) {
        print("share article")
        //fake to fb
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
    }
    
    func updateArticleConfiguration() -> String {
        let userSettings = UserSettings()
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
    }
    
    @IBAction func onNext(sender: UIButton) {
        print("next article")
        //jump to next article in article view list
        
    }
    
    //@IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    /* @IBAction func onPan(sender: UIPanGestureRecognizer) {
    print("panGestureAction")
    let point = sender.locationInView(view)
    var velocity = sender.velocityInView(view)
    var translation = sender.translationInView(view)
    if sender.state == UIGestureRecognizerState.Began
    {} else if sender.state == UIGestureRecognizerState.Changed
    {}
    else if sender.state == UIGestureRecognizerState.Ended
    {}
    }
    */
    
    
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
