//
//  ShelvesViewController.swift
//  Library_Code_Challenge
//
//  Created by User on 2/7/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

protocol ShelfVCProtocol {
  func libraryWasChanged(library: Library)
}

class ShelvesViewController: ViewController, UITableViewDelegate, BookDetailVCProtocol
{
  var dataSource = [Library]?()
  var chosenLibraryIndex = -1
  var numShelves = 0
  var delegate: ShelfVCProtocol?
  var chosenIndexPath = NSIndexPath()
  @IBOutlet weak var shelfTableView: UITableView!
  
  func libraryWasChanged(library: Library) {
    if let aSource = self.dataSource? {
      self.dataSource![self.chosenLibraryIndex] = library
    }
    if let aDelegate = self.delegate? {
      self.delegate!.libraryWasChanged(self.dataSource![self.chosenLibraryIndex])
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let aSource = self.dataSource {
      self.navigationItem.title = self.dataSource![self.chosenLibraryIndex].name
      self.numShelves = self.dataSource![self.chosenLibraryIndex].shelves.count
    }
  }
  
  override func viewDidAppear(animated: Bool) {
    self.shelfTableView.reloadData()
  }
  
  @IBAction func addShelfPressed(sender: UIBarButtonItem) {
    
    //this function was adapted from http://swiftoverload.com/uialertcontroller-swift-example/  Thanks!
    
    //var userInputField = UITextField()
    let addShelfController: UIAlertController = UIAlertController(title: "Add New Shelf", message: "Confirm New Shelf?", preferredStyle: .Alert)
    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
    }
    addShelfController.addAction(cancelAction)
    let enterAction: UIAlertAction = UIAlertAction(title: "Yes", style: .Default) { action -> Void in
      var newShelf = Shelf()
      if let aSource = self.dataSource? {
        self.dataSource![self.chosenLibraryIndex].shelves.append(newShelf)
        self.numShelves++
        if let aDelegate = self.delegate? {
          self.delegate!.libraryWasChanged(self.dataSource![self.chosenLibraryIndex])
        }
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          self.shelfTableView.reloadData()
        })
      }
    }
    addShelfController.addAction(enterAction)
    self.presentViewController(addShelfController, animated: true, completion: nil)
  }
  
  func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
   // println("num sections: \(dataSource!.shelves.count)")
    if let aSource = self.dataSource? {
      return dataSource![self.chosenLibraryIndex].shelves.count + 1
    }
    return 0
  }
  
  func tableView( tableView : UITableView,  titleForHeaderInSection section: Int)->String {
   // println("title for section: \(section)")
    if section < self.numShelves  {
      return "Shelf #\(section+1)"
    }
    else  {
      return "Checked Out"
    }
    
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //println("num rows: \(dataSource!.shelves[section].books.count)")
    if let aSource = self.dataSource? {
      if section < self.numShelves {
        return dataSource![self.chosenLibraryIndex].shelves[section].books.count
      }
      else {
      return dataSource![self.chosenLibraryIndex].unshelvedBooks.count
      }
    }
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var bookCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "bookCell")
    bookCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
    if let aSource = self.dataSource? {
      if indexPath.section < self.numShelves {
        bookCell.textLabel!.text = self.dataSource![self.chosenLibraryIndex].shelves[indexPath.section].books[indexPath.row].title
        bookCell.detailTextLabel!.text = "by \(self.dataSource![self.chosenLibraryIndex].shelves[indexPath.section].books[indexPath.row].author)"
      }
      else {
        bookCell.textLabel!.text = self.dataSource![self.chosenLibraryIndex].unshelvedBooks[indexPath.row].title
        bookCell.detailTextLabel!.text = "by \(self.dataSource![self.chosenLibraryIndex].unshelvedBooks[indexPath.row].author)"
      }
    }
    return bookCell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.chosenIndexPath = indexPath
    self.performSegueWithIdentifier("bookDetailSegue", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "bookDetailSegue" {
      if let nextVC = segue.destinationViewController as? BookDetailViewController {
        nextVC.delegate = self
        if let aSource = self.dataSource? {
          nextVC.dataSource = self.dataSource![self.chosenLibraryIndex]
        }
        nextVC.bookIsShelved = !(self.numShelves == self.chosenIndexPath.section)
        nextVC.bookIndex = self.chosenIndexPath.row
        nextVC.shelfIndex = self.chosenIndexPath.section
      }
    }
  }
  
  

}
