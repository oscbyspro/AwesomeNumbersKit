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
// MARK: * ANK x Assert x Subtraction
//*============================================================================*

func ANKAssertSubtraction<M: ANKFixedWidthInteger>(
_ lhs: ANKSigned<M>, _ rhs: ANKSigned<M>, _ partialValue: ANKSigned<M>, _ overflow: Bool = false,
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

func ANKAssertSubtractionByDigit<M: ANKFixedWidthInteger>(
_ lhs: ANKSigned<M>, _ rhs: ANKSigned<M>.Digit, _ partialValue: ANKSigned<M>, _ overflow: Bool = false,
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
