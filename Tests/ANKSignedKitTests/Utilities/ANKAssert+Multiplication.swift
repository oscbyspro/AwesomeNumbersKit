//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Assert x Multiplication
//*============================================================================*

func ANKAssertMultiplication<M: ANKFixedWidthInteger>(
_ lhs: ANKSigned<M>, _ rhs: ANKSigned<M>, _ low: ANKSigned<M>, _ high: ANKSigned<M>? = nil, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    let high = high ?? ANKSigned(M(), as: low.sign)
    //=------------------------------------------=
    XCTAssertEqual(overflow, !high.isZero, file: file, line: line)
    //=------------------------------------------=
    if !overflow {
        ANKAssertIdentical(                 lhs *  rhs,                 low, file: file, line: line)
        ANKAssertIdentical({ var lhs = lhs; lhs *= rhs; return lhs }(), low, file: file, line: line)
    }
    //=------------------------------------------=
    ANKAssertIdentical(                 lhs &*  rhs,                 low, file: file, line: line)
    ANKAssertIdentical({ var lhs = lhs; lhs &*= rhs; return lhs }(), low, file: file, line: line)
        
    ANKAssertIdentical(lhs.multipliedReportingOverflow(by: rhs).partialValue, low,      file: file, line: line)
    XCTAssertEqual(/**/lhs.multipliedReportingOverflow(by: rhs).overflow,     overflow, file: file, line: line)
    
    ANKAssertIdentical({ var x = lhs; let _ = x.multiplyReportingOverflow(by: rhs); return x }(), low,      file: file, line: line)
    XCTAssertEqual(/**/{ var x = lhs; let o = x.multiplyReportingOverflow(by: rhs); return o }(), overflow, file: file, line: line)
    
    XCTAssertEqual(/**/lhs.multipliedFullWidth(by: rhs).low,  low.magnitude,  file: file, line: line)
    ANKAssertIdentical(lhs.multipliedFullWidth(by: rhs).high, high,           file: file, line: line)
    
    ANKAssertIdentical({ var x = lhs; let _ = x.multiplyFullWidth(by: rhs); return x }(), low,  file: file, line: line)
    XCTAssertEqual(/**/{ var x = lhs; let o = x.multiplyFullWidth(by: rhs); return o }(), high, file: file, line: line)
}

func ANKAssertMultiplicationByDigit<M: ANKFixedWidthInteger>(
_ lhs: ANKSigned<M>, _ rhs: ANKSigned<M>.Digit, _ low: ANKSigned<M>, _ high: ANKSigned<M.Digit>? = nil, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    let high = high ?? ANKSigned(M.Digit(), as: low.sign)
    //=------------------------------------------=
    XCTAssertEqual(overflow, !high.isZero, file: file, line: line)
    //=------------------------------------------=
    if !overflow {
        ANKAssertIdentical(                 lhs *  rhs,                 low, file: file, line: line)
        ANKAssertIdentical({ var lhs = lhs; lhs *= rhs; return lhs }(), low, file: file, line: line)
    }
    //=------------------------------------------=
    ANKAssertIdentical(                 lhs &*  rhs,                 low, file: file, line: line)
    ANKAssertIdentical({ var lhs = lhs; lhs &*= rhs; return lhs }(), low, file: file, line: line)
        
    ANKAssertIdentical(lhs.multipliedReportingOverflow(by: rhs).partialValue, low,      file: file, line: line)
    XCTAssertEqual(/**/lhs.multipliedReportingOverflow(by: rhs).overflow,     overflow, file: file, line: line)
    
    ANKAssertIdentical({ var x = lhs; let _ = x.multiplyReportingOverflow(by: rhs); return x }(), low,      file: file, line: line)
    XCTAssertEqual(/**/{ var x = lhs; let o = x.multiplyReportingOverflow(by: rhs); return o }(), overflow, file: file, line: line)
    
    XCTAssertEqual(/**/lhs.multipliedFullWidth(by: rhs).low,  low.magnitude,  file: file, line: line)
    ANKAssertIdentical(lhs.multipliedFullWidth(by: rhs).high, high,           file: file, line: line)
    
    ANKAssertIdentical({ var x = lhs; let _ = x.multiplyFullWidth(by: rhs); return x }(), low,  file: file, line: line)
    XCTAssertEqual(/**/{ var x = lhs; let o = x.multiplyFullWidth(by: rhs); return o }(), high, file: file, line: line)
}
