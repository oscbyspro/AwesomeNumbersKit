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
// MARK: * ANK x Assert x Division
//*============================================================================*

func ANKAssertDivision<T: ANKFixedWidthInteger>(
_ lhs: ANKSigned<T>, _ rhs: ANKSigned<T>, _ quotient: ANKSigned<T>, _ remainder: ANKSigned<T>, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    XCTAssertEqual(overflow, rhs.isZero, file: file, line: line)
    //=------------------------------------------=
    if !overflow {
        ANKAssertIdentical(lhs /  rhs, quotient,  file: file, line: line)
        ANKAssertIdentical(lhs %  rhs, remainder, file: file, line: line)
        
        ANKAssertIdentical({ var x = lhs; x /= rhs; return x }(), quotient,  file: file, line: line)
        ANKAssertIdentical({ var x = lhs; x %= rhs; return x }(), remainder, file: file, line: line)
        
        ANKAssertIdentical(lhs.quotientAndRemainder(dividingBy: rhs).quotient,  quotient,  file: file, line: line)
        ANKAssertIdentical(lhs.quotientAndRemainder(dividingBy: rhs).remainder, remainder, file: file, line: line)
    }
    //=------------------------------------------=
    ANKAssertIdentical(lhs.dividedReportingOverflow(by: rhs).partialValue, quotient, file: file, line: line)
    XCTAssertEqual(/**/lhs.dividedReportingOverflow(by: rhs).overflow,     overflow, file: file, line: line)
    
    ANKAssertIdentical({ var x = lhs; let _ = x.divideReportingOverflow(by: rhs); return x }(), quotient, file: file, line: line)
    XCTAssertEqual(/**/{ var x = lhs; let o = x.divideReportingOverflow(by: rhs); return o }(), overflow, file: file, line: line)
    
    ANKAssertIdentical(lhs.remainderReportingOverflow(dividingBy: rhs).partialValue, remainder, file: file, line: line)
    XCTAssertEqual(/**/lhs.remainderReportingOverflow(dividingBy: rhs).overflow,     overflow,  file: file, line: line)
    
    ANKAssertIdentical({ var x = lhs; let _ = x.formRemainderReportingOverflow(dividingBy: rhs); return x }(), remainder, file: file, line: line)
    XCTAssertEqual(/**/{ var x = lhs; let o = x.formRemainderReportingOverflow(dividingBy: rhs); return o }(), overflow,  file: file, line: line)
    
    ANKAssertIdentical(lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).partialValue.quotient,  quotient,  file: file, line: line)
    ANKAssertIdentical(lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).partialValue.remainder, remainder, file: file, line: line)
    XCTAssertEqual(/**/lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).overflow,               overflow,  file: file, line: line)
}

func ANKAssertDivisionByDigit<T: ANKFixedWidthInteger>(
_ lhs: ANKSigned<T>, _ rhs: ANKSigned<T.Digit>, _ quotient: ANKSigned<T>, _ remainder: ANKSigned<T.Digit>, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    let remainder_ = ANKSigned<T>(digit: remainder)
    //=------------------------------------------=
    XCTAssertEqual(overflow, rhs.isZero, file: file, line: line)
    //=------------------------------------------=
    if !overflow {
        ANKAssertIdentical(lhs /  rhs, quotient,  file: file, line: line)
        ANKAssertIdentical(lhs %  rhs, remainder, file: file, line: line)
        
        ANKAssertIdentical({ var x = lhs; x /= rhs; return x }(), quotient,   file: file, line: line)
        ANKAssertIdentical({ var x = lhs; x %= rhs; return x }(), remainder_, file: file, line: line)
        
        ANKAssertIdentical(lhs.quotientAndRemainder(dividingBy: rhs).quotient,  quotient,  file: file, line: line)
        ANKAssertIdentical(lhs.quotientAndRemainder(dividingBy: rhs).remainder, remainder, file: file, line: line)
    }
    //=------------------------------------------=
    ANKAssertIdentical(lhs.dividedReportingOverflow(by: rhs).partialValue, quotient, file: file, line: line)
    XCTAssertEqual(/**/lhs.dividedReportingOverflow(by: rhs).overflow,     overflow, file: file, line: line)
    
    ANKAssertIdentical({ var x = lhs; let _ = x.divideReportingOverflow(by: rhs); return x }(), quotient, file: file, line: line)
    XCTAssertEqual(/**/{ var x = lhs; let o = x.divideReportingOverflow(by: rhs); return o }(), overflow, file: file, line: line)
    
    ANKAssertIdentical(lhs.remainderReportingOverflow(dividingBy: rhs).partialValue, remainder, file: file, line: line)
    XCTAssertEqual(/**/lhs.remainderReportingOverflow(dividingBy: rhs).overflow,     overflow,  file: file, line: line)
    
    ANKAssertIdentical({ var x = lhs; let _ = x.formRemainderReportingOverflow(dividingBy: rhs); return x }(), remainder_, file: file, line: line)
    XCTAssertEqual(/**/{ var x = lhs; let o = x.formRemainderReportingOverflow(dividingBy: rhs); return o }(), overflow,   file: file, line: line)
    
    ANKAssertIdentical(lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).partialValue.quotient,  quotient,  file: file, line: line)
    ANKAssertIdentical(lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).partialValue.remainder, remainder, file: file, line: line)
    XCTAssertEqual(/**/lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).overflow,               overflow,  file: file, line: line)
}

//*============================================================================*
// MARK: * ANK x Assert x Division x Full Width
//*============================================================================*

func ANKAssertDivisionFullWidth<T: ANKFixedWidthInteger>(
_ lhs: HL<ANKSigned<T>, T.Magnitude>, _ rhs: ANKSigned<T>, _ quotient: ANKSigned<T>, _ remainder: ANKSigned<T>,
file: StaticString = #file, line: UInt = #line) {
    let qr: QR<ANKSigned<T>, ANKSigned<T>> = rhs.dividingFullWidth(lhs)
    ANKAssertIdentical(qr.quotient,  quotient,  file: file, line: line)
    ANKAssertIdentical(qr.remainder, remainder, file: file, line: line)
}
