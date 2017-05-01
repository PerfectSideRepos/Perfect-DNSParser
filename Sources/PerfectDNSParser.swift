//
//  PerfectDNSParser.swift
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

#if os(Linux)
import SwiftGlibc
#else
import Darwin
#endif

extension String {

  /// get IPv4 address from current host DNS name
  /// - parameters:
  ///   - service: service port, such as "http", "ftp", "https" or "ssh", etc.
  /// - returns:
  ///   - ip address if success, or nil if something wrong.
  public func parseDNS(_ service: String = "http") -> String? {
    let hints = UnsafePointer<addrinfo>(bitPattern: 0)
    var res = UnsafeMutablePointer<addrinfo>(bitPattern: 0)
    guard 0 == getaddrinfo(self, service, hints, &res), let s = res else {
      return nil
    }//end guard
    let p = unsafeBitCast(s.pointee.ai_addr, to: UnsafePointer<sockaddr_in>.self)
    var address = p.pointee.sin_addr
    let ipAddress = UnsafeMutablePointer<Int8>.allocate(capacity: Int(INET_ADDRSTRLEN + 1))
    var ip = ""
    if let _ = inet_ntop(AF_INET, &address, ipAddress, socklen_t(INET_ADDRSTRLEN)) {
      ipAddress.advanced(by: Int(INET_ADDRSTRLEN)).pointee = 0
      ip = String(cString: ipAddress)
    }//end if
    ipAddress.deallocate(capacity: Int(INET_ADDRSTRLEN + 1))
    freeaddrinfo(s)
    return ip.isEmpty ? nil: ip
  }//end func
}//end extension
