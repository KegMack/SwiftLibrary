//
//  Library.swift
//  Library_Code_Challenge
//
//  Created by User on 2/6/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import Foundation


class Book: Equatable
{
  var title = "Unknown"
  var author = "Unknown"
  var numberOfPages:Int = 0
  
  init(title : String?, author : String?, numPages: Int?) {
    if let aTitle = title {
      self.title = title!
    }
    if let AnAuthor = author {
      self.author = author!
    }
    if let anyPages = numPages {
      self.numberOfPages = numPages!
    }
  }
  
  init(){
  }
  
  func enshelf(shelf: Shelf?){
    if let aShelf = shelf {
      shelf!.addBook(self)
    }
  }
  
  func deshelf(shelf: Shelf?){
    if let aShelf = shelf {
      shelf!.removeBook(self)
    }

  }
  
  func printInfo() {
    println("Title: \(self.title) \n Author: \(self.author) \n Pages: \(self.numberOfPages)")
  }
  
}

///////////////  equatable protocol //////////////
func ==(first: Book, second: Book) -> Bool  {
  return first.title == second.title &&
    first.author == second.author &&
    first.numberOfPages == second.numberOfPages
}
//////////////////////////////////////////////////

class Shelf
{
  var books = [Book]()
  
  func addBook(book: Book?){
    if let aBook = book {
      self.books.append(book!)
    }
  }
  
  func removeBook(book: Book?) -> Bool {
    if let aBook = book {
      if let index = find(self.books, book!) {
        self.books.removeAtIndex(index)
        return true
      }
    }
    return false
  }
  
  func removeMultipleBooks(book: Book?){    //removes all instances of specified book from shelf
    if let aBook = book {
      self.books = self.books.filter{$0 != book!}
    }
  }
  
  func printShelf(){
    for book in self.books {
      println("book title: \(book.title)")
    }
  }
}

class Library
{
  var shelves = [Shelf]()
  var unshelvedBooks = [Book]()
  var name = ""
  
  func addShelf(shelf: Shelf?) {
    if let aShelf = shelf {
      self.shelves.append(shelf!)
    }
  }
  
  func inventoryReport() {
    for shelf in self.shelves {
      shelf.printShelf()
    }
  }
  
  init(name: String?) {
    if let aName = name {
      self.name = name!
    }
  }
  func printUnshelved() {
    for book in self.unshelvedBooks {
      println("\(book.title)")
    }
  }
}

