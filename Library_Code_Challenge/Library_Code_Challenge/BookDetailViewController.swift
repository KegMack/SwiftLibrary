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
    let createBookController: UIAlertController = UIAlertController(title: "Book Creation", message: "This will create a new book with the information currently entered in all the text-boxes on this page.  The book will be placed in the 'checkout' bin of your local library", preferredStyle: .Alert)
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
    self.view.endEditing(true)
    
    // thank you to https://ios8programminginswift.wordpress.com/2014/08/27/dismiss-keyboard/ for this function : )
  }
  
  
  
  
  //// PRIVATE HELPER METHODS --- need to learn how to make private x(
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
