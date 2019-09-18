//
//  TenTenRobotTests.swift
//  TenTenRobotTests
//
//  Created by Motomi Ota on 2019/09/18.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import XCTest
@testable import TenTenRobot

class TenTenRobotTests: XCTestCase {
  
  let CAPACITY = 10
  let computer = Computer(capacity: 10)
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testErrorMulti() {
    computer.insert(.multi)
    if computer.set_address(addr: 0){
      let output = computer.execute()
      XCTAssertEqual(output.first, "Insufficient arguments to execute MULTI")
    }
  }
  func testMulti() {
    computer.insert(.push(CAPACITY/5))
    computer.insert(.push(CAPACITY/5))
    computer.insert(.multi)
    computer.insert(.print)
    if computer.set_address(addr: 0){
      let output = computer.execute()
      XCTAssertEqual(output.first, "# \(CAPACITY/5*2)")
      XCTAssertEqual(computer.arguments.count, 0)
      XCTAssertEqual(computer.programs.count, CAPACITY)
    }
  }
  func testCallUpperOutOfBound() {
    computer.insert(.call(computer.programs.count))
    if computer.set_address(addr: 0){
      let output = computer.execute()
      XCTAssertEqual(output.first, "\(computer.programs.count) is out of bounds")
    }
  }
  func testCallLowerOutOfBound() {
    computer.insert(.call(-1))
    if computer.set_address(addr: 0){
      let output = computer.execute()
      XCTAssertEqual(output.first, "-1 is out of bounds")
    }
  }
  func testCall() {
    if computer.set_address(addr: CAPACITY/2){
      computer.insert(.push(CAPACITY/5))
      computer.insert(.print)
    }
    if computer.set_address(addr: 0){
      computer.insert(.call(CAPACITY/2))
    }
    if computer.set_address(addr: 0){
      let output = computer.execute()
      XCTAssertEqual(output.first, "# \(CAPACITY/5)")
      XCTAssertEqual(computer.arguments.count, 0)
      XCTAssertEqual(computer.programs.count, CAPACITY)
    }
  }
  func testRetError() {
    computer.insert(.ret)
    if computer.set_address(addr: 0){
      let output = computer.execute()
      XCTAssertEqual(output.first, "Insufficient arguments to execute RET")
    }
  }
  func testRet() {
    if computer.set_address(addr: CAPACITY/2){
      computer.insert(.push(CAPACITY/5))
      computer.insert(.print)
    }
    if computer.set_address(addr: 0){
      computer.insert(.push(CAPACITY/2))
      computer.insert(.ret)
    }
    if computer.set_address(addr: 0){
      let output = computer.execute()
      XCTAssertEqual(output.first, "# \(CAPACITY/5)")
      XCTAssertEqual(computer.arguments.count, 0)
      XCTAssertEqual(computer.programs.count, CAPACITY)
    }
  }
  func testStop(){
    computer.insert(.stop)
    if computer.set_address(addr: 0){
      let output = computer.execute()
      XCTAssertEqual(output.first, nil)
      XCTAssertEqual(computer.arguments.count, 0)
      XCTAssertEqual(computer.programs.count, CAPACITY)
    }
  }
  func testPrint(){
    computer.insert(.push(CAPACITY))
    computer.insert(.print)
    if computer.set_address(addr: 0){
      let output = computer.execute()
      XCTAssertEqual(output.first, "# \(CAPACITY)")
      XCTAssertEqual(computer.arguments.count, 0)
      XCTAssertEqual(computer.programs.count, CAPACITY)
    }
  }
  func testPrintError(){
    computer.insert(.print)
    if computer.set_address(addr: 0){
      let output = computer.execute()
      XCTAssertEqual(output.first,"Insufficient arguments to execute PRINT")
    }
  }
  func testPush(){
    for i in 0..<CAPACITY{
      computer.insert(.push(i))
    }
    XCTAssertEqual(computer.arguments.count, 0)
    XCTAssertEqual(computer.programs.count, CAPACITY)
    if computer.set_address(addr: 0){
      _ = computer.execute()
      XCTAssertEqual(computer.arguments.count, CAPACITY)
    }
  }
}
