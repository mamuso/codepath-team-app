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
    @IBOutlet weak var articleTextLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var doneTextLabel: UILabel!
    
    var articleText: String!
    var spaceUnderArticle: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleText = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc."
        
        articleTextLabel.text = articleText
        spaceUnderArticle = 25
        
        //var size = articleTextLabel.sizeThatFits(size: CGSize)
        
        articleTextLabel.sizeToFit() //this aligns text to top of label
 
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: articleTextLabel.frame.size.height + (spaceUnderArticle * 4))
        
        //set "all done" text under article
        doneTextLabel.frame.origin.y = articleTextLabel.frame.size.height + spaceUnderArticle
        
        //set button options under "all done" text
        shareButton.frame.origin.y = articleTextLabel.frame.size.height + spaceUnderArticle * 2
        favoriteButton.frame.origin.y = articleTextLabel.frame.size.height + spaceUnderArticle * 2
        nextButton.frame.origin.y = articleTextLabel.frame.size.height + spaceUnderArticle * 2 //"next" or "more"
        
        
        print("share origin y: \(shareButton.frame.origin.y)")
        print("article height: \(articleTextLabel.frame.size.height)")
        
        
        //print("height of article: \(articleTextLabel.frame.height)")
        //scrollView.contentSize = placeholderArticle.image!.size
        //print("length of article: \(size)") //(count(articleText))
        
        
    }

    //NEXT:
    //  as scroll down, save greatest scroll position
    
    
    
    
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
