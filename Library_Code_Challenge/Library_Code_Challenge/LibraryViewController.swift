//
//  LibraryViewController.swift
//  Library_Code_Challenge
//
//  Created by User on 2/7/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController, UITableViewDelegate
{
  var libraries = [Library]()
  var chosenLibrary: Library? = nil

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.libraries.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var libraryCell = UITableViewCell()
    libraryCell.textLabel?.text = self.libraries[indexPath.row].name
    return libraryCell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.chosenLibrary = self.libraries[indexPath.row]
    self.performSegueWithIdentifier("shelvesSegue", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "shelvesSegue" {
      if let nextVC = segue.destinationViewController as? ShelvesViewController {
          nextVC.dataSource = self.chosenLibrary
      }
    }
  }
  
  func createDemo() {
    self.libraries.removeAll()
    var shelf10 = Shelf()
    var shelf11 = Shelf()
    var shelf12 = Shelf()
    var shelf20 = Shelf()
    var shelf21 = Shelf()
    
    let kidsBook = Book(title: "Kitty Cats", author: "Dr. Poo", numPages: 25)
    kidsBook.enshelf(shelf10)
    let kidsBook2 = Book(title: "Gibberish", author: "Badkalkewakl", numPages: 244)
    kidsBook2.enshelf(shelf10)
    let book1 = Book(title: "Serious Book", author: "Mr. StickUpMyAss", numPages: 1243)
    book1.enshelf(shelf11)
    let book2 = Book(title: "Funny Jokes", author: "I.P. Freely", numPages: 65)
    book2.enshelf(shelf11)
    let book3 = Book(title: "Fierce Invalids Home From Hot Climates", author: "Tom Robbins", numPages: 250)
    book3.enshelf(shelf11)
    let book4 = Book(title: "Beastie Boys Kick Ass", author: "Me", numPages: 111)
    book4.enshelf(shelf11)
    let book5 = Book(title: "An Illustrated Introduction to Recreational Gynecology", author: "Your Mom", numPages: 69)
    book5.enshelf(shelf11)
    let book6 = Book(title: "Underwater Basket-weaving", author: "Santiago Dominguez", numPages: 325)
    book6.enshelf(shelf11)
    let book7 = Book(title: "The Fellowship of the Ring", author: "J.R. Tolkein", numPages: 500)
    book7.enshelf(shelf12)
    let book8 = Book(title: "The Two Towers", author: "J.R. Tolkein", numPages: 326)
    book8.enshelf(shelf12)
    let book9 = Book(title: "The Return of the King", author: "J.R. Tolkein", numPages: 390)
    book9.enshelf(shelf12)
    let book10 = Book(title: "The Silmarillion", author: "J.R. Tolkein", numPages: 722)
    book10.enshelf(shelf12)
    let book11 = Book(title: "Jitterbug Perfume", author: "Tom Robbins", numPages: 311)
    book11.enshelf(shelf11)
    let book12 = Book(title: "Sappy Romance Novel", author: "Madame Lamesauce", numPages: 726)
    book12.enshelf(shelf20)
    let book13 = Book(title: "Mmmmmm, McDonald's....", author: "Fatty McLardass", numPages: 222)
    book13.enshelf(shelf20)
    let book14 = Book(title: "The Giving Tree", author: "Shel Silverstein", numPages: 53)
    book14.enshelf(shelf20)
    let book15 = Book(title: "The Art of Flatulence", author: "Anonymous", numPages: 79)
    book15.enshelf(shelf21)
    let book16 = Book(title: "The Laughing Magpie", author: "Gioachino Rossini", numPages: 211)
    book16.enshelf(shelf21)
    let book17 = Book(title: "It's Hard to Think up Lots of Book Names", author: "Me", numPages: 2)
    book17.enshelf(shelf21)
    let book18 = Book(title: "Two More Should Do It", author: "Me", numPages: 23)
    book18.enshelf(shelf21)
    let book19 = Book(title: "Harry Potter and the Magical Thing", author: "J.K. Rowling", numPages: 631)
    book19.enshelf(shelf21)
    let book20 = Book(title: "Harry Potter and Another Magical Thing", author: "J.K. Rowling", numPages: 826)
    book20.enshelf(shelf21)
    let book21 = Book(title: "Harry Potter and Another Magical Thing: Part 2", author: "J.K. Rowling", numPages: 1238)
    
    var demoLibrary1 = Library(name:"West-Siiiiide Branch")
    demoLibrary1.addShelf(shelf10)
    demoLibrary1.addShelf(shelf11)
    demoLibrary1.addShelf(shelf12)
    
    var demoLibrary2 = Library(name:"Reeding iz Gud Branch")
    demoLibrary2.addShelf(shelf20)
    demoLibrary2.addShelf(shelf21)
    demoLibrary2.unshelvedBooks.append(book21)
    
    self.libraries.append(demoLibrary1)
    self.libraries.append(demoLibrary2)
  }
  
  
  
}
