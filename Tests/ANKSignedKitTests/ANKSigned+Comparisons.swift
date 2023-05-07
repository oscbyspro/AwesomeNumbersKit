//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed x Comparisons
//*============================================================================*

final class ANKSignedTestsOnComparisons: XCTestCase {

    typealias T = ANKSigned<UInt>

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testHashing() {
        var union = Set<T>()
        union.insert( T(0))
        union.insert( T(0))
        union.insert(-T(0))
        union.insert(-T(0))
        union.insert( T(1))
        union.insert( T(1))
        union.insert(-T(1))
        union.insert(-T(1))
        XCTAssertEqual(union.count, 3)
    }

    func testComparing() {
        ANKAssertComparisons( T(0),  T(0),  Int(0))
        ANKAssertComparisons( T(0), -T(0),  Int(0))
        ANKAssertComparisons(-T(0),  T(0),  Int(0))
        ANKAssertComparisons(-T(0), -T(0),  Int(0))
        
        ANKAssertComparisons( T(1),  T(1),  Int(0))
        ANKAssertComparisons( T(1), -T(1),  Int(1))
        ANKAssertComparisons(-T(1),  T(1), -Int(1))
        ANKAssertComparisons(-T(1), -T(1),  Int(0))
        
        ANKAssertComparisons( T(2),  T(3), -Int(1))
        ANKAssertComparisons( T(2), -T(3),  Int(1))
        ANKAssertComparisons(-T(2),  T(3), -Int(1))
        ANKAssertComparisons(-T(2), -T(3),  Int(1))
        
        ANKAssertComparisons( T(3),  T(2),  Int(1))
        ANKAssertComparisons( T(3), -T(2),  Int(1))
        ANKAssertComparisons(-T(3),  T(2), -Int(1))
        ANKAssertComparisons(-T(3), -T(2), -Int(1))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=

    func testIsZero() {
        XCTAssertTrue (( T(0)).isZero)
        XCTAssertTrue ((-T(0)).isZero)
        XCTAssertFalse(( T(1)).isZero)
        XCTAssertFalse((-T(1)).isZero)
    }

    func testIsLessThanZero() {
        XCTAssertFalse(( T(0)).isLessThanZero)
        XCTAssertFalse((-T(0)).isLessThanZero)
        XCTAssertFalse(( T(1)).isLessThanZero)
        XCTAssertTrue ((-T(1)).isLessThanZero)
    }

    func testIsMoreThanZero() {
        XCTAssertFalse(( T(0)).isMoreThanZero)
        XCTAssertFalse((-T(0)).isMoreThanZero)
        XCTAssertTrue (( T(1)).isMoreThanZero)
        XCTAssertFalse((-T(1)).isMoreThanZero)
    }

    func testSignum() {
        XCTAssertEqual(( T(0)).signum(), Int( 0))
        XCTAssertEqual((-T(0)).signum(), Int( 0))
        XCTAssertEqual(( T(1)).signum(), Int( 1))
        XCTAssertEqual((-T(1)).signum(), Int(-1))
    }
}

#endif
