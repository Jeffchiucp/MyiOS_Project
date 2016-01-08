//
//  Created by Jeff_Chiu on 1/6/16.
//  Copyright © 2016 Jeff_Chiu. All rights reserved.
//

import UIKit


class NoteTableViewCell: UITableViewCell {
  var note : Note? {
    didSet {
      updateNoteInfo()
    }
  }
  
  @IBOutlet var noteTitle : UILabel!
  @IBOutlet var noteCreateDate : UILabel!
  @IBOutlet var noteImage: UIImageView!
  
  func updateNoteInfo() {
    if let note = note {
      noteTitle.text = String(note.title)
      noteCreateDate.text = note.dateCreated.description
    }
    if let image = note?.image {
      noteImage.image = image
    }
  }
  
}
