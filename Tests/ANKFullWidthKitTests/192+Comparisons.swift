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

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * ANK x Int192 x Comparisons
//*============================================================================*

final class Int192TestsOnComparisons: XCTestCase {
    
    typealias T = Int192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testHashing() {
        var union = Set<T>()
        union.insert(T(x64: X(0, 0, 0)))
        union.insert(T(x64: X(1, 0, 0)))
        union.insert(T(x64: X(0, 1, 0)))
        union.insert(T(x64: X(0, 0, 1)))
        union.insert(T(x64: X(0, 0, 0)))
        XCTAssertEqual(union.count, 4)
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
        
        ANKAssertComparisons(T.max, T.max,  Int(0))
        ANKAssertComparisons(T.max, T.min,  Int(1))
        ANKAssertComparisons(T.min, T.max, -Int(1))
        ANKAssertComparisons(T.min, T.min,  Int(0))
        
        ANKAssertComparisons(T(x64: X(0, 2, 3)), T(x64: X(1, 2, 3)), -1)
        ANKAssertComparisons(T(x64: X(1, 0, 3)), T(x64: X(1, 2, 3)), -1)
        ANKAssertComparisons(T(x64: X(1, 2, 0)), T(x64: X(1, 2, 3)), -1)
        ANKAssertComparisons(T(x64: X(0, 2, 3)), T(x64: X(0, 2, 3)),  0)
        ANKAssertComparisons(T(x64: X(1, 0, 3)), T(x64: X(1, 0, 3)),  0)
        ANKAssertComparisons(T(x64: X(1, 2, 0)), T(x64: X(1, 2, 0)),  0)
        ANKAssertComparisons(T(x64: X(1, 2, 3)), T(x64: X(0, 2, 3)),  1)
        ANKAssertComparisons(T(x64: X(1, 2, 3)), T(x64: X(1, 0, 3)),  1)
        ANKAssertComparisons(T(x64: X(1, 2, 3)), T(x64: X(1, 2, 0)),  1)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
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
}

//*============================================================================*
// MARK: * ANK x UInt192 x Comparisons
//*============================================================================*

final class UInt192TestsOnComparisons: XCTestCase {
    
    typealias T = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testHashing() {
        var union = Set<T>()
        union.insert(T(x64: X(0, 0, 0)))
        union.insert(T(x64: X(1, 0, 0)))
        union.insert(T(x64: X(0, 1, 0)))
        union.insert(T(x64: X(0, 0, 1)))
        union.insert(T(x64: X(0, 0, 0)))
        XCTAssertEqual(union.count, 4)
    }
    
    func testComparing() {
        ANKAssertComparisons( T(0),  T(0),  Int(0))
        ANKAssertComparisons( T(1),  T(1),  Int(0))
        ANKAssertComparisons( T(2),  T(3), -Int(1))
        ANKAssertComparisons( T(3),  T(2),  Int(1))
        
        ANKAssertComparisons(T.max, T.max,  Int(0))
        ANKAssertComparisons(T.max, T.min,  Int(1))
        ANKAssertComparisons(T.min, T.max, -Int(1))
        ANKAssertComparisons(T.min, T.min,  Int(0))
        
        ANKAssertComparisons(T(x64: X(0, 2, 3)), T(x64: X(1, 2, 3)), -1)
        ANKAssertComparisons(T(x64: X(1, 0, 3)), T(x64: X(1, 2, 3)), -1)
        ANKAssertComparisons(T(x64: X(1, 2, 0)), T(x64: X(1, 2, 3)), -1)
        ANKAssertComparisons(T(x64: X(0, 2, 3)), T(x64: X(0, 2, 3)),  0)
        ANKAssertComparisons(T(x64: X(1, 0, 3)), T(x64: X(1, 0, 3)),  0)
        ANKAssertComparisons(T(x64: X(1, 2, 0)), T(x64: X(1, 2, 0)),  0)
        ANKAssertComparisons(T(x64: X(1, 2, 3)), T(x64: X(0, 2, 3)),  1)
        ANKAssertComparisons(T(x64: X(1, 2, 3)), T(x64: X(1, 0, 3)),  1)
        ANKAssertComparisons(T(x64: X(1, 2, 3)), T(x64: X(1, 2, 0)),  1)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
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
}

#endif
