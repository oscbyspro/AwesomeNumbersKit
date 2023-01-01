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
// MARK: * Types x Binary Integer x Signed
//*============================================================================*

final class TypesTestsOnANKSignedInteger: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types = Trivial.allSignedFixedWidthIntegerTypes
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testTrivialTypesCount() {
        XCTAssertEqual(types.count, 5)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Zero
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        for type: any ANKSignedInteger.Type in types {
            XCTAssertFalse(type.init(-1).isZero)
            XCTAssertTrue (type.init( 0).isZero)
            XCTAssertFalse(type.init( 1).isZero)
        }
    }
    
    func testIsLessThanZero() {
        for type: any ANKSignedInteger.Type in types {
            XCTAssertTrue (type.init(-1).isLessThanZero)
            XCTAssertFalse(type.init( 0).isLessThanZero)
            XCTAssertFalse(type.init( 1).isLessThanZero)
        }
    }
    
    func testIsMoreThanZero() {
        for type: any ANKSignedInteger.Type in types {
            XCTAssertFalse(type.init(-1).isMoreThanZero)
            XCTAssertFalse(type.init( 0).isMoreThanZero)
            XCTAssertTrue (type.init( 1).isMoreThanZero)
        }
    }
}

//*============================================================================*
// MARK: * Types x Binary Integers x Unigned
//*============================================================================*

final class TypesTestsOnANKUnsignedInteger: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types = Trivial.allUnsignedIntegerTypes
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testTrivialTypesCount() {
        XCTAssertEqual(types.count, 5)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Zero
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        for type: any ANKUnsignedInteger.Type in types {
            XCTAssertTrue (type.init(0).isZero)
            XCTAssertFalse(type.init(1).isZero)
        }
    }
    
    func testIsLessThanZero() {
        for type: any ANKUnsignedInteger.Type in types {
            XCTAssertFalse(type.init(0).isLessThanZero)
            XCTAssertFalse(type.init(1).isLessThanZero)
        }
    }
    
    func testIsMoreThanZero() {
        for type: any ANKUnsignedInteger.Type in types {
            XCTAssertFalse(type.init(0).isMoreThanZero)
            XCTAssertTrue (type.init(1).isMoreThanZero)
        }
    }
}

#endif
