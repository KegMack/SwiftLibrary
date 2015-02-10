//
//  ViewController.swift
//  Library_Code_Challenge
//
//  Created by User on 2/5/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var shouldCreateDemo = true
  @IBOutlet weak var createDemoStateIndicator: UILabel!
  
  @IBAction func createDemoSwitch(sender: UISwitch) {
    self.shouldCreateDemo = sender.on
    if(self.shouldCreateDemo) {
      self.createDemoStateIndicator.text = "Create Demo: ON"
    }
    else {
      self.createDemoStateIndicator.text = "Create Demo: OFF"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "homeToLibrariesSegue" && shouldCreateDemo {
      if let nextVC = segue.destinationViewController as? LibraryViewController {
          nextVC.createDemo()
      }
    }
  }

}

