//
//  Attachment.swift
//  UnCloudNotes
//
//  Created by 변재우 on 20190128//.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Attachment: NSManagedObject {
	@NSManaged var dateCreated: Date
//	@NSManaged var image: UIImage?
	@NSManaged var note: Note?
}
