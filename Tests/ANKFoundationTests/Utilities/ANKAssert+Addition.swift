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
// MARK: * ANK x Assert x Comparisons
//*============================================================================*

func ANKAssertComparisons<T: ANKFixedWidthInteger>(
_ lhs: T, _ rhs: T, _ result: Int,
file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(lhs == rhs, result ==  0, file: file, line: line)
    XCTAssertEqual(lhs != rhs, result !=  0, file: file, line: line)
    
    XCTAssertEqual(lhs <  rhs, result == -1, file: file, line: line)
    XCTAssertEqual(lhs <= rhs, result !=  1, file: file, line: line)

    XCTAssertEqual(lhs >  rhs, result ==  1, file: file, line: line)
    XCTAssertEqual(lhs >= rhs, result != -1, file: file, line: line)
    
    XCTAssertEqual(lhs.compared(to: rhs), result, file: file, line: line)
}
