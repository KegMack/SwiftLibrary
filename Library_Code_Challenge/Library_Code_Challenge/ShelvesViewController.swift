//
//  ShelvesViewController.swift
//  Library_Code_Challenge
//
//  Created by User on 2/7/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class ShelvesViewController: ViewController, UITableViewDelegate
{
  var dataSource: Library? = nil
  
  @IBOutlet weak var navItem: UINavigationItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let aSource = dataSource {
      self.navItem.title = aSource.name
    }
  }
  
  func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
   // println("num sections: \(dataSource!.shelves.count)")
    return dataSource!.shelves.count
  }
  
  func tableView( tableView : UITableView,  titleForHeaderInSection section: Int)->String {
   // println("title for section: \(section)")
    return "Shelf #\(section+1)"
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //println("num rows: \(dataSource!.shelves[section].books.count)")
    return dataSource!.shelves[section].books.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var bookCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "bookCell")
    bookCell.textLabel!.text = self.dataSource!.shelves[indexPath.section].books[indexPath.row].title
    bookCell.detailTextLabel!.text = "by \(self.dataSource!.shelves[indexPath.section].books[indexPath.row].author)"
    return bookCell
  }
  
  /*func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.chosenLibrary = self.libraries[indexPath.row]
    self.performSegueWithIdentifier("shelvesSegue", sender: self)
  }*/
  
/*  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "shelvesSegue" {
      if let nextVC = segue.destinationViewController as? ShelvesViewController {
        nextVC.dataSource = self.chosenLibrary
      }
    }
  }*/

  
}
