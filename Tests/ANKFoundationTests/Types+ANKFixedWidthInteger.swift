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
// MARK: * Types x Fixed Width Integer x Signed
//*============================================================================*

final class TypesTestsOnANKSignedFixedWidthInteger: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types = Trivial.allSignedFixedWidthIntegerTypes
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMostSignificantBit() {
        for type: any ANKSignedFixedWidthInteger.Type in types {
            XCTAssertEqual(type.min .mostSignificantBit, true )
            XCTAssertEqual(type.zero.mostSignificantBit, false)
            XCTAssertEqual(type.max .mostSignificantBit, false)
        }
    }
    
    func testLeastSignificantBit() {
        for type: any ANKSignedFixedWidthInteger.Type in types {
            XCTAssertEqual(type.min .leastSignificantBit, false)
            XCTAssertEqual(type.zero.leastSignificantBit, false)
            XCTAssertEqual(type.max .leastSignificantBit, true )
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNegatedReportingOverflow() {
        for type in types {
            XCTAssertEqual(type.min.negatedReportingOverflow().overflow, true )
            XCTAssertEqual(type.max.negatedReportingOverflow().overflow, false)
        }
    }
}

//*============================================================================*
// MARK: * Types x Fixed Width Integers x Unigned
//*============================================================================*

final class TypesTestsOnANKUnsignedFixedWidthInteger: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types = Trivial.allUnsignedFixedWidthIntegerTypes
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMostSignificantBit() {
        for type: any ANKUnsignedFixedWidthInteger.Type in types {
            XCTAssertEqual(type.min .mostSignificantBit, false)
            XCTAssertEqual(type.zero.mostSignificantBit, false)
            XCTAssertEqual(type.max .mostSignificantBit, true )
        }
    }
    
    func testLeastSignificantBit() {
        for type: any ANKUnsignedFixedWidthInteger.Type in types {
            XCTAssertEqual(type.min .leastSignificantBit, false)
            XCTAssertEqual(type.zero.leastSignificantBit, false)
            XCTAssertEqual(type.max .leastSignificantBit, true )
        }
    }
}

#endif
