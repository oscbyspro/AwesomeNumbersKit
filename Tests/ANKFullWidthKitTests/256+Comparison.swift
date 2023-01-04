//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKFullWidthKit
import XCTest

//*============================================================================*
// MARK: * Int256 x Comparison
//*============================================================================*

final class Int256TestsOnComparison: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testEquating() {
        XCTAssert(T(-1) == T(-1))
        XCTAssert(T( 0) == T( 0))
        XCTAssert(T( 1) == T( 1))
        
        XCTAssert(T( 0) != T( 1))
        XCTAssert(T( 1) != T( 0))
        
        XCTAssert(T( 0) != T(-1))
        XCTAssert(T(-1) != T(-0))
        
        XCTAssert(T( 1) != T(-1))
        XCTAssert(T(-1) != T( 1))
        
        XCTAssert(T.min == T.min)
        XCTAssert(T.min != T.max)
        XCTAssert(T.max != T.min)
        XCTAssert(T.max == T.max)

        XCTAssertEqual(T(x64:(0, 0, 0, 0)), T(x64:(0, 0, 0, 0)))
        XCTAssertEqual(T(x64:(w, w, w, w)), T(x64:(w, w, w, w)))
    }
    
    func testComparing() {
        XCTAssertFalse(T( 0) < T( 0))
        XCTAssertFalse(T( 0) > T( 0))
        XCTAssertFalse(T( 1) < T( 1))
        XCTAssertFalse(T( 1) > T( 1))
        XCTAssertFalse(T(-1) < T(-1))
        XCTAssertFalse(T(-1) > T(-1))
        
        XCTAssertLessThan(T( 0), T( 1))
        XCTAssertLessThan(T(-1), T( 0))
        XCTAssertLessThan(T( 1), T( 2))
        XCTAssertLessThan(T(-2), T(-1))
        XCTAssertLessThan(T(-1), T( 1))
        
        XCTAssert(T.min == T.min)
        XCTAssert(T.min <  T.max)
        XCTAssert(T.max >  T.min)
        XCTAssert(T.max == T.max)
        
        XCTAssert(T(x64:(w, w, 0, 0)) < T(x64:(w, w, w, 0)))
        XCTAssert(T(x64:(w, w, w, 0)) > T(x64:(w, w, 0, 0)))
        
        XCTAssert(T(x64:(w, w, w, 0)) > T(x64:(w, w, w, w)))
        XCTAssert(T(x64:(w, w, w, w)) < T(x64:(w, w, w, 0)))
    }
    
    func testHashing() {
        var set = Set<T>()
        set.insert(T(x64:(0, 0, 0, 0)))
        set.insert(T(x64:(1, 0, 0, 0)))
        set.insert(T(x64:(0, 1, 0, 0)))
        set.insert(T(x64:(0, 0, 1, 0)))
        set.insert(T(x64:(0, 0, 0, 1)))
        set.insert(T(x64:(0, 0, 0, 0)))
        XCTAssertEqual(set.count,  5)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Zero
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        XCTAssertTrue (T( 0).isZero)
        XCTAssertFalse(T( 1).isZero)
        XCTAssertFalse(T( 2).isZero)
        
        XCTAssertFalse(T(-1).isZero)
        XCTAssertFalse(T(-2).isZero)
        XCTAssertFalse(T(-3).isZero)
    }
    
    func testIsLessThanZero() {
        XCTAssertFalse(T( 0).isLessThanZero)
        XCTAssertFalse(T( 1).isLessThanZero)
        XCTAssertFalse(T( 2).isLessThanZero)
        
        XCTAssertTrue (T(-1).isLessThanZero)
        XCTAssertTrue (T(-2).isLessThanZero)
        XCTAssertTrue (T(-3).isLessThanZero)
    }
    
    func testIsMoreThanZero() {
        XCTAssertFalse(T( 0).isMoreThanZero)
        XCTAssertTrue (T( 1).isMoreThanZero)
        XCTAssertTrue (T( 2).isMoreThanZero)
        
        XCTAssertFalse(T(-1).isMoreThanZero)
        XCTAssertFalse(T(-2).isMoreThanZero)
        XCTAssertFalse(T(-3).isMoreThanZero)
    }
}

//*============================================================================*
// MARK: * UInt256 x Comparison
//*============================================================================*

final class UInt256TestsOnComparison: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testEquating() {
        XCTAssert(T(0) == T(0))
        XCTAssert(T(1) == T(1))
        
        XCTAssert(T(0) != T(1))
        XCTAssert(T(1) != T(0))
        
        XCTAssert(T.min == T.min)
        XCTAssert(T.min != T.max)
        XCTAssert(T.max != T.min)
        XCTAssert(T.max == T.max)
        
        XCTAssertEqual(T(x64:(0, 0, 0, 0)), T(x64:(0, 0, 0, 0)))
        XCTAssertEqual(T(x64:(w, w, w, w)), T(x64:(w, w, w, w)))
    }
    
    func testComparing() {
        XCTAssert(T(0) < T(1))
        XCTAssert(T(1) > T(0))
        XCTAssert(T(1) < T(2))
        XCTAssert(T(2) > T(1))
        
        XCTAssertFalse(T(0) < T(0))
        XCTAssertFalse(T(0) > T(0))
        XCTAssertFalse(T(1) < T(1))
        XCTAssertFalse(T(1) > T(1))
        
        XCTAssert(T.min == T.min)
        XCTAssert(T.min <  T.max)
        XCTAssert(T.max >  T.min)
        XCTAssert(T.max == T.max)
        
        XCTAssert(T(x64:(w, w, w, 0)) < T(x64:(w, w, w, w)))
        XCTAssert(T(x64:(w, w, w, w)) > T(x64:(w, w, w, 0)))
    }
    
    func testHashing() {
        var set = Set<T>()
        set.insert(T(x64:(0, 0, 0, 0)))
        set.insert(T(x64:(1, 0, 0, 0)))
        set.insert(T(x64:(0, 1, 0, 0)))
        set.insert(T(x64:(0, 0, 1, 0)))
        set.insert(T(x64:(0, 0, 0, 1)))
        set.insert(T(x64:(0, 0, 0, 0)))
        XCTAssertEqual(set.count,  5)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Zero
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        XCTAssertTrue (T(0).isZero)
        XCTAssertFalse(T(1).isZero)
        XCTAssertFalse(T(2).isZero)
    }
    
    func testIsLessThanZero() {
        XCTAssertFalse(T(0).isLessThanZero)
        XCTAssertFalse(T(1).isLessThanZero)
        XCTAssertFalse(T(2).isLessThanZero)
    }
    
    func testIsMoreThanZero() {
        XCTAssertFalse(T( 0).isMoreThanZero)
        XCTAssertTrue (T( 1).isMoreThanZero)
        XCTAssertTrue (T( 2).isMoreThanZero)
    }
}

#endif
