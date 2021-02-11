//
//  User+CoreDataProperties.swift
//  NMCNews(1)
//
//  Created by Yohan on 20/12/20.
//  Copyright © 2020 Harun Fernando. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var userid: Int64

}
