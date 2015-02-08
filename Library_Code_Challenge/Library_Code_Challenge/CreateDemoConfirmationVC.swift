//
//  CreateDemoConfirmationVC.swift
//  Library_Code_Challenge
//
//  Created by User on 2/7/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class CreateDemoConfirmationViewController: UIViewController
{
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func goPressed(sender: UIButton) {
    self.performSegueWithIdentifier("createDemoSegue", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "createDemoSegue" {
      if let nextVC = segue.destinationViewController as? LibraryViewController {
        nextVC.createDemo()
      }
    }
  }
  
}