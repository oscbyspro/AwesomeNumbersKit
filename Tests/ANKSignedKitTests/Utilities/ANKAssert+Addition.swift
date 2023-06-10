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
// MARK: * ANK x Assert x Addition
//*============================================================================*

func ANKAssertAddition<T: ANKFixedWidthInteger>(
_ lhs: ANKSigned<T>, _ rhs: ANKSigned<T>, _ partialValue: ANKSigned<T>, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    if !overflow {
        ANKAssertIdentical(                 lhs +  rhs,                 partialValue, file: file, line: line)
        ANKAssertIdentical({ var lhs = lhs; lhs += rhs; return lhs }(), partialValue, file: file, line: line)
    }
    //=------------------------------------------=
    ANKAssertIdentical(                 lhs &+  rhs,                  partialValue, file: file, line: line)
    ANKAssertIdentical({ var lhs = lhs; lhs &+= rhs; return lhs }(),  partialValue, file: file, line: line)
        
    ANKAssertIdentical(lhs.addingReportingOverflow(rhs).partialValue, partialValue, file: file, line: line)
    XCTAssertEqual(/**/lhs.addingReportingOverflow(rhs).overflow,     overflow,     file: file, line: line)
    
    ANKAssertIdentical({ var x = lhs; let _ = x.addReportingOverflow(rhs); return x }(), partialValue, file: file, line: line)
    XCTAssertEqual(/**/{ var x = lhs; let o = x.addReportingOverflow(rhs); return o }(), overflow,     file: file, line: line)
}

func ANKAssertAdditionByDigit<T: ANKFixedWidthInteger>(
_ lhs: ANKSigned<T>, _ rhs: ANKSigned<T>.Digit, _ partialValue: ANKSigned<T>, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    if !overflow {
        ANKAssertIdentical(                 lhs +  rhs,                 partialValue, file: file, line: line)
        ANKAssertIdentical({ var lhs = lhs; lhs += rhs; return lhs }(), partialValue, file: file, line: line)
    }
    //=------------------------------------------=
    ANKAssertIdentical(                 lhs &+  rhs,                  partialValue, file: file, line: line)
    ANKAssertIdentical({ var lhs = lhs; lhs &+= rhs; return lhs }(),  partialValue, file: file, line: line)
        
    ANKAssertIdentical(lhs.addingReportingOverflow(rhs).partialValue, partialValue, file: file, line: line)
    XCTAssertEqual(/**/lhs.addingReportingOverflow(rhs).overflow,     overflow,     file: file, line: line)
    
    ANKAssertIdentical({ var x = lhs; let _ = x.addReportingOverflow(rhs); return x }(), partialValue, file: file, line: line)
    XCTAssertEqual(/**/{ var x = lhs; let o = x.addReportingOverflow(rhs); return o }(), overflow,     file: file, line: line)
}
