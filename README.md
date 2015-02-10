# SwiftLibrary
The object model is called Library.swift

On the title screen, the user can choose to create a demo library so they can move around and edit books without having to create everything.

On the Library list, the user can browse through all libraries, as well as create them.

On the Shelf list, all books in the chosen library are shown, organized by shelf.  The user can create shelves from here.

On the Book detail view, the user can edit the properties of the book, create a new book, reshelf the book, or delete the book.  Once a book is moved or deleted, the button which modify the book are disabled. However, the user can still create new books from the screen.

All pertinent data is sent across view controllers, so any changes made to a book or its position can be accessed immediately upon entering the corresponding view.

Additionally all VCs are generic in that the children do not directly communicate with their parents.  Data is shared through delegation and protocols.

The only feature I wanted to implement but did not is to intercept the back button from the libraries screen.  Data is persistent throught the app, but will disappear if the user goes back to the title screen, as the title screen VC does not use a model.

This was my first program in Swift, so no doubt there are several uses of the language that I did not take advantage of. I'm looking forward to practicing this a bit more and do some real Hegarty stuff!
