//
//  Item.swift
//  planner
//
//  Created by ر on ١٧ جما١، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ ر. All rights reserved.
//

import Foundation
import RealmSwift
class Item: Object {
   @objc dynamic var title:String = ""
   @objc dynamic var done:Bool = false
    @objc dynamic var datecreated : Date?
    var parentcategory = LinkingObjects(fromType: Category.self, property: "item")
}
