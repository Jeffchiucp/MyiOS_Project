//
//  Created by Jeff_Chiu on 1/6/16.
//  Copyright © 2016 Jeff_Chiu. All rights reserved.
//

import UIKit
import CoreData


class NotesListViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  lazy var stack : CoreDataStack = {
    let manager = DataMigrationManager(
      storeNamed: "CloudNotes",
      modelNamed: "CloudNotesDataModel")
    return manager.stack
  }()
  
  lazy var notes : NSFetchedResultsController = {
    let request = NSFetchRequest(entityName: "Note")
    request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
    
    let notes = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.stack.context, sectionNameKeyPath: nil, cacheName: nil)
    notes.delegate = self
    return notes
    }()
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    do {
      try notes.performFetch()
    } catch let error as NSError {
      print("Error fetching data \(error)")
    }
    tableView.reloadData()
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let objects = notes.fetchedObjects
    return objects?.count ?? 0
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let note = notes.fetchedObjects?[indexPath.row] as? Note else { return UITableViewCell() }
    let identifier = note.image == nil ? "NoteCell" : "NoteCellImage"
    
    if let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? NoteTableViewCell {
      cell.note = note
      return cell
    }
    return UITableViewCell()
  }
  
  
  func controllerWillChangeContent(controller: NSFetchedResultsController) {
  }
  
  func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    let indexPathsFromOptionals: (NSIndexPath?) -> [NSIndexPath] = { indexPath in
      if let indexPath = indexPath {
        return [indexPath]
      }
      return []
    }
    
    switch type {
    case .Insert:
      tableView.insertRowsAtIndexPaths(indexPathsFromOptionals(newIndexPath), withRowAnimation: .Automatic)
    case .Delete:
      tableView.deleteRowsAtIndexPaths(indexPathsFromOptionals(indexPath), withRowAnimation: .Automatic)
    default:
      break
    }
  }
  
  func controllerDidChangeContent(controller: NSFetchedResultsController) {
  }
  
  @IBAction
  func unwindToNotesList(segue:UIStoryboardSegue) {
    NSLog("Unwinding to Notes List")
    
    if stack.context.hasChanges {
      do {
        try stack.context.save()
      } catch let error as NSError {
        print("Error saving context: \(error)")
      }
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "createNote" {
      let context = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
      context.parentContext = stack.context
      if let navController = segue.destinationViewController as? UINavigationController {
        if let nextViewController = navController.topViewController as? CreateNoteViewController {
          nextViewController.managedObjectContext = context
        }
      }
    }
    if segue.identifier == "showNoteDetail" {
      if let detailView = segue.destinationViewController as? NoteDetailViewController {
        if let selectedIndex = tableView.indexPathForSelectedRow {
          if let objects = notes.fetchedObjects {
            detailView.note = objects[selectedIndex.row] as? Note
          }
        }
      }
    }
  }
}
