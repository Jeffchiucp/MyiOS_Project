//
//  Created by Jeff_Chiu on 1/6/16.
//  Copyright © 2016 Jeff_Chiu. All rights reserved.
//


import UIKit
import CoreData

class AttachPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  var note : Note?
  lazy var imagePicker : UIImagePickerController = {
    let picker = UIImagePickerController()
    picker.sourceType = .PhotoLibrary
    picker.delegate = self
    self.addChildViewController(picker)
    return picker
    }()
  
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(imagePicker.view)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    imagePicker.view.frame = view.bounds
  }
  
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
    if let note = note,
      let attachment = NSEntityDescription.insertNewObjectForEntityForName(
        "ImageAttachment", inManagedObjectContext: note.managedObjectContext!)
        as? ImageAttachment {
          
        attachment.dateCreated = NSDate()
        attachment.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        attachment.note = note
    }
    self.navigationController?.popViewControllerAnimated(true)
  }
}
