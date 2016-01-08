//
//  Created by Jeff_Chiu on 1/6/16.
//  Copyright © 2016 Jeff_Chiu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Note : NSManagedObject {
  @NSManaged var title : NSString!
  @NSManaged var body : NSString!
  @NSManaged var dateCreated: NSDate!
  @NSManaged var displayIndex: NSNumber!
  @NSManaged var attachments: NSSet
  
  override func awakeFromInsert() {
    super.awakeFromInsert()
    dateCreated = NSDate()
  }
  
  var image : UIImage? {
    return latestAttachment?.image
  }
  
  var latestAttachment: ImageAttachment? {
    let sortedAttachments = attachments.flatMap { $0 as? ImageAttachment }.sort {
      $0.0.dateCreated.compare($0.1.dateCreated) == .OrderedAscending
    }
    return sortedAttachments.first
  }
}