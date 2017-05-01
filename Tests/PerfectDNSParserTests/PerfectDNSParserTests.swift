//
//  PerfectDNSParserTests.swift
//  Perfect DNS Parser
//
//  Created by Rockford Wei on May 1st, 2017.
//	Copyright (C) 2017 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2017 - 2018 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//
import XCTest
@testable import PerfectDNSParser

class PerfectDNSParserTests: XCTestCase {
  func testTreeFrog() {
    XCTAssertEqual("treefrog.ca".parseDNS() ?? "", "23.92.17.203")
  }
  func testPerfect() {
    XCTAssertEqual("perfect.org".parseDNS() ?? "", "65.39.133.132")
  }
  func testCookieMonster() {
    XCTAssertEqual("cookiemonster.perfect.org".parseDNS() ?? "", "65.39.133.24")
  }
  static var allTests = [
    ("testTreeFrog", testTreeFrog),
    ("testPerfect", testPerfect),
    ("testCookieMonster", testCookieMonster)
  ]
}
