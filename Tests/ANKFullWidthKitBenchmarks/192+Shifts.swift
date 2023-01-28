//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import ANKFullWidthKit
import XCTest

//*============================================================================*
// MARK: * Int192 x Bitshifts
//*============================================================================*

final class Int192BenchmarksOnBitwiseShifts: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeft() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = UInt.bitWidth * 3/2

        for _ in 0 ..< 1_000_000 {
            _ = lhs << rhs
        }
    }
    
    func testBitshiftingLeftByMasking() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = UInt.bitWidth * 3/2

        for _ in 0 ..< 1_000_000 {
            _ = lhs &<< rhs
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRight() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = UInt.bitWidth * 3/2

        for _ in 0 ..< 1_000_000 {
            _ = lhs >> rhs
        }
    }
    
    func testBitshiftingRightByMasking() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = UInt.bitWidth * 3/2
                
        for _ in 0 ..< 1_000_000 {
            _ = lhs &>> rhs
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Bitwise x Shifts
//*============================================================================*

final class UInt192BenchmarksOnBitwiseShifts: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeft() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = UInt.bitWidth * 3/2

        for _ in 0 ..< 1_000_000 {
            _ = lhs << rhs
        }
    }
    
    func testBitshiftingLeftByMasking() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = UInt.bitWidth * 3/2
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs &<< rhs
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRight() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = UInt.bitWidth * 3/2

        for _ in 0 ..< 1_000_000 {
            _ = lhs >> rhs
        }
    }
    
    func testBitshiftingRightByMasking() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = UInt.bitWidth * 3/2
                
        for _ in 0 ..< 1_000_000 {
            _ = lhs &>> rhs
        }
    }
}

#endif
