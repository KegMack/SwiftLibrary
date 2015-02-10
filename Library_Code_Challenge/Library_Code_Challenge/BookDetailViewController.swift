//
//  BookDetailViewController.swift
//  Library_Code_Challenge
//
//  Created by User on 2/8/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

protocol BookDetailVCProtocol {
  func libraryWasChanged(library: Library)
}

class BookDetailViewController: ViewController {

  var delegate: BookDetailVCProtocol?
  var dataSource: Library?
  var book = Book()
  var bookIndex = -1
  var shelfIndex = -1
  var bookIsShelved = true
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var pagesLabel: UILabel!
  @IBOutlet weak var titleChangeButton: UIButton!
  @IBOutlet weak var pagesChangeButton: UIButton!
  @IBOutlet weak var authorChangeButton: UIButton!
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var authorTextField: UITextField!
  @IBOutlet weak var pagesTextField: UITextField!
  
  @IBAction func changeTitlePressed() {
    self.book.title = self.titleTextField.text
    self.titleLabel.text = "'\(self.titleTextField.text)'"
    self.addBookAndUpdateLibrary()
    self.titleTextField.text = ""
  }
  
  @IBAction func changeAuthorPressed() {
    self.book.author = self.authorTextField.text
    self.authorLabel.text = "by \(self.authorTextField.text)"
    self.addBookAndUpdateLibrary()
    self.authorTextField.text = ""
  }
  
  @IBAction func changeNumberOfPagesPressed() {
    self.book.numberOfPages = self.pagesTextField.text.toInt()!
    self.pagesLabel.text = "\(self.pagesTextField.text) pages"
    self.addBookAndUpdateLibrary()
    self.pagesTextField.text = ""
  }
  
  @IBAction func createBookPressed() {
    let createBookController: UIAlertController = UIAlertController(title: "Book Creation", message: "This will create a new book with the information currently entered in all the text-boxes on this page.  The book will be placed in the 'unshelved' bin of your local library", preferredStyle: .Alert)
    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in }
    createBookController.addAction(cancelAction)
    let confirmAction: UIAlertAction = UIAlertAction(title: "Confirm", style: .Default) { action -> Void in
      var newTitle = self.titleTextField.text
      var newAuthor = self.authorTextField.text
      var pages = 0
      if let numPages = self.pagesTextField.text.toInt()? {
        pages = numPages
      }
      let newBook = Book(title: newTitle, author: newAuthor, numPages: pages)
      if let aSource = self.dataSource? {
        self.dataSource!.unshelvedBooks.append(newBook)
        self.synchronizeLibrary()
        self.clearAllTextFields()
      }
    }
    createBookController.addAction(confirmAction)
    self.presentViewController(createBookController, animated: true, completion: nil)
  }
  
  @IBAction func reShelfBookPressed(sender: UIBarButtonItem) {
    let reShelfBookController: UIAlertController = UIAlertController(title: "Select Destination Shelf \n Please note shelving or deleting a book will disable editing.  Please locate book on new shelf to edit.", message: nil, preferredStyle: .ActionSheet)
    if let aSource = self.dataSource? {
      for (index, shelf) in enumerate(self.dataSource!.shelves) {
        let reshelfAction = UIAlertAction(title: "Shelf \(index+1)", style: .Default, handler: {(alert:UIAlertAction!) -> Void in
          self.removeBookFromShelf()
          self.dataSource!.shelves[index].addBook(self.book)
          self.synchronizeLibrary()
          sender.enabled = false
          self.disableBookChangingButtons()
        })
        reShelfBookController.addAction(reshelfAction)
      }
      
      let unShelfAction = UIAlertAction(title: "Unshelf", style: .Default, handler: {(alert:UIAlertAction!) -> Void in
        self.removeBookFromShelf()
        self.dataSource!.unshelvedBooks.append(self.book)
        self.synchronizeLibrary()
        sender.enabled = false
        self.disableBookChangingButtons()
      })
      reShelfBookController.addAction(unShelfAction)
      
      let deleteAction = UIAlertAction(title: "Trash Bin (Cannot Undo)", style: .Default, handler: {
        (alert: UIAlertAction!) -> Void in
        self.removeBookFromShelf()
        self.synchronizeLibrary()
        sender.enabled = false
        self.disableBookChangingButtons()
      })
      reShelfBookController.addAction(deleteAction)
    }

    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
      (alert: UIAlertAction!) -> Void in
    })
    reShelfBookController.addAction(cancelAction)
    
    self.presentViewController(reShelfBookController, animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let aSource = self.dataSource? {
      if self.bookIsShelved {
        self.book = self.dataSource!.shelves[self.shelfIndex].books[self.bookIndex]
      }
      else {
        self.book = self.dataSource!.unshelvedBooks[self.bookIndex]
      }
      self.titleLabel.text = "'\(self.book.title)'"
      self.authorLabel.text = "by \(self.book.author)"
      self.pagesLabel.text = "\(self.book.numberOfPages) pages"
    }
  }

  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    // thank you to https://ios8programminginswift.wordpress.com/2014/08/27/dismiss-keyboard/ for this function : )
    self.view.endEditing(true)
  }
  
  
  //// PRIVATE HELPER METHODS --- need to learn how to make them private lol x(
  func disableBookChangingButtons() {
    self.titleChangeButton.enabled = false
    self.authorChangeButton.enabled = false
    self.pagesChangeButton.enabled = false
  }
  
  func removeBookFromShelf(){
    if let aSource = self.dataSource? {
      if self.bookIsShelved {
        self.dataSource!.shelves[self.shelfIndex].removeBook(self.book)
      }
      else {
        self.dataSource!.unshelvedBooks.removeAtIndex(self.bookIndex)
      }
    }
  }
  
  func addBookAndUpdateLibrary() {
    if let aSource = self.dataSource? {
      if self.bookIsShelved {
        self.dataSource!.shelves[self.shelfIndex].books[self.bookIndex] = self.book
      }
      else {
        self.dataSource!.unshelvedBooks[bookIndex] = self.book
      }
      self.synchronizeLibrary()
    }
  }
  
  func synchronizeLibrary() {
    if let aSource = self.dataSource? {
      if let aDelegate = self.delegate? {
        self.delegate!.libraryWasChanged(self.dataSource!)
      }
    }
  }

  func clearAllTextFields() {
    self.titleTextField.text = ""
    self.authorTextField.text = ""
    self.pagesTextField.text = ""
  }
  
}
