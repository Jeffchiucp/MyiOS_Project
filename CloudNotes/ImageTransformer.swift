//
//  Created by Jeff_Chiu on 1/6/16.
//  Copyright © 2016 Jeff_Chiu. All rights reserved.
//
import Foundation
import UIKit

class ImageTransformer : NSValueTransformer {
  
  override class func transformedValueClass() -> AnyClass {
    return NSData.self
  }
  
  override class func allowsReverseTransformation() -> Bool {
    return true
  }
  
  override func reverseTransformedValue(value: AnyObject?) -> AnyObject? {
    if let data = value as? NSData {
      return UIImage(data: data)
    }
    return nil
  }
  
  override func transformedValue(value: AnyObject?) -> AnyObject? {
    if let image = value as? UIImage {
      return UIImagePNGRepresentation(image)
    }
    return nil
  }
  
}
