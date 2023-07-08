//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKCoreKit
import ANKFullWidthKit
import XCTest

private typealias X = ANK.U256X64
private typealias Y = ANK.U256X32

//*============================================================================*
// MARK: * ANK x Int256 x Shifts
//*============================================================================*

final class Int256TestsOnShifts: XCTestCase {
    
    typealias S = Int256
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Left
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeftByBits() {
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),   0, T(x64: X( 1,  2,  3,  4)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),   1, T(x64: X( 2,  4,  6,  8)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),   2, T(x64: X( 4,  8, 12, 16)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),   3, T(x64: X( 8, 16, 24, 32)))
    }
    
    func testBitshiftingLeftByWords() {
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),   0, T(x64: X( 1,  2,  3,  4)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),  64, T(x64: X( 0,  1,  2,  3)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)), 128, T(x64: X( 0,  0,  1,  2)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)), 192, T(x64: X( 0,  0,  0,  1)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)), 256, T(x64: X( 0,  0,  0,  0)))
    }
    
    func testBitshiftingLeftByWordsAndBits() {
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),   3, T(x64: X( 8, 16, 24, 32)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),  67, T(x64: X( 0,  8, 16, 24)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)), 131, T(x64: X( 0,  0,  8, 16)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)), 195, T(x64: X( 0,  0,  0,  8)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)), 259, T(x64: X( 0,  0,  0,  0)))
    }
    
    func testBitshiftingLeftSuchThatWordsSplit() {
        ANKAssertShiftLeft(T(x64: X(~0,  0,  0,  0)),   1, T(x64: X(~1,  1,  0,  0)))
        ANKAssertShiftLeft(T(x64: X( 0, ~0,  0,  0)),   1, T(x64: X( 0, ~1,  1,  0)))
        ANKAssertShiftLeft(T(x64: X( 0,  0, ~0,  0)),   1, T(x64: X( 0,  0, ~1,  1)))
        ANKAssertShiftLeft(T(x64: X( 0,  0,  0, ~0)),   1, T(x64: X( 0,  0,  0, ~1)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Right
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRightByBits() {
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),   0, T(x64: X( 8, 16, 24, 32)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),   1, T(x64: X( 4,  8, 12, 16)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),   2, T(x64: X( 2,  4,  6,  8)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),   3, T(x64: X( 1,  2,  3,  4)))
    }
    
    func testBitshiftingRightByWords() {
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),   0, T(x64: X( 8, 16, 24, 32)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),  64, T(x64: X(16, 24, 32,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)), 128, T(x64: X(24, 32,  0,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)), 192, T(x64: X(32,  0,  0,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)), 256, T(x64: X( 0,  0,  0,  0)))
    }
    
    func testBitshiftingRightByWordsAndBits() {
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),   3, T(x64: X( 1,  2,  3,  4)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),  67, T(x64: X( 2,  3,  4,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)), 131, T(x64: X( 3,  4,  0,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)), 195, T(x64: X( 4,  0,  0,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)), 259, T(x64: X( 0,  0,  0,  0)))
    }
    
    func testBitshiftingRightSuchThatWordsSplit() {
        ANKAssertShiftRight(T(x64: X(0,  0,  0,  7)),   1, T(x64: X( 0,  0,  1 << 63,  3)))
        ANKAssertShiftRight(T(x64: X(0,  0,  7,  0)),   1, T(x64: X( 0,  1 << 63,  3,  0)))
        ANKAssertShiftRight(T(x64: X(0,  7,  0,  0)),   1, T(x64: X( 1 << 63,  3,  0,  0)))
        ANKAssertShiftRight(T(x64: X(7,  0,  0,  0)),   1, T(x64: X( 3,        0,  0,  0)))
    }
    
    func testBitshiftingRightIsSigned() {
        ANKAssertShiftRight(T(x64: X(0, 0, 0, 1 << 63)),   0, T(x64: X( 0,  0,  0,  1 << 63)))
        ANKAssertShiftRight(T(x64: X(0, 0, 0, 1 << 63)),  64, T(x64: X( 0,  0,  1 << 63, ~0)))
        ANKAssertShiftRight(T(x64: X(0, 0, 0, 1 << 63)), 128, T(x64: X( 0,  1 << 63, ~0, ~0)))
        ANKAssertShiftRight(T(x64: X(0, 0, 0, 1 << 63)), 192, T(x64: X( 1 << 63, ~0, ~0, ~0)))
        ANKAssertShiftRight(T(x64: X(0, 0, 0, 1 << 63)), 256, T(x64: X(~0,       ~0, ~0, ~0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testBitshiftingIsSmart() {
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)) <<   1, T(x64: X(2, 4, 6, 8)))
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)) >>  -1, T(x64: X(2, 4, 6, 8)))
        
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)) <<  64, T(x64: X(0, 1, 2, 3)))
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)) >> -64, T(x64: X(0, 1, 2, 3)))
    }
    
    func testBitshiftingByMinAmountDoesNotTrap() {
        XCTAssertEqual(T(repeating: true) << Int.min, T(repeating: true ))
        XCTAssertEqual(T(repeating: true) >> Int.min, T(repeating: false))
    }
    
    func testBitshiftingByMaskingIsEquivalentToBitshiftingModuloBitWidth() {
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3, 4)),  256, T(x64: X(1, 2, 3, 4)), signitude: S.self)
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3, 4)), -256, T(x64: X(1, 2, 3, 4)), signitude: S.self)
        
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3, 4)),  257, T(x64: X(2, 4, 6, 8)), signitude: S.self)
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3, 4)), -255, T(x64: X(2, 4, 6, 8)), signitude: S.self)
        
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3, 4)),  320, T(x64: X(0, 1, 2, 3)), signitude: S.self)
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3, 4)), -192, T(x64: X(0, 1, 2, 3)), signitude: S.self)
        
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6, 8)),  256, T(x64: X(2, 4, 6, 8)), signitude: S.self)
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6, 8)), -256, T(x64: X(2, 4, 6, 8)), signitude: S.self)
        
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6, 8)),  257, T(x64: X(1, 2, 3, 4)), signitude: S.self)
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6, 8)), -255, T(x64: X(1, 2, 3, 4)), signitude: S.self)
        
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6, 8)),  320, T(x64: X(4, 6, 8, 0)), signitude: S.self)
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6, 8)), -192, T(x64: X(4, 6, 8, 0)), signitude: S.self)
    }
}

