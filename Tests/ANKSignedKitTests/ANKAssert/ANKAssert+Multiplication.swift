//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKFoundation
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Assert x Multiplication
//*============================================================================*

func ANKAssertMultiplication<T: ANKFixedWidthInteger>(
_ lhs: ANKSigned<T>, _ rhs: ANKSigned<T>, _ low: ANKSigned<T>, _ high: ANKSigned<T>? = nil, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    let high = high ?? ANKSigned(T(), as: low.sign)
    //=------------------------------------------=
    XCTAssertEqual(overflow, !high.isZero, file: file, line: line)
    //=------------------------------------------=
    if !overflow {
        ANKAssertEqual(                 lhs *  rhs,                 low, file: file, line: line)
        ANKAssertEqual({ var lhs = lhs; lhs *= rhs; return lhs }(), low, file: file, line: line)
    }
    //=------------------------------------------=
    ANKAssertEqual(                 lhs &*  rhs,                 low, file: file, line: line)
    ANKAssertEqual({ var lhs = lhs; lhs &*= rhs; return lhs }(), low, file: file, line: line)
        
    ANKAssertEqual(lhs.multipliedReportingOverflow(by: rhs).partialValue, low,      file: file, line: line)
    XCTAssertEqual(lhs.multipliedReportingOverflow(by: rhs).overflow,     overflow, file: file, line: line)
    
    ANKAssertEqual({ var x = lhs; let _ = x.multiplyReportingOverflow(by: rhs); return x }(), low,      file: file, line: line)
    XCTAssertEqual({ var x = lhs; let o = x.multiplyReportingOverflow(by: rhs); return o }(), overflow, file: file, line: line)
    
    XCTAssertEqual(lhs.multipliedFullWidth(by: rhs).low,  low.magnitude,  file: file, line: line)
    ANKAssertEqual(lhs.multipliedFullWidth(by: rhs).high, high,           file: file, line: line)
    
    ANKAssertEqual({ var x = lhs; let _ = x.multiplyFullWidth(by: rhs); return x }(), low,  file: file, line: line)
    XCTAssertEqual({ var x = lhs; let o = x.multiplyFullWidth(by: rhs); return o }(), high, file: file, line: line)
}

func ANKAssertMultiplicationByDigit<T: ANKFixedWidthInteger>(
_ lhs: ANKSigned<T>, _ rhs: ANKSigned<T>.Digit, _ low: ANKSigned<T>, _ high: ANKSigned<T.Digit>? = nil, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    let high = high ?? ANKSigned(T.Digit(), as: low.sign)
    //=------------------------------------------=
    XCTAssertEqual(overflow, !high.isZero, file: file, line: line)
    //=------------------------------------------=
    if !overflow {
        ANKAssertEqual(                 lhs *  rhs,                 low, file: file, line: line)
        ANKAssertEqual({ var lhs = lhs; lhs *= rhs; return lhs }(), low, file: file, line: line)
    }
    //=------------------------------------------=
    ANKAssertEqual(                 lhs &*  rhs,                 low, file: file, line: line)
    ANKAssertEqual({ var lhs = lhs; lhs &*= rhs; return lhs }(), low, file: file, line: line)
        
    ANKAssertEqual(lhs.multipliedReportingOverflow(by: rhs).partialValue, low,      file: file, line: line)
    XCTAssertEqual(lhs.multipliedReportingOverflow(by: rhs).overflow,     overflow, file: file, line: line)
    
    ANKAssertEqual({ var x = lhs; let _ = x.multiplyReportingOverflow(by: rhs); return x }(), low,      file: file, line: line)
    XCTAssertEqual({ var x = lhs; let o = x.multiplyReportingOverflow(by: rhs); return o }(), overflow, file: file, line: line)
    
    XCTAssertEqual(lhs.multipliedFullWidth(by: rhs).low,  low.magnitude,  file: file, line: line)
    ANKAssertEqual(lhs.multipliedFullWidth(by: rhs).high, high,           file: file, line: line)
    
    ANKAssertEqual({ var x = lhs; let _ = x.multiplyFullWidth(by: rhs); return x }(), low,  file: file, line: line)
    XCTAssertEqual({ var x = lhs; let o = x.multiplyFullWidth(by: rhs); return o }(), high, file: file, line: line)
}
