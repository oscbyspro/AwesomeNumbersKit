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
// MARK: * Int192 x Complements
//*============================================================================*

final class Int192BenchmarksOnComplements: XCTestCase {
    
    typealias T =  ANKInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit Pattern
    //=------------------------------------------------------------------------=
    
    func testInitBitPattern() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(bitPattern: M.max))
        }
    }
    
    func testValueAsBitPattern() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T.max.bitPattern)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        let abc = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.magnitude)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Two's Complement
    //=------------------------------------------------------------------------=
    
    func testTwosComplement() {
        let abc = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.twosComplement())
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Complements
//*============================================================================*

final class UInt192BenchmarksOnComplements: XCTestCase {
    
    typealias T = ANKUInt192
    typealias M = ANKUInt192

    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit Pattern
    //=------------------------------------------------------------------------=
    
    func testInitBitPattern() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(bitPattern: M.max))
        }
    }
    
    func testValueAsBitPattern() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T.max.bitPattern)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        let abc = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.magnitude)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Two's Complement
    //=------------------------------------------------------------------------=
    
    func testTwosComplement() {
        let abc = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.twosComplement())
        }
    }
}

#endif
