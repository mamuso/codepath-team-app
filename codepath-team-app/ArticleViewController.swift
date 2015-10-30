//
//  ArticleViewController.swift
//  codepath-team-app
//
//  Created by mmuno on 10/22/15.
//  Copyright © 2015 angel-magnolia-manuel. All rights reserved.
//

import UIKit

class ArticleViewController: ViewController {
//UIScrollViewDelegate
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var placeholderArticle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = placeholderArticle.image!.size
        
        //scrollView.contentSize = imageView.image!.size
        
        
        // Do any additional setup after loading the view.
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
    
    @IBAction func onTabBack(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }

}
