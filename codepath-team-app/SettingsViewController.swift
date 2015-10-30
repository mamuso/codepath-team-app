//
//  SettingsViewController.swift
//  codepath-team-app
//
//  Created by mmuno on 10/22/15.
//  Copyright © 2015 angel-magnolia-manuel. All rights reserved.
//

import UIKit
import Hex
import PocketAPI

class SettingsViewController: ViewController {
    
    @IBOutlet weak var unlinkView: UIView!
    
    var dataObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /* Unlink account view */
        unlinkView.layer.borderWidth = 1
        unlinkView.layer.borderColor = UIColor(hex: "FF0000").CGColor
        let prefs = NSUserDefaults.standardUserDefaults()
        print(PocketAPI.sharedAPI().username)
    }
    
    override func viewDidAppear(animated: Bool) {
        /* Getting Pocket Data */
        let pocketQuery = PocketApiQuery()
        pocketQuery.fetchData()
        
        dataObserver = NSNotificationCenter.defaultCenter().addObserverForName("PAAFetchCompleteNotification",
            object: nil,
            queue: nil,
            usingBlock: { notification in
                print(pocketQuery.items[1].excerpt)
            }
        )

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
