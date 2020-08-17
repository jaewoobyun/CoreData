//
//  EmployeePicture.swift
//  EmployeeDirectory
//
//  Created by 변재우 on 20190201//.
//  Copyright © 2019 Razeware. All rights reserved.
//

import UIKit
import Foundation
import CoreData


public class EmployeePicture: NSManagedObject {

}


extension EmployeePicture {
	@nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeePicture> {
		return NSFetchRequest<EmployeePicture>(entityName: "EmployeePicture")
	}
	
	@NSManaged public var picture: Data?
	@NSManaged public var employee: Employee?
}
