//
//  RequestManager.swift
//  OldSummerFilm
//
//  Created by xianingzhong on 15/4/12.
//  Copyright (c) 2015年 xianingzhong. All rights reserved.
//

import UIKit

class RequestManager: NSObject {
   
    var queue = NSOperationQueue()
    
    //实现单利
    class func shareInstance()->RequestManager {
        struct Singleton{
            static var predicate:dispatch_once_t = 0
            static var instance:RequestManager? = nil
        }
        dispatch_once(&Singleton.predicate, { () -> Void in
            Singleton.instance = RequestManager()
        })
        
        return Singleton.instance!
    }
    
    //获取网络数据 回调
    func httpRequest(urlString:String, completionHandler:(data:AnyObject)->Void){
        
        var url:NSURL = NSURL(string: urlString)!
        var req = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { (response, data, error) -> Void in

            if (error != nil)
            {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    completionHandler(data: NSNull())
                })
            }
            else
            {
                let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    completionHandler(data:jsonData)
                })
            }
        })
    }
    
}
