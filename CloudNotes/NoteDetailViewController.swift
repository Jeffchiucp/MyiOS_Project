//
//  Created by Jeff_Chiu on 1/6/16.
//  Copyright © 2016 Jeff_Chiu. All rights reserved.
//
import UIKit

class NoteDetailViewController: UIViewController {
  var note : Note? {
    didSet {
      updateNoteInfo()
    }
  }
  
  @IBOutlet var titleField : UILabel!
  @IBOutlet var bodyField : UITextView!
  
  func updateNoteInfo() {
    if isViewLoaded(), let note = note {
      titleField.text = String(note.title)
      bodyField.text = String(note.body)
    }
  }
  
    
  override func viewWillAppear(animated: Bool) {
    updateNoteInfo()
  }
  
}
