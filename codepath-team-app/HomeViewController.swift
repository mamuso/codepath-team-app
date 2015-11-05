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
    @IBOutlet weak var articleTime: UILabel!
    @IBOutlet weak var slider: UISlider!
    
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
        
        updateTheme(0)
        
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
            cell.sourceLabel.text = item.url
            cell.headlineLabel.text = item.title
            cell.summaryLabel.text = item.excerpt
            cell.readtimeLabel.text = String(item.readtime)
            if item.readtime == 0 {
                cell.readtimeLabel.text = "<1"
                cell.readtimeLabel.font = cell.readtimeLabel.font.fontWithSize(24)
            } else if item.readtime >= 10 {
                cell.readtimeLabel.font = cell.readtimeLabel.font.fontWithSize(24)
            } else {
                cell.readtimeLabel.font = cell.readtimeLabel.font.fontWithSize(48)

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
        if self.readTime == 10 {
            self.articleTime.text = "10+"
            self.articleTime.font = self.articleTime.font.fontWithSize(120)
        } else if self.readTime == 0 {
            self.articleTime.text = "<1"
            self.articleTime.font = self.articleTime.font.fontWithSize(120)
        } else {
            self.articleTime.text = "\(self.readTime)"
            self.articleTime.font = self.articleTime.font.fontWithSize(144)
        }
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
    */
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailViewController = segue.destinationViewController as! ArticleViewController
        detailViewController.item = selectedItem
    }

}
