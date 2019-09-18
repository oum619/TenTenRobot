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

  override func viewDidLoad() {
    super.viewDidLoad()
    outputView.layer.borderColor = UIColor.black.cgColor
    outputView.layer.borderWidth = 1
    outputView.layer.cornerRadius = 5
  }


  @IBAction func execute(_ sender: Any) {
    let computer = Computer(capacity: 100)
    do{
      if computer.set_address(addr: PRINT_TENTEN_BEGIN){
        try computer.insert(.multi)
        try computer.insert(.print)
        try computer.insert(.ret)
      }
      if computer.set_address(addr: MAIN_BEGIN){
        try computer.insert(.push(1009))
        try computer.insert(.print)
        try computer.insert(.push(6))
        try computer.insert(.push(101))
        try computer.insert(.push(10))
        try computer.insert(.call(PRINT_TENTEN_BEGIN))
        try computer.insert(.stop)
      }
      if computer.set_address(addr: MAIN_BEGIN){
        let output = computer.execute()
        outputView.text = output.joined(separator: "\n")
      }
    }catch ProgramError.runtimeError(let msg) {
      outputView.text = msg
    }
    catch{
      outputView.text = "Unexpected error occurred"
    }
  }
}