//*============================================================================*
// MARK: * ANK x UInt256 x Shifts
//*============================================================================*

final class UInt256TestsOnShifts: XCTestCase {
    
    typealias S =  Int256
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Left
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeftByBits() {
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),   0, T(x64: X( 1,  2,  3,  4)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),   1, T(x64: X( 2,  4,  6,  8)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),   2, T(x64: X( 4,  8, 12, 16)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),   3, T(x64: X( 8, 16, 24, 32)))
    }
    
    func testBitshiftingLeftByWords() {
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),   0, T(x64: X( 1,  2,  3,  4)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),  64, T(x64: X( 0,  1,  2,  3)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)), 128, T(x64: X( 0,  0,  1,  2)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)), 192, T(x64: X( 0,  0,  0,  1)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)), 256, T(x64: X( 0,  0,  0,  0)))
    }
    
    func testBitshiftingLeftByWordsAndBits() {
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),   3, T(x64: X( 8, 16, 24, 32)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)),  67, T(x64: X( 0,  8, 16, 24)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)), 131, T(x64: X( 0,  0,  8, 16)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)), 195, T(x64: X( 0,  0,  0,  8)))
        ANKAssertShiftLeft(T(x64: X( 1,  2,  3,  4)), 259, T(x64: X( 0,  0,  0,  0)))
    }
    
    func testBitshiftingLeftSuchThatWordsSplit() {
        ANKAssertShiftLeft(T(x64: X(~0,  0,  0,  0)),   1, T(x64: X(~1,  1,  0,  0)))
        ANKAssertShiftLeft(T(x64: X( 0, ~0,  0,  0)),   1, T(x64: X( 0, ~1,  1,  0)))
        ANKAssertShiftLeft(T(x64: X( 0,  0, ~0,  0)),   1, T(x64: X( 0,  0, ~1,  1)))
        ANKAssertShiftLeft(T(x64: X( 0,  0,  0, ~0)),   1, T(x64: X( 0,  0,  0, ~1)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Right
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRightByBits() {
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),   0, T(x64: X( 8, 16, 24, 32)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),   1, T(x64: X( 4,  8, 12, 16)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),   2, T(x64: X( 2,  4,  6,  8)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),   3, T(x64: X( 1,  2,  3,  4)))
    }
    
    func testBitshiftingRightByWords() {
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),   0, T(x64: X( 8, 16, 24, 32)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),  64, T(x64: X(16, 24, 32,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)), 128, T(x64: X(24, 32,  0,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)), 192, T(x64: X(32,  0,  0,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)), 256, T(x64: X( 0,  0,  0,  0)))
    }
    
    func testBitshiftingRightByWordsAndBits() {
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),   3, T(x64: X( 1,  2,  3,  4)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)),  67, T(x64: X( 2,  3,  4,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)), 131, T(x64: X( 3,  4,  0,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)), 195, T(x64: X( 4,  0,  0,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24, 32)), 259, T(x64: X( 0,  0,  0,  0)))
    }
    
    func testBitshiftingRightSuchThatWordsSplit() {
        ANKAssertShiftRight(T(x64: X(0,  0,  0,  7)),   1, T(x64: X( 0,  0,  1 << 63,  3)))
        ANKAssertShiftRight(T(x64: X(0,  0,  7,  0)),   1, T(x64: X( 0,  1 << 63,  3,  0)))
        ANKAssertShiftRight(T(x64: X(0,  7,  0,  0)),   1, T(x64: X( 1 << 63,  3,  0,  0)))
        ANKAssertShiftRight(T(x64: X(7,  0,  0,  0)),   1, T(x64: X( 3,        0,  0,  0)))
    }
    
    func testBitshiftingRightIsUnsigned() {
        ANKAssertShiftRight(T(x64: X(0, 0, 0, 1 << 63)),   0, T(x64: X(0, 0, 0, 1 << 63)))
        ANKAssertShiftRight(T(x64: X(0, 0, 0, 1 << 63)),  64, T(x64: X(0, 0, 1 << 63, 0)))
        ANKAssertShiftRight(T(x64: X(0, 0, 0, 1 << 63)), 128, T(x64: X(0, 1 << 63, 0, 0)))
        ANKAssertShiftRight(T(x64: X(0, 0, 0, 1 << 63)), 192, T(x64: X(1 << 63, 0, 0, 0)))
        ANKAssertShiftRight(T(x64: X(0, 0, 0, 1 << 63)), 256, T(x64: X(0,       0, 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testBitshiftingIsSmart() {
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)) <<   1, T(x64: X(2, 4, 6, 8)))
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)) >>  -1, T(x64: X(2, 4, 6, 8)))
        
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)) <<  64, T(x64: X(0, 1, 2, 3)))
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)) >> -64, T(x64: X(0, 1, 2, 3)))
    }
    
    func testBitshiftingByMinAmountDoesNotTrap() {
        XCTAssertEqual(T(repeating: true) << Int.min, T(repeating: false))
        XCTAssertEqual(T(repeating: true) >> Int.min, T(repeating: false))
    }
    
    func testBitshiftingByMaskingIsEquivalentToBitshiftingModuloBitWidth() {
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3, 4)),  256, T(x64: X(1, 2, 3, 4)), signitude: S.self)
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3, 4)), -256, T(x64: X(1, 2, 3, 4)), signitude: S.self)
        
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3, 4)),  257, T(x64: X(2, 4, 6, 8)), signitude: S.self)
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3, 4)), -255, T(x64: X(2, 4, 6, 8)), signitude: S.self)
        
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3, 4)),  320, T(x64: X(0, 1, 2, 3)), signitude: S.self)
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3, 4)), -192, T(x64: X(0, 1, 2, 3)), signitude: S.self)
        
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6, 8)),  256, T(x64: X(2, 4, 6, 8)), signitude: S.self)
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6, 8)), -256, T(x64: X(2, 4, 6, 8)), signitude: S.self)
        
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6, 8)),  257, T(x64: X(1, 2, 3, 4)), signitude: S.self)
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6, 8)), -255, T(x64: X(1, 2, 3, 4)), signitude: S.self)
        
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6, 8)),  320, T(x64: X(4, 6, 8, 0)), signitude: S.self)
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6, 8)), -192, T(x64: X(4, 6, 8, 0)), signitude: S.self)
    }
}

#endif
