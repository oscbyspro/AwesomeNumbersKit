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
// MARK: * ANK x Int192 x Shifts
//*============================================================================*

final class Int192TestsOnShifts: XCTestCase {
    
    typealias S = Int192
    typealias T = Int192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeftByBits() {
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),   0, T(x64: X( 1,  2,  3)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),   1, T(x64: X( 2,  4,  6)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),   2, T(x64: X( 4,  8, 12)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),   3, T(x64: X( 8, 16, 24)))
    }
    
    func testBitshiftingLeftByWords() {
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),   0, T(x64: X( 1,  2,  3)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),  64, T(x64: X( 0,  1,  2)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)), 128, T(x64: X( 0,  0,  1)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)), 192, T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingLeftByWordsAndBits() {
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),   3, T(x64: X( 8, 16, 24)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),  67, T(x64: X( 0,  8, 16)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)), 131, T(x64: X( 0,  0,  8)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)), 195, T(x64: X( 0,  0,  0)))
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
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),   0, T(x64: X( 8, 16, 24)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),   1, T(x64: X( 4,  8, 12)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),   2, T(x64: X( 2,  4,  6)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),   3, T(x64: X( 1,  2,  3)))
    }
    
    func testBitshiftingRightByWords() {
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),   0, T(x64: X( 8, 16, 24)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),  64, T(x64: X(16, 24,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)), 128, T(x64: X(24,  0,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)), 192, T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingRightByWordsAndBits() {
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),   3, T(x64: X( 1,  2,  3)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),  67, T(x64: X( 2,  3,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)), 131, T(x64: X( 3,  0,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)), 195, T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingRightSuchThatWordsSplit() {
        ANKAssertShiftRight(T(x64: X(0,  0,  7)),   1, T(x64: X( 0,  1 << 63,  3)))
        ANKAssertShiftRight(T(x64: X(0,  7,  0)),   1, T(x64: X( 1 << 63,  3,  0)))
        ANKAssertShiftRight(T(x64: X(7,  0,  0)),   1, T(x64: X( 3,        0,  0)))
    }
    
    func testBitshiftingRightIsSigned() {
        ANKAssertShiftRight(T(x64: X(0, 0, 1 << 63)),   0, T(x64: X( 0,  0,  1 << 63)))
        ANKAssertShiftRight(T(x64: X(0, 0, 1 << 63)),  64, T(x64: X( 0,  1 << 63, ~0)))
        ANKAssertShiftRight(T(x64: X(0, 0, 1 << 63)), 128, T(x64: X( 1 << 63, ~0, ~0)))
        ANKAssertShiftRight(T(x64: X(0, 0, 1 << 63)), 192, T(x64: X(~0,       ~0, ~0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testBitshiftingIsSmart() {
        XCTAssertEqual(T(x64: X(1, 2, 3)) <<   1, T(x64: X(2, 4, 6)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) >>  -1, T(x64: X(2, 4, 6)))
        
        XCTAssertEqual(T(x64: X(1, 2, 3)) <<  64, T(x64: X(0, 1, 2)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) >> -64, T(x64: X(0, 1, 2)))
    }
    
    func testBitshiftingByMinAmountDoesNotTrap() {
        XCTAssertEqual(T(repeating: true) << Int.min, T(repeating: true ))
        XCTAssertEqual(T(repeating: true) >> Int.min, T(repeating: false))
    }
    
    func testBitshiftingByMaskingIsEquivalentToBitshiftingModuloBitWidth() {
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3)),  193, T(x64: X(2, 4, 6)), signitude: S.self)
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3)), -191, T(x64: X(2, 4, 6)), signitude: S.self)
        
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3)),  256, T(x64: X(0, 1, 2)), signitude: S.self)
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3)), -128, T(x64: X(0, 1, 2)), signitude: S.self)
        
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6)),  193, T(x64: X(1, 2, 3)), signitude: S.self)
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6)), -191, T(x64: X(1, 2, 3)), signitude: S.self)

        ANKAssertShiftRightByMasking(T(x64: X(1, 2, 3)),  256, T(x64: X(2, 3, 0)), signitude: S.self)
        ANKAssertShiftRightByMasking(T(x64: X(1, 2, 3)), -128, T(x64: X(2, 3, 0)), signitude: S.self)
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Shifts
//*============================================================================*

final class UInt192TestsOnShifts: XCTestCase {
    
