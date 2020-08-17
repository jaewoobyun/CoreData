//
//  ImageAttachment.swift
//  UnCloudNotes
//
//  Created by 변재우 on 20190129//.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ImageAttachment: Attachment {
	@NSManaged var image: UIImage?
	@NSManaged var width: Float
	@NSManaged var height: Float
	@NSManaged var caption: String
}
