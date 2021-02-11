//
//  News+CoreDataProperties.swift
//  NMCNews(1)
//
//  Created by Yohan on 20/12/20.
//  Copyright © 2020 Harun Fernando. All rights reserved.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var desc: String?
    @NSManaged public var image: NSData?
    @NSManaged public var newsid: Int64
    @NSManaged public var title: String?
    @NSManaged public var userid: Int64

}
