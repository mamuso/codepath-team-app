//
//  HomeViewController.swift
//  codepath-team-app
//
//  Created by mmuno on 10/22/15.
//  Copyright © 2015 angel-magnolia-manuel. All rights reserved.
//

import UIKit
import Hex
import PocketAPI

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Slider View
    //@IBOutlet weak var slider: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var doneLabel: UILabel!
    
    // Counter
    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var count0: UIView!
    @IBOutlet weak var count1: UIView!
    @IBOutlet weak var count2: UIView!
    @IBOutlet weak var count3: UIView!
    @IBOutlet weak var count4: UIView!
    @IBOutlet weak var count5: UIView!
    @IBOutlet weak var count6: UIView!
    @IBOutlet weak var count7: UIView!
    @IBOutlet weak var count8: UIView!
    @IBOutlet weak var count9: UIView!
    @IBOutlet weak var count10: UIView!
    
    var numberViews:[UIView]!
    
    //Table View
    @IBOutlet weak var tableView: UITableView!
    
    //create array made of strings
    var sources: [String]!
    var headlines: [String]!
    var summaries: [String]!
    var readtimes: [String]!
    
    //create pocket stuff
    var pocketQuery: PocketApiQuery = PocketApiQuery()
    var dataObserver: NSObjectProtocol?
    var pocketData: [PocketItem]!
    var cellCount: Int! = 0
    var readTime: Int! = 5
    
    var userSettings = UserSettings()
    
    //item id pass
    var selectedItem: PocketItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberViews = [count0, count1, count2, count3, count4, count5, count6, count7, count8, count9, count10]
        
        updateTheme(0)
        
        animateCounter(Int(self.slider.value))
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        /* Getting Pocket Data */
        self.pocketQuery.fetchData()
        self.readTime = Int(self.slider.value)
        
        dataObserver = NSNotificationCenter.defaultCenter().addObserverForName("PAAFetchCompleteNotification",
            object: nil,
            queue: nil,
            usingBlock: { notification in
                //print(sellf.pocketQuery.items.count)
                
                /*
                self.cellCount = self.pocketQuery.items.count
                self.tableView.reloadData()
                self.pocketData = pocketQuery.items
                */
                self.filterItems()
            }
        )
        // Setting the switch by default
        //let readSettings = UserSettings()
        //preferredReadTime(0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        updateTheme(0)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        updateTheme(0)
    }
    
    func animateCounter(count:Int) {
        UIView.animateWithDuration(0.25) { () -> Void in
            let val = CGFloat((count * -90) + 110 + 500)
            self.counterView.center = CGPoint(x: val, y: self.counterView.center.y)
            for (index, numberView) in self.numberViews.enumerate() {
                if (index == count) {
                    numberView.transform = CGAffineTransformMakeScale(1, 1)
                    numberView.alpha = 1
                    
                } else {
                    numberView.transform = CGAffineTransformMakeScale(0.8, 0.8)
                    numberView.alpha = 0.2
                }
            }
        }
    }
    
    
    
    // filter the results in pocketQuery.items by those <= readTime & reload the table.
    func filterItems() {
        self.pocketData = self.pocketQuery.items.filter({ (item: PocketItem) -> Bool in
            return item.readtime <= self.readTime
        })
        self.cellCount = self.pocketData.count
        self.tableView.reloadData()
    }
    
    // Tell the table view how many rows you want
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return sources.count
        return cellCount
    }
    
    //For each row, what do you want that row to look like
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell")! as! ArticleCell
        
        if indexPath.row < self.cellCount {
            let item = self.pocketData[indexPath.row]
            //populate cells with content from arrays
            cell.sourceLabel.text = NSURL(string: item.url)?.host!.stringByReplacingOccurrencesOfString("www.", withString: "")
            cell.headlineLabel.text = item.title
            cell.headlineLabel.frame.size.width = 275
            cell.headlineLabel.sizeToFit()
            cell.summaryLabel.text = item.excerpt
            cell.readtimeLabel.text = "\(String(item.readtime))m read"
            if item.readtime == 0 {
                cell.readtimeLabel.text = "<1m read"
            }
            cell.pocketItemId = item.id
        }
        return cell
    }
    
    //Code Cell Selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        selectedItem = pocketData[indexPath.row]
        performSegueWithIdentifier("viewArticle", sender: self)
    }
    
    @IBAction func onSliderValueChange(sender: UISlider) {
        self.readTime = Int(sender.value)
        animateCounter(readTime)
        // filter results by new value & reload the tableView
        self.filterItems()
    }
    
    /*@IBAction func onSliderValueChange(sender: UISlider) {
    let userSettings = UserSettings()
    sender.value = roundf(sender.value)
    let fontValue = Int(roundf(sender.value))
    fontSample.font = UIFont(name: fontSample.font.fontName, size: userSettings.fontSizes[fontValue])
    fontSample.sizeToFit()
    userSettings.setFont(fontValue)
    }*/
    
    func updateTheme(duration: Double) {
        // Get user defaults and set theme
        userSettings = UserSettings()
        
        for numberView in numberViews {
            for subview in numberView.subviews {
                if let labelView = subview as? UILabel {
                    labelView.textColor = self.userSettings.foregroundColor()
                }
            }
            
        }
        
        UIView.animateWithDuration(duration) { () -> Void in
            self.userSettings.setBackgroundTheme(self.view)
            /* Navigation Bar Color */
            if (self.userSettings.theme == 0) {
                UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
            } else {
                UIApplication.sharedApplication().statusBarStyle = .LightContent
            }
            
            // Tab bar
            self.navigationController?.tabBarController!.tabBar.barTintColor = self.userSettings.backgroundColor().colorWithAlphaComponent(0.8)
            self.navigationController?.tabBarController!.tabBar.tintColor = self.userSettings.foregroundColor()
            
            // Nav bar
            self.navigationController?.navigationBar.barTintColor = self.userSettings.backgroundColor().colorWithAlphaComponent(0.7)
            self.navigationController?.navigationBar.tintColor = self.userSettings.foregroundColor().colorWithAlphaComponent(0.7)
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: self.userSettings.foregroundColor().colorWithAlphaComponent(0.9)]
            
            self.doneLabel.textColor = self.userSettings.foregroundColor()
            
            
        }
    }
    
    
    /*
    // MARK: - Navigation
    */
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailViewController = segue.destinationViewController as! ArticleViewController
        detailViewController.item = selectedItem
    }
    
}
