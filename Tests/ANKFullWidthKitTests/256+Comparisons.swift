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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Comparisons
//*============================================================================*

final class Int256TestsOnComparisons: XCTestCase {
    
    typealias T = ANKInt256
    
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

        XCTAssertEqual(T(x64: X( 0,  0,  0, 0 )), T(x64: X( 0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~0, ~0, ~0, ~0)))
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
        
        XCTAssert(T(x64: X(~0, ~0,  0,  0)) < T(x64: X(~0, ~0, ~0,  0)))
        XCTAssert(T(x64: X(~0, ~0, ~0,  0)) > T(x64: X(~0, ~0,  0,  0)))
        
        XCTAssert(T(x64: X(~0, ~0, ~0,  0)) > T(x64: X(~0, ~0, ~0, ~0)))
        XCTAssert(T(x64: X(~0, ~0, ~0, ~0)) < T(x64: X(~0, ~0, ~0,  0)))
    }
    
    func testHashing() {
        var set = Set<T>()
        set.insert(T(x64: X(0, 0, 0, 0)))
        set.insert(T(x64: X(1, 0, 0, 0)))
        set.insert(T(x64: X(0, 1, 0, 0)))
        set.insert(T(x64: X(0, 0, 1, 0)))
        set.insert(T(x64: X(0, 0, 0, 1)))
        set.insert(T(x64: X(0, 0, 0, 0)))
        XCTAssertEqual(set.count,  5)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsFull() {
        XCTAssertFalse(( T(0)).isFull)
        XCTAssertFalse(( T(1)).isFull)
        XCTAssertFalse(( T(2)).isFull)
        
        XCTAssertTrue ((~T(0)).isFull)
        XCTAssertFalse((~T(1)).isFull)
        XCTAssertFalse((~T(2)).isFull)
    }
    
    func testIsZero() {
        XCTAssertTrue (( T(0)).isZero)
        XCTAssertFalse(( T(1)).isZero)
        XCTAssertFalse(( T(2)).isZero)
        
        XCTAssertFalse((~T(0)).isZero)
        XCTAssertFalse((~T(1)).isZero)
        XCTAssertFalse((~T(2)).isZero)
    }
    
    func testIsLessThanZero() {
        XCTAssertFalse(( T(0)).isLessThanZero)
        XCTAssertFalse(( T(1)).isLessThanZero)
        XCTAssertFalse(( T(2)).isLessThanZero)
        
        XCTAssertTrue ((~T(0)).isLessThanZero)
        XCTAssertTrue ((~T(1)).isLessThanZero)
        XCTAssertTrue ((~T(2)).isLessThanZero)
    }
    
    func testIsMoreThanZero() {
        XCTAssertFalse(( T(0)).isMoreThanZero)
        XCTAssertTrue (( T(1)).isMoreThanZero)
        XCTAssertTrue (( T(2)).isMoreThanZero)
        
        XCTAssertFalse((~T(0)).isMoreThanZero)
        XCTAssertFalse((~T(1)).isMoreThanZero)
        XCTAssertFalse((~T(2)).isMoreThanZero)
    }
    
    func testIsOdd() {
        XCTAssertFalse(( T(0)).isOdd)
        XCTAssertTrue (( T(1)).isOdd)
        XCTAssertFalse(( T(2)).isOdd)
        
        XCTAssertTrue ((~T(0)).isOdd)
        XCTAssertFalse((~T(1)).isOdd)
        XCTAssertTrue ((~T(2)).isOdd)
    }
    
    func testIsEven() {
        XCTAssertTrue (( T(0)).isEven)
        XCTAssertFalse(( T(1)).isEven)
        XCTAssertTrue (( T(2)).isEven)
        
        XCTAssertFalse((~T(0)).isEven)
        XCTAssertTrue ((~T(1)).isEven)
        XCTAssertFalse((~T(2)).isEven)
    }
    
    func testSignum() {
        XCTAssertEqual(( T(0)).signum(), Int( 0))
        XCTAssertEqual(( T(1)).signum(), Int( 1))
        XCTAssertEqual(( T(2)).signum(), Int( 1))
        
        XCTAssertEqual((~T(0)).signum(), Int(-1))
        XCTAssertEqual((~T(1)).signum(), Int(-1))
        XCTAssertEqual((~T(2)).signum(), Int(-1))
    }
    
    func testMatchesRepeatingBit() {
        XCTAssertFalse(( T(0)).matches(repeating: true ))
        XCTAssertTrue (( T(0)).matches(repeating: false))
        XCTAssertTrue ((~T(0)).matches(repeating: true ))
        XCTAssertFalse((~T(0)).matches(repeating: false))
    }
}

