//
//  ViewController.swift
//  TenTenRobot
//
//  Created by Motomi Ota on 2019/09/18.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import UIKit

class MainController: UIViewController {
  
  let PRINT_TENTEN_BEGIN = 50
  let MAIN_BEGIN = 0
  
  @IBOutlet weak var outputView: UITextView!
  
  let computer  = Computer(capacity: 100)

  override func viewDidLoad() {
    super.viewDidLoad()
    outputView.layer.borderColor = UIColor.black.cgColor
    outputView.layer.borderWidth = 1
    outputView.layer.cornerRadius = 5
  }


  @IBAction func execute(_ sender: Any) {
    if computer.set_address(addr: PRINT_TENTEN_BEGIN){
      computer.insert(.multi)
      computer.insert(.print)
      computer.insert(.ret)
    }
    if computer.set_address(addr: MAIN_BEGIN){
      computer.insert(.push(1009))
      computer.insert(.print)
      computer.insert(.push(6))
      computer.insert(.push(101))
      computer.insert(.push(10))
      computer.insert(.call(PRINT_TENTEN_BEGIN))
      computer.insert(.stop)
    }
    if computer.set_address(addr: MAIN_BEGIN){
      let output = computer.execute()
      outputView.text = output.joined(separator: "\n")
    }
  }
}

