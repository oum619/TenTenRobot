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
  
  func set_address(addr:Int) -> Bool {
    if addr >= 0 && addr < programs.count{
      address = addr
      return true
    }
    return false
  }
  
  func insert(_ program:Program) {
    if set_address(addr: address){
      programs[address] = program
      address+=1
    }
  }
  
  func execute() -> [String]{
    var output:[String] = []
    while address<programs.count {
      if let program = programs[address]{
        switch program{
        case .multi:
          if let arg1 = arguments.popLast(), let arg2 = arguments.popLast(){
            arguments.append(arg1*arg2)
            address+=1
          }
          else{
            return ["Insufficient arguments to execute MULTI"]
          }
        case .ret:
          if let addr = arguments.popLast(){
            if !set_address(addr: addr){
              return ["\(addr) is out of bounds"]
            }
          }
          else{
            return ["Insufficient arguments to execute RET"]
          }
        case .stop:
          return output
        case .print:
          if let arg = arguments.popLast(){
            output.append("# \(arg)")
            address+=1
          }
          else{
            return ["Insufficient arguments to execute PRINT"]
          }
        case .push(let arg):
          arguments.append(arg)
          address+=1
        case .call(let addr):
          if !set_address(addr: addr){
            return ["\(addr) is out of bounds"]
          }
        }
      }
      else{
        address+=1
      }
    }
    return output
  }
}
