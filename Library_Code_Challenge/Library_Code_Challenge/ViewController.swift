//
//  ViewController.swift
//  Library_Code_Challenge
//
//  Created by User on 2/5/15.
//  Copyright (c) 2015 Craig_Chaillie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var shouldCreateDemo = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    shouldCreateDemo = false
    // Do any additional setup after loading the view, typically from a nib.
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func createDemoPressed(sender: UIButton) {
    shouldCreateDemo = true
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "homeToLibrariesSegue" && shouldCreateDemo {
      if let nextVC = segue.destinationViewController as? LibraryViewController {
        nextVC.createDemo()
      }
    }
  }

}

