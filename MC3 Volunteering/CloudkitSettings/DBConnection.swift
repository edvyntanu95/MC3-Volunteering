//
//  DBConnection.swift
//  MC3 Volunteering
//
//  Created by Pramahadi Tama Putra on 27/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class DBConnection{
    static let share = DBConnection()
    
    var container:CKContainer!
    var publicDB:CKDatabase!
    
    private init(){
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
    }
}
