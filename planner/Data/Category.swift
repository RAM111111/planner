//
//  Category.swift
//  planner
//
//  Created by ر on ١٧ جما١، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ ر. All rights reserved.
//

import Foundation
import RealmSwift
class Category: Object {
    @objc dynamic var name:String = ""
    let item = List<Item>()
}
