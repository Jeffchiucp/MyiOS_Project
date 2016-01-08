//
//  Created by Jeff_Chiu on 1/6/16.
//  Copyright © 2016 Jeff_Chiu. All rights reserved.
//


import UIKit
import CoreData
class ImageAttachment: Attachment {
  @NSManaged var image: UIImage?
  @NSManaged var width: CGFloat
  @NSManaged var height: CGFloat
  @NSManaged var caption: String
}


