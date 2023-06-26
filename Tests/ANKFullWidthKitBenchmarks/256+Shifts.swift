//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import ANKCoreKit
import ANKFullWidthKit
import XCTest

private typealias X = ANK.U256X64
private typealias Y = ANK.U256X32

//*============================================================================*
// MARK: * ANK x Int256 x Shifts
//*============================================================================*

final class Int256BenchmarksOnShifts: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Left
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeft() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs << rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingLeftByMasking() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs &<< rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingLeftByWordsAndBits() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity((words: 1, bits: UInt.bitWidth/2))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.bitshiftedLeft(words: rhs.words, bits: rhs.bits))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingLeftByWords() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity((words: 1, bits: UInt.bitWidth/2))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.bitshiftedLeft(words: rhs.words))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Right
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRight() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs >> rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingRightByMasking() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)
                
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs &>> rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingRightByWordsAndBits() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity((words: 1, bits: UInt.bitWidth/2))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.bitshiftedRight(words: rhs.words, bits: rhs.bits))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingRightByWords() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity((words: 1, bits: UInt.bitWidth/2))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.bitshiftedRight(words: rhs.words))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt256 x Shifts
//*============================================================================*

final class UInt256BenchmarksOnShifts: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Left
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeft() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs << rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingLeftByMasking() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs &<< rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingLeftByWordsAndBits() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity((words: 1, bits: UInt.bitWidth/2))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.bitshiftedLeft(words: rhs.words, bits: rhs.bits))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingLeftByWords() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity((words: 1, bits: UInt.bitWidth/2))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.bitshiftedLeft(words: rhs.words))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Right
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRight() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs >> rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingRightByMasking() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)
                
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs &>> rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingRightByWordsAndBits() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity((words: 1, bits: UInt.bitWidth/2))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.bitshiftedRight(words: rhs.words, bits: rhs.bits))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingRightByWords() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity((words: 1, bits: UInt.bitWidth/2))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.bitshiftedRight(words: rhs.words))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
