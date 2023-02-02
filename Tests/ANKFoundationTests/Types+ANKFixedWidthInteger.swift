//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKFoundation
import XCTest

//*============================================================================*
// MARK: * Types x Fixed Width Integer
//*============================================================================*

final class TypesTestsOnANKFixedWidthInteger: XCTestCase {
    
    typealias T = any ANKFixedWidthInteger.Type
    typealias S = any ANKSignedFixedWidthInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = Types.ANKFixedWidthInteger
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testTypesCount() {
        XCTAssertEqual(types.count, 10)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMostSignificantBit() {
        for type: T in types {
            XCTAssertEqual(type.min .mostSignificantBit, type.isSigned)
            XCTAssertEqual(type.zero.mostSignificantBit, false)
            XCTAssertEqual(type.max .mostSignificantBit, type.isSigned == false)
        }
    }
    
    func testLeastSignificantBit() {
        for type: T in types {
            XCTAssertEqual(type.min .leastSignificantBit, false)
            XCTAssertEqual(type.zero.leastSignificantBit, false)
            XCTAssertEqual(type.max .leastSignificantBit, true )
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Signed
    //=------------------------------------------------------------------------=
    
    func testNegatedReportingOverflow() {
        for case let type as S in types {
            XCTAssertEqual(type.min.negatedReportingOverflow().overflow, true )
            XCTAssertEqual(type.max.negatedReportingOverflow().overflow, false)
        }
    }
}

#endif
