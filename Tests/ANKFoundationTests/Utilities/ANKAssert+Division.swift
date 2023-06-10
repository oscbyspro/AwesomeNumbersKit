//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKFoundation
import XCTest

//*============================================================================*
// MARK: * ANK x Assert x Division
//*============================================================================*

func ANKAssertDivision<T: ANKFixedWidthInteger>(
_ lhs: T, _ rhs: T, _ quotient: T, _ remainder: T, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    if !overflow {
        XCTAssertEqual(lhs / rhs, quotient,  file: file, line: line)
        XCTAssertEqual(lhs % rhs, remainder, file: file, line: line)
        
        XCTAssertEqual({ var x = lhs; x /= rhs; return x }(), quotient,  file: file, line: line)
        XCTAssertEqual({ var x = lhs; x %= rhs; return x }(), remainder, file: file, line: line)
        
        XCTAssertEqual(lhs.quotientAndRemainder(dividingBy: rhs).quotient,  quotient,  file: file, line: line)
        XCTAssertEqual(lhs.quotientAndRemainder(dividingBy: rhs).remainder, remainder, file: file, line: line)
    }
    //=------------------------------------------=
    XCTAssertEqual(lhs.dividedReportingOverflow(by: rhs).partialValue, quotient, file: file, line: line)
    XCTAssertEqual(lhs.dividedReportingOverflow(by: rhs).overflow,     overflow, file: file, line: line)
    
    XCTAssertEqual({ var x = lhs; let _ = x.divideReportingOverflow(by: rhs); return x }(), quotient, file: file, line: line)
    XCTAssertEqual({ var x = lhs; let o = x.divideReportingOverflow(by: rhs); return o }(), overflow, file: file, line: line)
    
    XCTAssertEqual(lhs.remainderReportingOverflow(dividingBy: rhs).partialValue, remainder, file: file, line: line)
    XCTAssertEqual(lhs.remainderReportingOverflow(dividingBy: rhs).overflow,     overflow,  file: file, line: line)
    
    XCTAssertEqual({ var x = lhs; let _ = x.formRemainderReportingOverflow(dividingBy: rhs); return x }(), remainder, file: file, line: line)
    XCTAssertEqual({ var x = lhs; let o = x.formRemainderReportingOverflow(dividingBy: rhs); return o }(), overflow,  file: file, line: line)

    XCTAssertEqual(lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).partialValue.quotient,  quotient,  file: file, line: line)
    XCTAssertEqual(lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).partialValue.remainder, remainder, file: file, line: line)
    XCTAssertEqual(lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).overflow,               overflow,  file: file, line: line)
}

//*============================================================================*
// MARK: * ANK x Assert x Division x Full Width
//*============================================================================*

func ANKAssertDivisionFullWidth<T: ANKFixedWidthInteger>(
_ lhs: HL<T, T.Magnitude>, _ rhs: T, _ quotient: T, _ remainder: T, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    if !overflow {
        let qr: QR<T, T> = rhs.dividingFullWidth(lhs)
        XCTAssertEqual(qr.quotient,  quotient,  file: file, line: line)
        XCTAssertEqual(qr.remainder, remainder, file: file, line: line)
    }
    
    let qro: PVO<QR<T, T>> = rhs.dividingFullWidthReportingOverflow(lhs)
    XCTAssertEqual(qro.partialValue.quotient,  quotient,  file: file, line: line)
    XCTAssertEqual(qro.partialValue.remainder, remainder, file: file, line: line)
    XCTAssertEqual(qro.overflow,               overflow,  file: file, line: line)
}
