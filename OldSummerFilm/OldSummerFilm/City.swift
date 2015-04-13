//
//  City.swift
//  OldSummerFilm
//
//  Created by xianingzhong on 15/4/12.
//  Copyright (c) 2015年 xianingzhong. All rights reserved.
//

import Foundation
import CoreData

class City: NSManagedObject {

    @NSManaged var cityName: String
    @NSManaged var cityId: String
    @NSManaged var provinceId: String

}
