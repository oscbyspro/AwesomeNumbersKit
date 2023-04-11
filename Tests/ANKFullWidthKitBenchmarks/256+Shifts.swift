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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Bitshifts
//*============================================================================*

final class Int256BenchmarksOnShifts: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeft() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs << rhs)
        }
    }
    
    func testBitshiftingLeftByMasking() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs &<< rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRight() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs >> rhs)
        }
    }
    
    func testBitshiftingRightByMasking() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(UInt.bitWidth * 3/2)
                
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs &>> rhs)
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Shifts
//*============================================================================*

final class UInt256BenchmarksOnShifts: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeft() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs << rhs)
        }
    }
    
    func testBitshiftingLeftByMasking() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(UInt.bitWidth * 3/2)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs &<< rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRight() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(UInt.bitWidth * 3/2)

        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs >> rhs)
        }
    }
    
    func testBitshiftingRightByMasking() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(UInt.bitWidth * 3/2)
                
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs &>> rhs)
        }
    }
}

#endif
