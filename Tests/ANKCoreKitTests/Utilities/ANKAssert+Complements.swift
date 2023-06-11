//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit
import XCTest

//*============================================================================*
// MARK: * ANK x Assert x Complements
//*============================================================================*

func ANKAssertTwosComplement<T: ANKFixedWidthInteger>(
_ integer: T, _ twosComplement: T, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(integer.twosComplement(),                              twosComplement,      file: file, line: line)
    XCTAssertEqual(integer.twosComplementSubsequence(true ).partialValue, twosComplement,      file: file, line: line)
    XCTAssertEqual(integer.twosComplementSubsequence(false).partialValue, twosComplement &- 1, file: file, line: line)
    
    XCTAssertEqual({ var x = integer;     x.formTwosComplement();                 return x }(), twosComplement,      file: file, line: line)
    XCTAssertEqual({ var x = integer; _ = x.formTwosComplementSubsequence(true ); return x }(), twosComplement,      file: file, line: line)
    XCTAssertEqual({ var x = integer; _ = x.formTwosComplementSubsequence(false); return x }(), twosComplement &- 1, file: file, line: line)
}
