//
//  HomeViewController.swift
//  codepath-team-app
//
//  Created by mmuno on 10/22/15.
//  Copyright © 2015 angel-magnolia-manuel. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        //fake arrays to stub out data
        sources = ["NYTimes.com", "Huffington Post", "Buzzfeed", "Medium", "Yahoo! News", "Bakadesuyo.com"]
        headlines = ["Once Partners, Bush and Rubio Brace for Clash After Debate", "Report: Majority Of Married People Get Up And Go To Second Family’s House As Soon As Spouse Asleep", "9 Senior White House Staffers Injured In Collapse Of Overcrowded Truman Balcony", "6-Year-Old Data Entry Prodigy Already Entertaining Offers From Major Temp Agencies", "Woman Confusingly Tells Area Man She’s Not Interested In Him", "Scientists Find Strong Link Between Male Virility, Wearing Mötley Crüe Denim Jacket"]
        summaries = ["During the Republican debate, the onetime political partners in Florida offered a preview of a fight with Marco Rubio that Jeb Bush and his allies see slipping from their grasp.", "CHICAGO—Describing it as a common nightly ritual for tens of millions of Americans nationwide, a report published Thursday", "Police and emergency responders were called to 1600 Pennsylvania Avenue in the early morning hours Thursday after the White House’s Truman Balcony collapsed", "He might only be in kindergarten, but data entry prodigy Jeffrey Peters is well on his way to a career of endlessly depressing temp jobs.", "Evidently undertaking the next maneuver in her endless series of bewildering mind games, infinitely perplexing woman Haley Mueller cryptically told Pete Summers Friday evening that she wasn’t interested in dating him", "A new study from Harvard University found that men who wear Mötley Crüe denim jackets on a regular basis showed staggering levels of testosterone and sexual prowess."]
        readtimes = ["4", "5", "3", "5", "4", "2"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Tell the table view how many rows you want
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }

    //For each row, what do you want that row to look like
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell")! as! ArticleCell
        //populate cells with content from arrays
        cell.sourceLabel.text = sources[indexPath.row]
        cell.headlineLabel.text = headlines[indexPath.row]
        cell.summaryLabel.text = summaries[indexPath.row]
        cell.readtimeLabel.text = readtimes[indexPath.row]
        
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
