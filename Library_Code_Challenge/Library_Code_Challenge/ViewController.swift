//
//  ViewController.swift
//  Library_Code_Challenge
//
//  Created by User on 2/5/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func testButtonPressed() {
    let book = Book(title: "Gato", author: "Yo Mama", numPages: 1111)
    let book2 = Book()
    book.printInfo()
    book2.printInfo()
    var shelf = Shelf()
    shelf.addBook(book)
    shelf.addBook(book2)
    shelf.printShelf()
    book2.deshelf(shelf)
    shelf.printShelf()
  }

}

