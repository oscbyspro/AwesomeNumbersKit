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
    
    func testEquating() {
        XCTAssert(T(0, as: .plus ) == T(0, as: .plus ))
        XCTAssert(T(0, as: .plus ) == T(0, as: .minus))
        XCTAssert(T(0, as: .minus) == T(0, as: .plus ))
        XCTAssert(T(0, as: .minus) == T(0, as: .minus))
        
        XCTAssert(T(0, as: .plus ) != T(1, as: .plus ))
        XCTAssert(T(0, as: .plus ) != T(1, as: .minus))
        XCTAssert(T(0, as: .minus) != T(1, as: .plus ))
        XCTAssert(T(0, as: .minus) != T(1, as: .minus))
        
        XCTAssert(T(1, as: .plus ) == T(1, as: .plus ))
        XCTAssert(T(1, as: .plus ) != T(1, as: .minus))
        XCTAssert(T(1, as: .minus) != T(1, as: .plus ))
        XCTAssert(T(1, as: .minus) == T(1, as: .minus))
        
        XCTAssert(T(1, as: .plus ) != T(0, as: .plus ))
        XCTAssert(T(1, as: .plus ) != T(0, as: .minus))
        XCTAssert(T(1, as: .minus) != T(0, as: .plus ))
        XCTAssert(T(1, as: .minus) != T(0, as: .minus))
    }
    
    func testComparing() {
        XCTAssert(T(0, as: .plus ) < T(1, as: .plus ))
        XCTAssert(T(0, as: .plus ) > T(1, as: .minus))
        XCTAssert(T(0, as: .minus) < T(1, as: .plus ))
        XCTAssert(T(0, as: .minus) > T(1, as: .minus))
        
        XCTAssert(T(1, as: .plus ) > T(1, as: .minus))
        XCTAssert(T(1, as: .minus) < T(1, as: .plus ))
        
        XCTAssert(T(1, as: .plus ) > T(0, as: .plus ))
        XCTAssert(T(1, as: .plus ) > T(0, as: .minus))
        XCTAssert(T(1, as: .minus) < T(0, as: .plus ))
        XCTAssert(T(1, as: .minus) < T(0, as: .minus))
    }
    
    func testHashing() {
        var set = Set<T>()
        set.insert(T(0, as: .plus ))
        set.insert(T(0, as: .plus ))
        set.insert(T(0, as: .minus))
        set.insert(T(0, as: .minus))
        set.insert(T(1, as: .plus ))
        set.insert(T(1, as: .plus ))
        set.insert(T(1, as: .minus))
        set.insert(T(1, as: .minus))
        XCTAssertEqual(set.count, 3)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        XCTAssertTrue (T(0, as: .plus ).isZero)
        XCTAssertTrue (T(0, as: .minus).isZero)
        XCTAssertFalse(T(1, as: .plus ).isZero)
        XCTAssertFalse(T(1, as: .minus).isZero)
    }
    
    func testIsLessThanZero() {
        XCTAssertFalse(T(0, as: .plus ).isLessThanZero)
        XCTAssertFalse(T(0, as: .minus).isLessThanZero)
        XCTAssertFalse(T(1, as: .plus ).isLessThanZero)
        XCTAssertTrue (T(1, as: .minus).isLessThanZero)
    }
    
    func testIsMoreThanZero() {
        XCTAssertFalse(T(0, as: .plus ).isMoreThanZero)
        XCTAssertFalse(T(0, as: .minus).isMoreThanZero)
        XCTAssertTrue (T(1, as: .plus ).isMoreThanZero)
        XCTAssertFalse(T(1, as: .minus).isMoreThanZero)
    }
    
    func testSignum() {
        XCTAssertEqual(T(0, as: .plus ).signum(), Int( 0))
        XCTAssertEqual(T(0, as: .minus).signum(), Int( 0))
        XCTAssertEqual(T(1, as: .plus ).signum(), Int( 1))
        XCTAssertEqual(T(1, as: .minus).signum(), Int(-1))
    }
}

#endif