    typealias S =  Int192
    typealias T = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeftByBits() {
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),   0, T(x64: X( 1,  2,  3)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),   1, T(x64: X( 2,  4,  6)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),   2, T(x64: X( 4,  8, 12)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),   3, T(x64: X( 8, 16, 24)))
    }
    
    func testBitshiftingLeftByWords() {
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),   0, T(x64: X( 1,  2,  3)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),  64, T(x64: X( 0,  1,  2)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)), 128, T(x64: X( 0,  0,  1)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)), 192, T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingLeftByWordsAndBits() {
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),   3, T(x64: X( 8, 16, 24)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)),  67, T(x64: X( 0,  8, 16)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)), 131, T(x64: X( 0,  0,  8)))
        ANKAssertShiftLeft(T(x64: X(1, 2, 3)), 195, T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingLeftSuchThatWordsSplit() {
        ANKAssertShiftLeft(T(x64: X(~0,  0,  0)),  1, T(x64: X(~1,  1,  0)))
        ANKAssertShiftLeft(T(x64: X( 0, ~0,  0)),  1, T(x64: X( 0, ~1,  1)))
        ANKAssertShiftLeft(T(x64: X( 0,  0, ~0)),  1, T(x64: X( 0,  0, ~1)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRightByBits() {
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),   0, T(x64: X( 8, 16, 24)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),   1, T(x64: X( 4,  8, 12)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),   2, T(x64: X( 2,  4,  6)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),   3, T(x64: X( 1,  2,  3)))
    }
    
    func testBitshiftingRightByWords() {
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),   0, T(x64: X( 8, 16, 24)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),  64, T(x64: X(16, 24,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)), 128, T(x64: X(24,  0,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)), 192, T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingRightByWordsAndBits() {
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),   3, T(x64: X( 1,  2,  3)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)),  67, T(x64: X( 2,  3,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)), 131, T(x64: X( 3,  0,  0)))
        ANKAssertShiftRight(T(x64: X(8, 16, 24)), 195, T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingRightSuchThatWordsSplit() {
        ANKAssertShiftRight(T(x64: X(0,  0,  7)),   1, T(x64: X( 0,  1 << 63,  3)))
        ANKAssertShiftRight(T(x64: X(0,  7,  0)),   1, T(x64: X( 1 << 63,  3,  0)))
        ANKAssertShiftRight(T(x64: X(7,  0,  0)),   1, T(x64: X( 3,        0,  0)))
    }
    
    func testBitshiftingRightIsUnsigned() {
        ANKAssertShiftRight(T(x64: X(0, 0, 1 << 63)),   0, T(x64: X(0, 0, 1 << 63)))
        ANKAssertShiftRight(T(x64: X(0, 0, 1 << 63)),  64, T(x64: X(0, 1 << 63, 0)))
        ANKAssertShiftRight(T(x64: X(0, 0, 1 << 63)), 128, T(x64: X(1 << 63, 0, 0)))
        ANKAssertShiftRight(T(x64: X(0, 0, 1 << 63)), 192, T(x64: X(0,       0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testBitshiftingIsSmart() {
        XCTAssertEqual(T(x64: X(1, 2, 3)) <<   1, T(x64: X(2, 4, 6)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) >>  -1, T(x64: X(2, 4, 6)))
        
        XCTAssertEqual(T(x64: X(1, 2, 3)) <<  64, T(x64: X(0, 1, 2)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) >> -64, T(x64: X(0, 1, 2)))
    }
    
    func testBitshiftingByMinAmountDoesNotTrap() {
        XCTAssertEqual(T(repeating: true) << Int.min, T(repeating: false))
        XCTAssertEqual(T(repeating: true) >> Int.min, T(repeating: false))
    }
    
    func testBitshiftingByMaskingIsEquivalentToBitshiftingModuloBitWidth() {
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3)),  193, T(x64: X(2, 4, 6)), signitude: S.self)
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3)), -191, T(x64: X(2, 4, 6)), signitude: S.self)
        
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3)),  256, T(x64: X(0, 1, 2)), signitude: S.self)
        ANKAssertShiftLeftByMasking (T(x64: X(1, 2, 3)), -128, T(x64: X(0, 1, 2)), signitude: S.self)
        
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6)),  193, T(x64: X(1, 2, 3)), signitude: S.self)
        ANKAssertShiftRightByMasking(T(x64: X(2, 4, 6)), -191, T(x64: X(1, 2, 3)), signitude: S.self)

        ANKAssertShiftRightByMasking(T(x64: X(1, 2, 3)),  256, T(x64: X(2, 3, 0)), signitude: S.self)
        ANKAssertShiftRightByMasking(T(x64: X(1, 2, 3)), -128, T(x64: X(2, 3, 0)), signitude: S.self)
    }
}

#endif