//*============================================================================*
// MARK: * UInt256 x Comparisons
//*============================================================================*

final class UInt256TestsOnComparisons: XCTestCase {
    
    typealias T = ANKUInt256
    
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
        
        XCTAssertEqual(T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~0, ~0, ~0, ~0)))
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
        
        XCTAssert(T(x64: X(~0, ~0, ~0,  0)) < T(x64: X(~0, ~0, ~0, ~0)))
        XCTAssert(T(x64: X(~0, ~0, ~0, ~0)) > T(x64: X(~0, ~0, ~0,  0)))
    }
    
    func testHashing() {
        var set = Set<T>()
        set.insert(T(x64: X(0, 0, 0, 0)))
        set.insert(T(x64: X(1, 0, 0, 0)))
        set.insert(T(x64: X(0, 1, 0, 0)))
        set.insert(T(x64: X(0, 0, 1, 0)))
        set.insert(T(x64: X(0, 0, 0, 1)))
        set.insert(T(x64: X(0, 0, 0, 0)))
        XCTAssertEqual(set.count, 5)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsFull() {
        XCTAssertFalse(( T(0)).isFull)
        XCTAssertFalse(( T(1)).isFull)
        XCTAssertFalse(( T(2)).isFull)
        
        XCTAssertTrue ((~T(0)).isFull)
        XCTAssertFalse((~T(1)).isFull)
        XCTAssertFalse((~T(2)).isFull)
    }
    
    func testIsZero() {
        XCTAssertTrue (( T(0)).isZero)
        XCTAssertFalse(( T(1)).isZero)
        XCTAssertFalse(( T(2)).isZero)
        
        XCTAssertFalse((~T(0)).isZero)
        XCTAssertFalse((~T(1)).isZero)
        XCTAssertFalse((~T(2)).isZero)
    }
    
    func testIsLessThanZero() {
        XCTAssertFalse(( T(0)).isLessThanZero)
        XCTAssertFalse(( T(1)).isLessThanZero)
        XCTAssertFalse(( T(2)).isLessThanZero)
        
        XCTAssertFalse((~T(0)).isLessThanZero)
        XCTAssertFalse((~T(1)).isLessThanZero)
        XCTAssertFalse((~T(2)).isLessThanZero)
    }
    
    func testIsMoreThanZero() {
        XCTAssertFalse(( T(0)).isMoreThanZero)
        XCTAssertTrue (( T(1)).isMoreThanZero)
        XCTAssertTrue (( T(2)).isMoreThanZero)
        
        XCTAssertTrue ((~T(0)).isMoreThanZero)
        XCTAssertTrue ((~T(1)).isMoreThanZero)
        XCTAssertTrue ((~T(2)).isMoreThanZero)
    }
    
    func testIsOdd() {
        XCTAssertFalse(( T(0)).isOdd)
        XCTAssertTrue (( T(1)).isOdd)
        XCTAssertFalse(( T(2)).isOdd)
        
        XCTAssertTrue ((~T(0)).isOdd)
        XCTAssertFalse((~T(1)).isOdd)
        XCTAssertTrue ((~T(2)).isOdd)
    }
    
    func testIsEven() {
        XCTAssertTrue (( T(0)).isEven)
        XCTAssertFalse(( T(1)).isEven)
        XCTAssertTrue (( T(2)).isEven)
        
        XCTAssertFalse((~T(0)).isEven)
        XCTAssertTrue ((~T(1)).isEven)
        XCTAssertFalse((~T(2)).isEven)
    }
    
    func testSignum() {
        XCTAssertEqual(( T(0)).signum(), Int(0))
        XCTAssertEqual(( T(1)).signum(), Int(1))
        XCTAssertEqual(( T(2)).signum(), Int(1))
        
        XCTAssertEqual((~T(0)).signum(), Int(1))
        XCTAssertEqual((~T(1)).signum(), Int(1))
        XCTAssertEqual((~T(2)).signum(), Int(1))
    }
    
    func testMatchesRepeatingBit() {
        XCTAssertFalse(( T(0)).matches(repeating: true ))
        XCTAssertTrue (( T(0)).matches(repeating: false))
        XCTAssertTrue ((~T(0)).matches(repeating: true ))
        XCTAssertFalse((~T(0)).matches(repeating: false))
    }
}

#endif
