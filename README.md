#MyiOS_Project

Build and run the app in the iPhone simulator. Note apps will create an empty list of notes:


Tap the plus (+) button in the top-right corner to add a new note. Add a title (there is default text in the note body to make the process faster) and tap Create to save the new note to the data store. Repeat this a few times so that you have some sample data to migrate.

Added Feature:

the ability to attach a photo to a note. The data model doesn’t have any place to persist this kind of information, See the data model to hold onto the photo. 


See the Model Mappying in CloudNotesDataModel.xcdatamodeld

As an application collects more and more mapping models over time, this file 
naming convention makes it easier to distinguish between files and the order in which they have changed over time.
Xcode examines the source and target models and infers as much as it can

There are two mappings, one named NoteToNote and another simply named Attachment. 
NoteToNote describes how to migrate the v2 Note entity to the v3 Note entity.