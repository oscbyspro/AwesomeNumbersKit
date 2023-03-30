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
// MARK: * ANK x Core Integer x Comparisons
//*============================================================================*

final class ANKCoreIntegerTestsOnComparisons: XCTestCase {
    
    typealias T = any (ANKCoreInteger).Type
    typealias S = any (ANKCoreInteger & ANKSignedFixedWidthInteger).Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = typesOfANKCoreInteger
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        for type: T in types {
            XCTAssertFalse(type.init( 1).isZero)
            XCTAssertTrue (type.init( 0).isZero)
            guard type.isSigned else { continue }
            XCTAssertFalse(type.init(-1).isZero)
        }
    }
    
    func testIsLessThanZero() {
        for type: T in types {
            XCTAssertFalse(type.init( 1).isLessThanZero)
            XCTAssertFalse(type.init( 0).isLessThanZero)
            guard type.isSigned else { continue }
            XCTAssertTrue (type.init(-1).isLessThanZero)
        }
    }
    
    func testIsMoreThanZero() {
        for type: T in types {
            XCTAssertTrue (type.init( 1).isMoreThanZero)
            XCTAssertFalse(type.init( 0).isMoreThanZero)
            guard type.isSigned else { continue }
            XCTAssertFalse(type.init(-1).isMoreThanZero)
        }
    }
}

#endif
