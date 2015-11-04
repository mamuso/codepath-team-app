//
//  PocketItem.swift
//  codepath-team-app
//
//  Created by mmuno on 10/29/15.
//  Copyright © 2015 angel-magnolia-manuel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PocketItem {
    let id: Int
    let title: String
    let url: String
    let excerpt: String?
    let imgSrc: String?
    let timestamp: Int
    let favorited: Bool
    let wordcount: Int
    let readtime: Int
    
    let BookmarkCountFetchCompleteNotification = "BookmarkCountFetchCompleteNotification"
    
    init(id: Int, title: String, url: String, excerpt: String?, imgSrc: String?, timestamp: Int, favorited: Bool = false, wordcount: Int = 0) {
        self.id = id
        self.title = title
        self.url = url
        self.excerpt = excerpt
        self.imgSrc = imgSrc
        self.timestamp = timestamp
        self.favorited = favorited
        self.wordcount = wordcount
        self.readtime = Int(wordcount / 200)
    }
}