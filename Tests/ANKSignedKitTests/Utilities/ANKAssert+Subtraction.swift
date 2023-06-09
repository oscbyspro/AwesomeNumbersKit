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
// MARK: * ANK x Assert x Subtraction
//*============================================================================*

func ANKAssertSubtraction<T: ANKFixedWidthInteger>(
_ lhs: ANKSigned<T>, _ rhs: ANKSigned<T>, _ partialValue: ANKSigned<T>, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    if !overflow {
        ANKAssertIdentical(                 lhs -  rhs,                 partialValue, file: file, line: line)
        ANKAssertIdentical({ var lhs = lhs; lhs -= rhs; return lhs }(), partialValue, file: file, line: line)
    }
    //=------------------------------------------=
    ANKAssertIdentical(                 lhs &-  rhs,                  partialValue, file: file, line: line)
    ANKAssertIdentical({ var lhs = lhs; lhs &-= rhs; return lhs }(),  partialValue, file: file, line: line)
        
    ANKAssertIdentical(lhs.subtractingReportingOverflow(rhs).partialValue, partialValue, file: file, line: line)
    XCTAssertEqual(/**/lhs.subtractingReportingOverflow(rhs).overflow,     overflow,     file: file, line: line)
    
    ANKAssertIdentical({ var x = lhs; let _ = x.subtractReportingOverflow(rhs); return x }(), partialValue, file: file, line: line)
    XCTAssertEqual(/**/{ var x = lhs; let o = x.subtractReportingOverflow(rhs); return o }(), overflow,     file: file, line: line)
}

func ANKAssertSubtractionByDigit<T: ANKFixedWidthInteger>(
_ lhs: ANKSigned<T>, _ rhs: ANKSigned<T>.Digit, _ partialValue: ANKSigned<T>, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    if !overflow {
        ANKAssertIdentical(                 lhs -  rhs,                 partialValue, file: file, line: line)
        ANKAssertIdentical({ var lhs = lhs; lhs -= rhs; return lhs }(), partialValue, file: file, line: line)
    }
    //=------------------------------------------=
    ANKAssertIdentical(                 lhs &-  rhs,                  partialValue, file: file, line: line)
    ANKAssertIdentical({ var lhs = lhs; lhs &-= rhs; return lhs }(),  partialValue, file: file, line: line)
        
    ANKAssertIdentical(lhs.subtractingReportingOverflow(rhs).partialValue, partialValue, file: file, line: line)
    XCTAssertEqual(/**/lhs.subtractingReportingOverflow(rhs).overflow,     overflow,     file: file, line: line)
    
    ANKAssertIdentical({ var x = lhs; let _ = x.subtractReportingOverflow(rhs); return x }(), partialValue, file: file, line: line)
    XCTAssertEqual(/**/{ var x = lhs; let o = x.subtractReportingOverflow(rhs); return o }(), overflow,     file: file, line: line)
}
