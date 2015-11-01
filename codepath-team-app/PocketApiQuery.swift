//
//  PocketApiQuery.swift
//  codepath-team-app
//
//  Created by mmuno on 10/29/15.
//  Copyright © 2015 angel-magnolia-manuel. All rights reserved.
//

import Foundation
import PocketAPI
import Keys
import Alamofire
import SwiftyJSON


class PocketApiQuery {

    let apiBaseUrl = "https://getpocket.com/v3/"
    let accessToken = PocketAPI.sharedAPI().pkt_getToken
    let consumerKey = CodepathKeys().pocketSdkConsumerKey()
    let itemCountPerPage = 50
    let dummyItem = PocketItem(id: 0, title: "", url: "", excerpt: nil, imgSrc: nil, timestamp: 0)
    
    let PAAFetchCompleteNotification = "PAAFetchCompleteNotification"
    let PAAArchiveStartNotification = "PAAArchiveStartNotification"
    let PAAArchiveCompletionNotification = "PAAArchiveCompletionNotification"
    
    var items = [PocketItem]()
    var fetching = false
    var fetchingFullList = false
    var totalItemCount = 0
    var lastFetchTime: Double = 0.0
    
    init() {}

    func fetchData(refresh refresh: Bool = false) {
        if fetching { return }
        
        let methodUrl = apiBaseUrl + "get"
        var requestParams: Dictionary = [
            "consumer_key": consumerKey,
            "access_token": accessToken,
            "detailType": "complete",
            "state": "unread"
        ]
        if refresh {
            requestParams["since"] = String(lastFetchTime)
        } else {
            requestParams["offset"] = String(totalItemCount)
            requestParams["count"] = String(itemCountPerPage)
        }
        
        fetching = true
        
        
        Alamofire.request(.GET, methodUrl, parameters: requestParams).response { (request, response, data, error) in
            if error != nil {
                var message = "An unknown error has occurred."
                if let error = error as NSError! {
                    message = error.localizedDescription
                }

                self.fetching = false
                NSNotificationCenter.defaultCenter().postNotificationName(self.PAAFetchCompleteNotification,
                    object: nil,
                    userInfo: ["error": message]
                )
                return
            }
            
            var json = JSON.null
            if data == nil {
                self.fetching = false
                return
            }
            json = JSON(data: data!)
            
            
            var fetchListLength = json["list"].count
            var fetchedItems: [PocketItem] = [PocketItem](count: fetchListLength, repeatedValue: self.dummyItem)
            for (_, elem) in json["list"] {
                let idStr = elem["item_id"].string
                var title = elem["resolved_title"].string
                if title == nil || title!.isEmpty {
                    title = elem["given_title"].string
                }
                var url = elem["resolved_url"].string
                if url == nil || url!.isEmpty {
                    url = elem["given_url"].string
                }
                let excerpt = elem["excerpt"].string
                let imgSrc = elem["image"]["src"].string
                let timestampStr = elem["time_added"].string
                let sortId = elem["sort_id"].int
                let favorited = Int(elem["favorite"].string!) == 1
                
                // TODO: angel, add api attribute extraction and conversion to PocketItem attributes here
                let item = PocketItem(id: Int(idStr!)!, title: title!, url: url!, excerpt: excerpt, imgSrc: imgSrc, timestamp: Int(timestampStr!)!, favorited: favorited)
                fetchedItems[sortId!] = item
            }
            if refresh {
                fetchedItems += self.items
                self.items = fetchedItems
            } else {
                self.items += fetchedItems
            }

            self.items = self.filterUniqueItems(self.items)

            fetchListLength = self.items.count - self.totalItemCount
            
            
            self.totalItemCount = self.items.count
            
            self.lastFetchTime = NSDate().timeIntervalSince1970
            
            if !refresh && fetchListLength < 1 {
                self.fetchingFullList = true
            }
            
            self.fetching = false
            NSNotificationCenter.defaultCenter().postNotificationName(self.PAAFetchCompleteNotification,
                object: nil,
                userInfo: ["newFetchedCount": fetchListLength]
            )
        }
    }
    
    func filterUniqueItems(items: [PocketItem]) -> [PocketItem] {
        var alreadyFetchedItemIds = [Int]()
        var uniqueItems = [PocketItem]()
        for item in items {
            if !alreadyFetchedItemIds.contains(item.id) {
                uniqueItems.append(item)
                alreadyFetchedItemIds.append(item.id)
            }
        }
        return uniqueItems
    }
    
    func archiveItemAtIndex(index: Int, itemId: Int) {
        NSNotificationCenter.defaultCenter().postNotificationName(PAAArchiveStartNotification,
            object: nil,
            userInfo: ["archivedItemIndex": index]
        )
        
        let methodUrl = apiBaseUrl + "send"
        var requestParams: Dictionary = [
            "consumer_key": consumerKey,
            "access_token": accessToken
        ]
        let json = JSON(["action": "archive", "item_id": itemId])
        requestParams["actions"] = String([json])
        
        Alamofire.request(.GET, methodUrl, parameters: requestParams).response {
            request, response, data, error in
            if error != nil {
                var message = "An unknown error has occurred."
                if let error = error as NSError! {
                    message = error.localizedDescription
                }
                NSNotificationCenter.defaultCenter().postNotificationName(self.PAAArchiveCompletionNotification,
                    object: nil,
                    userInfo: ["error": message]
                )
                return
            }
        }
    }}