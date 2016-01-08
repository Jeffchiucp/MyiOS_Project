//
//  Created by Jeff_Chiu on 1/6/16.
//  Copyright © 2016 Jeff_Chiu. All rights reserved.
//


import UIKit
import CoreData

class CreateNoteViewController : UIViewController, UITextFieldDelegate, UITextViewDelegate {
  var managedObjectContext : NSManagedObjectContext?
  lazy var note: Note? = {
    if let context = self.managedObjectContext {
      return NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext: context) as? Note
    }
    return .None
    }()
  
  @IBOutlet var titleField : UITextField!
  @IBOutlet var bodyField : UITextView!
  @IBOutlet var attachPhotoButton : UIButton!
  @IBOutlet var attachedPhoto : UIImageView!
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    if let image = note?.image {
      attachedPhoto.image = image
      view.endEditing(true)
    } else {
      titleField.becomeFirstResponder()
    }
  }
  
  
  @IBAction func saveNote() {
      note?.title = titleField.text
      note?.body = bodyField.text
      
      if let managedObjectContext = managedObjectContext {
      do {
      try  managedObjectContext.save()
    }
      catch let error as NSError {
    print("Error saving \(error)", terminator: "")
      }
      }
      performSegueWithIdentifier("unwindToNotesList", sender: self)
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
        saveNote()
        textField.resignFirstResponder()
        return false
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "AttachPhoto" {
    if let nextViewController = segue.destinationViewController as? AttachPhotoViewController {
    nextViewController.note = note
    }
        }
  }
}
