//
//  Computer.swift
//  TenTenRobot
//
//  Created by Motomi Ota on 2019/09/18.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import Foundation

enum Program {
  case multi, ret, stop, print
  case push(Int)
  case call(Int)
}

class Computer{
  var address = 0
  var programs : [Program?]
  var arguments : [Int] = []
  
  init(capacity:Int) {
    programs = Array<Program?>(repeating: nil, count: capacity)
  }
  
  func set_address(addr:Int) {
    address = addr
  }
  
  func insert(_ program:Program){
    programs.insert(program, at: address)
    address+=1    
  }
  
  func execute() {
    while address<programs.count {
      if let program = programs[address]{
        switch program{
        case .multi:
          if let arg1 = arguments.popLast(), let arg2 = arguments.popLast(){
            arguments.append(arg1*arg2)
          }
          else{
            print("Insufficient arguments to execute MULTI")
          }
          address+=1
        case .ret:
          if let addr = arguments.popLast(){
            address = addr
          }
          else{
            print("Insufficient arguments to execute RET")
          }
        case .stop:
          return
        case .print:
          if let arg = arguments.popLast(){
            print("# \(arg)")
            address+=1
          }
          else{
            print("Insufficient arguments to execute PRINT")
          }
          address+=1
        case .push(let arg):
          arguments.append(arg)
          address+=1
        case .call(let addr):
          address = addr
        }
      }
      else{
        address+=1
      }
    }
  }
}
