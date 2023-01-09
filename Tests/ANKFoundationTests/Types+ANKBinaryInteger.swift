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

final class TypesTestsOnANKBinaryInteger: XCTestCase {
    
    typealias T = any ANKBinaryInteger.Type
    typealias S = any ANKSignedInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types = Trivial.allBinaryIntegerTypes
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testTrivialTypesCount() {
        XCTAssertEqual(types.count, 10)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        for type: T in types {
            XCTAssertFalse(type.init( 1).isZero)
            XCTAssertTrue (type.init( 0).isZero)
            
            guard type is S else { continue }
            
            XCTAssertFalse(type.init(-1).isZero)
        }
    }
    
    func testIsLessThanZero() {
        for type: T in types {
            XCTAssertFalse(type.init( 1).isLessThanZero)
            XCTAssertFalse(type.init( 0).isLessThanZero)
            
            guard type is S else { continue }
            
            XCTAssertTrue (type.init(-1).isLessThanZero)
        }
    }
    
    func testIsMoreThanZero() {
        for type: T in types {
            XCTAssertTrue (type.init( 1).isMoreThanZero)
            XCTAssertFalse(type.init( 0).isMoreThanZero)
            
            guard type is S else { continue }
            
            XCTAssertFalse(type.init(-1).isMoreThanZero)
        }
    }
}

#endif
