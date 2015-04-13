
//  Config.swift
//  OldSummerFilm
//
//  Created by xianingzhong on 15/4/12.
//  Copyright (c) 2015年 xianingzhong. All rights reserved.
//

import UIKit

class Config: NSObject {
   
    //所有数据来源于好服务数据平台免费每天50次调用
    
    //旅游资讯接口
    let travelInformationKey = "1981e2863a1044afa2f19820eef33952"//旅游资讯的Key
    
    let cityList = "http://apis.haoservice.com/lifeservice/travel/cityList?key="//城市列表
    let travelList = "http://apis.haoservice.com/lifeservice/travel/scenery?key="//景点列表    
    let travelDetail = "http://apis.haoservice.com/lifeservice/travel/GetScenery?key="//景点详情
    
    //保存当前城市
    func saveCurrentCity(cityName:String, cityId:String, proviceId:String){
        
        NSUserDefaults.standardUserDefaults().setObject(cityName, forKey: "cityName")
        NSUserDefaults.standardUserDefaults().setObject(cityId, forKey: "cityId")
        NSUserDefaults.standardUserDefaults().setObject(proviceId, forKey: "provinceId")
    }
    //获取当前城市
    func getCurrentCityName()->String{
    
        return NSUserDefaults.standardUserDefaults().valueForKey("cityName") as! String
    }
    //获取当前城市Id
    func getCurrentCityId()->String{
        
        return NSUserDefaults.standardUserDefaults().valueForKey("cityId") as! String
    }
    //获取当前省份Id
    func getCurrentProviceId()->String{
        
        return NSUserDefaults.standardUserDefaults().valueForKey("provinceId") as! String
    }
    
    
    //实现单利
    class func shareInstance()->Config {
        struct Singleton{
            static var predicate:dispatch_once_t = 0
            static var instance:Config? = nil
        }
        dispatch_once(&Singleton.predicate, { () -> Void in
            Singleton.instance = Config()
        })
        
        return Singleton.instance!
    }
    
}
