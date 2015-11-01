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

class HomeViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Slider View
    @IBOutlet weak var slider: UIView!
    @IBOutlet weak var articleLength: UILabel!

    //Table View
    @IBOutlet weak var tableView: UITableView!
    
    //create array made of strings
    var sources: [String]!
    var headlines: [String]!
    var summaries: [String]!
    var readtimes: [String]!
    
    //create pocket stuff
    var pocketQuery: PocketApiQuery?
    var dataObserver: NSObjectProtocol?
    var pocketData: [PocketItem]!
    var cellCount: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        /* Getting Pocket Data */
        let pocketQuery = PocketApiQuery()
        pocketQuery.fetchData()
        
        dataObserver = NSNotificationCenter.defaultCenter().addObserverForName("PAAFetchCompleteNotification",
            object: nil,
            queue: nil,
            usingBlock: { notification in
                print(pocketQuery.items[0].excerpt)
                //print(pocketQuery.items.count)
                self.cellCount = pocketQuery.items.count
                self.tableView.reloadData()
                self.pocketData = pocketQuery.items
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Tell the table view how many rows you want
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return sources.count
        print(cellCount)
        return cellCount
    }

    //For each row, what do you want that row to look like
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell")! as! ArticleCell
        if indexPath.row < self.cellCount {
            let item = pocketData[indexPath.row]
            //populate cells with content from arrays
            cell.sourceLabel.text = item.url
            cell.headlineLabel.text = item.title
            cell.summaryLabel.text = item.excerpt
            cell.readtimeLabel.text = String(item.readtime)
        }
        return cell
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
