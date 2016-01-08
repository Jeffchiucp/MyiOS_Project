//
//  Created by Jeff_Chiu on 1/6/16.
//  Copyright © 2016 Jeff_Chiu. All rights reserved.
//


import Foundation
import UIKit
import CoreData

class Attachment : NSManagedObject {
  @NSManaged var dateCreated: NSDate
  @NSManaged var note: Note
}