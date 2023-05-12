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
// MARK: * Int192 x Shifts
//*============================================================================*

final class Int192TestsOnShifts: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeftByBits() {
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (  0), T(x64: X( 1,  2,  3)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (  1), T(x64: X( 2,  4,  6)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (  2), T(x64: X( 4,  8, 12)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (  3), T(x64: X( 8, 16, 24)))
    }
    
    func testBitshiftingLeftByWords() {
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (  0), T(x64: X( 1,  2,  3)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << ( 64), T(x64: X( 0,  1,  2)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (128), T(x64: X( 0,  0,  1)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (192), T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingLeftByWordsAndBits() {
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (  3), T(x64: X( 8, 16, 24)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << ( 67), T(x64: X( 0,  8, 16)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (131), T(x64: X( 0,  0,  8)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (195), T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingLeftSuchThatWordsSplit() {
        XCTAssertEqual(T(x64: X(~0,  0,  0)) <<  1, T(x64: X(~1,  1,  0)))
        XCTAssertEqual(T(x64: X( 0, ~0,  0)) <<  1, T(x64: X( 0, ~1,  1)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) <<  1, T(x64: X( 0,  0, ~1)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRightByBits() {
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (  0), T(x64: X( 8, 16, 24)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (  1), T(x64: X( 4,  8, 12)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (  2), T(x64: X( 2,  4,  6)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (  3), T(x64: X( 1,  2,  3)))
    }
    
    func testBitshiftingRightByWords() {
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (  0), T(x64: X( 8, 16, 24)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> ( 64), T(x64: X(16, 24,  0)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (128), T(x64: X(24,  0,  0)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (192), T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingRightByWordsAndBits() {
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (  3), T(x64: X( 1,  2,  3)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> ( 67), T(x64: X( 2,  3,  0)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (131), T(x64: X( 3,  0,  0)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (195), T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingRightSuchThatWordsSplit() {
        XCTAssertEqual(T(x64: X(0,  0,  7)) >> (  1), T(x64: X( 0,  1 << 63,  3)))
        XCTAssertEqual(T(x64: X(0,  7,  0)) >> (  1), T(x64: X( 1 << 63,  3,  0)))
        XCTAssertEqual(T(x64: X(7,  0,  0)) >> (  1), T(x64: X( 3,        0,  0)))
    }
    
    func testBitshiftingRightIsSigned() {
        XCTAssertEqual(T(x64: X(0, 0, 1 << 63)) >> (  0), T(x64: X( 0,  0,  1 << 63)))
        XCTAssertEqual(T(x64: X(0, 0, 1 << 63)) >> ( 64), T(x64: X( 0,  1 << 63, ~0)))
        XCTAssertEqual(T(x64: X(0, 0, 1 << 63)) >> (128), T(x64: X( 1 << 63, ~0, ~0)))
        XCTAssertEqual(T(x64: X(0, 0, 1 << 63)) >> (192), T(x64: X(~0,       ~0, ~0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testBitshiftingIsSmart() {
        for _ in 0 ..< 100 {
            let x0 = UInt64.random(in: 0 ..< UInt64.max)
            let x1 = UInt64.random(in: 0 ..< UInt64.max)
            let x2 = UInt64.random(in: 0 ..< UInt64.max)
            let shift = Int.random(in: 0 ..< T.bitWidth)
            let value = T(x64:(x0, x1, x2))
            
            XCTAssertEqual(value << shift, value >> (-shift))
            XCTAssertEqual(value >> shift, value << (-shift))
        }
    }
    
    func testBitshiftingByMinAmountDoesNotTrap() {
        XCTAssertEqual(T(repeating: true) << Int.min, T(repeating: true ))
        XCTAssertEqual(T(repeating: true) >> Int.min, T(repeating: false))
    }
    
    func testBitshiftingByMaskingIsEquivalentToBitshiftingModuloBitWidth() {
        for _ in 0 ..< 100 {
            let x0 = UInt64.random(in: 0 ..< UInt64.max)
            let x1 = UInt64.random(in: 0 ..< UInt64.max)
            let x2 = UInt64.random(in: 0 ..< UInt64.max)
            let shift = Int.random(in: 0 ..< Int.max)
            let value = T(x64:(x0, x1, x2))
            
            XCTAssertEqual(value &<< shift, value << abs(shift % T.bitWidth))
            XCTAssertEqual(value &>> shift, value >> abs(shift % T.bitWidth))
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Shifts
//*============================================================================*

final class UInt192TestsOnShifts: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeftByBits() {
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (  0), T(x64: X( 1,  2,  3)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (  1), T(x64: X( 2,  4,  6)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (  2), T(x64: X( 4,  8, 12)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (  3), T(x64: X( 8, 16, 24)))
    }
    
    func testBitshiftingLeftByWords() {
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (  0), T(x64: X( 1,  2,  3)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << ( 64), T(x64: X( 0,  1,  2)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (128), T(x64: X( 0,  0,  1)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (192), T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingLeftByWordsAndBits() {
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (  3), T(x64: X( 8, 16, 24)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << ( 67), T(x64: X( 0,  8, 16)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (131), T(x64: X( 0,  0,  8)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << (195), T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingLeftSuchThatWordsSplit() {
        XCTAssertEqual(T(x64: X(~0,  0,  0)) <<  1, T(x64: X(~1,  1,  0)))
        XCTAssertEqual(T(x64: X( 0, ~0,  0)) <<  1, T(x64: X( 0, ~1,  1)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) <<  1, T(x64: X( 0,  0, ~1)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRightByBits() {
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (  0), T(x64: X( 8, 16, 24)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (  1), T(x64: X( 4,  8, 12)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (  2), T(x64: X( 2,  4,  6)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (  3), T(x64: X( 1,  2,  3)))
    }
    
    func testBitshiftingRightByWords() {
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (  0), T(x64: X( 8, 16, 24)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> ( 64), T(x64: X(16, 24,  0)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (128), T(x64: X(24,  0,  0)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (192), T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingRightByWordsAndBits() {
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (  3), T(x64: X( 1,  2,  3)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> ( 67), T(x64: X( 2,  3,  0)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (131), T(x64: X( 3,  0,  0)))
        XCTAssertEqual(T(x64: X(8, 16, 24)) >> (195), T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingRightSuchThatWordsSplit() {
        XCTAssertEqual(T(x64: X(0,  0,  7)) >> (  1), T(x64: X( 0,  1 << 63,  3)))
        XCTAssertEqual(T(x64: X(0,  7,  0)) >> (  1), T(x64: X( 1 << 63,  3,  0)))
        XCTAssertEqual(T(x64: X(7,  0,  0)) >> (  1), T(x64: X( 3,        0,  0)))
    }
    
    func testBitshiftingRightIsUnsigned() {
        XCTAssertEqual(T(x64: X(0, 0, 1 << 63)) >> (  0), T(x64: X(0, 0, 1 << 63)))
        XCTAssertEqual(T(x64: X(0, 0, 1 << 63)) >> ( 64), T(x64: X(0, 1 << 63, 0)))
        XCTAssertEqual(T(x64: X(0, 0, 1 << 63)) >> (128), T(x64: X(1 << 63, 0, 0)))
        XCTAssertEqual(T(x64: X(0, 0, 1 << 63)) >> (192), T(x64: X(0,       0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testBitshiftingIsSmart() {
        for _ in 0 ..< 100 {
            let x0 = UInt64.random(in: 0 ..< UInt64.max)
            let x1 = UInt64.random(in: 0 ..< UInt64.max)
            let x2 = UInt64.random(in: 0 ..< UInt64.max)
            let shift = Int.random(in: 0 ..< T.bitWidth)
            let value = T(x64:(x0, x1, x2))
            
            XCTAssertEqual(value << shift, value >> (-shift))
            XCTAssertEqual(value >> shift, value << (-shift))
        }
    }
    
    func testBitshiftingByMinAmountDoesNotTrap() {
        XCTAssertEqual(T(repeating: true) << Int.min, T(repeating: false))
        XCTAssertEqual(T(repeating: true) >> Int.min, T(repeating: false))
    }
    
    func testBitshiftingByMaskingIsEquivalentToBitshiftingModuloBitWidth() {
        for _ in 0 ..< 100 {
            let x0 = UInt64.random(in: 0 ..< UInt64.max)
            let x1 = UInt64.random(in: 0 ..< UInt64.max)
            let x2 = UInt64.random(in: 0 ..< UInt64.max)
            let shift = Int.random(in: 0 ..< Int.max)
            let value = T(x64:(x0, x1, x2))
            
            XCTAssertEqual(value &<< shift, value << abs(shift % T.bitWidth))
            XCTAssertEqual(value &>> shift, value >> abs(shift % T.bitWidth))
        }
    }
}

#endif
