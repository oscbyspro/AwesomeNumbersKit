//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

@testable import ANKLargeFixedWidthIntegers
import XCTest

//*============================================================================*
// MARK: * UInt256 x Division x Knuth
//*============================================================================*

final class UInt256TestsOnDivisionAsKnuth: XCTestCase {
    
    typealias T = ANKUInt256
        
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64((UInt64.bitWidth))
    let b = UInt64((UInt64.bitWidth - 1).nonzeroBitCount)
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDividingAsKnuth() {
        var x: T, y: T
        var q: T, r: T
        
        x = T(x64:(2, 4, 6, 8))
        y = T(x64:(1, 2, 0, 0))
        (q, r) = dividingAsKnuth(x, by: y)
        XCTAssertEqual(q, T(x64:(1, 1, 4, 0)))
        XCTAssertEqual(r, T(x64:(1, 1, 0, 0)))
        
        x = T(x64:(2, 3, 4, 5))
        y = T(x64:(4, 5, 0, 0))
        (q, r) = dividingAsKnuth(x, by: y)
        XCTAssertEqual(q, T(x64:(0, 0, 1, 0)))
        XCTAssertEqual(r, T(x64:(2, 3, 0, 0)))

        x = T(x64:(w, ~1, w, 0))
        y = T(x64:(w,  w, 0, 0))
        (q, r) = dividingAsKnuth(x, by: y)        
        XCTAssertEqual(q, T(x64:(~0,  0, 0, 0)))
        XCTAssertEqual(r, T(x64:(~1, ~0, 0, 0)))

        x = T(x64:(0, w, ~1, 0))
        y = T(x64:(w, w,  0, 0))
        (q, r) = dividingAsKnuth(x, by: y)
        XCTAssertEqual(q, T(x64:(~1,  0, 0, 0)))
        XCTAssertEqual(r, T(x64:(~1, ~0, 0, 0)))

        x = T(x64:(0,   2, w/2, 0))
        y = T(x64:(1, w/2,   0, 0))
        (q, r) = dividingAsKnuth(x, by: y)
        XCTAssertEqual(q, T(x64:(0, 1, 0, 0)))
        XCTAssertEqual(r, T(x64:(0, 1, 0, 0)))
        
        x = T(x64:(0,          (0), (s + 1) << (s - 8), 0))
        y = T(x64:(w, 1 << (s - 1),                (0), 0))
        (q, r) = dividingAsKnuth(x, by: y)
        XCTAssertEqual(q, T(x64:((~1) - (s - 1) << (s - 1 - b),                          0, 0, 0)))
        XCTAssertEqual(r, T(x64:((~1) - (s - 1) << (s - 1 - b), (s - 1) << (s - 1 - b) + 2, 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    func dividingAsKnuth(_ dividend: T, by divisor: T) -> (quotient: T, remainder: T) {
        let division  = dividend.body.quotientAndRemainderAsKnuth(dividingBy: divisor.body)
        let quotient  = T(bitPattern: division.quotient )
        let remainder = T(bitPattern: division.remainder)
        return (quotient, remainder)
    }
}

#endif
