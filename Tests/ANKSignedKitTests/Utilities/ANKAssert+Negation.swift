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
// MARK: * ANK x Assert x Negation
//*============================================================================*

func ANKAssertNegation<M: ANKFixedWidthInteger>(
_ operand: ANKSigned<M>, _ partialValue: ANKSigned<M>, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    if !overflow {
        ANKAssertIdentical(-operand,                                    partialValue, file: file, line: line)
        ANKAssertIdentical((operand).negated(),                         partialValue, file: file, line: line)
        ANKAssertIdentical({ var x = operand; x.negate(); return x }(), partialValue, file: file, line: line)
    }
    //=------------------------------------------=
    ANKAssertIdentical(operand.negatedReportingOverflow().partialValue, partialValue, file: file, line: line)
    XCTAssertEqual(/**/operand.negatedReportingOverflow().overflow,     overflow,     file: file, line: line)
    
    ANKAssertIdentical({ var x = operand; let _ = x.negateReportingOverflow(); return x }(), partialValue, file: file, line: line)
    XCTAssertEqual(/**/{ var x = operand; let o = x.negateReportingOverflow(); return o }(), overflow,     file: file, line: line)
}
