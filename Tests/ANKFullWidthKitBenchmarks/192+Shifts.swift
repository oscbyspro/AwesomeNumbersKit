//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import ANKFoundation
import ANKFullWidthKit
import XCTest

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192 x Bitshifts
//*============================================================================*

final class Int192BenchmarksOnShifts: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeft() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs << rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingLeftByMasking() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &<< rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRight() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs >> rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingRightByMasking() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)
                
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &>> rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Shifts
//*============================================================================*

final class UInt192BenchmarksOnShifts: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeft() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs << rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingLeftByMasking() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &<< rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRight() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs >> rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testBitshiftingRightByMasking() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(UInt.bitWidth * 3/2)
                
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &>> rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
