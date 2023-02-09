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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256
//*============================================================================*

final class Int256Benchmarks: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        for _ in 0 ..< 1_000_000 {
            _ = T()
        }
    }
    
    func testInitX64() {
        for _ in 0 ..< 1_000_000 {
            _ = T(x64: X(1, 2, 3, 4))
        }
    }

    func testInitX32() {
        for _ in 0 ..< 1_000_000 {
            _ = T(x32: Y(1, 2, 3, 4, 5, 6, 7, 8))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        for _ in 0 ..< 1_000_000 {
            _ = T(bit: true)
        }
    }
    
    func testInitRepeatingBit() {
        for _ in 0 ..< 1_000_000 {
            _ = T(repeating: true)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Constants
    //=------------------------------------------------------------------------=
    
    @inlinable func testInitMin() {
        for _ in 0 ..< 1_000_000 {
            _ = T.min
        }
    }
    
    @inlinable func testInitMax() {
        for _ in 0 ..< 1_000_000 {
            _ = T.max
        }
    }
    
    @inlinable func testInitZero() {
        for _ in 0 ..< 1_000_000 {
            _ = T.zero
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Components
    //=------------------------------------------------------------------------=
    
    func testInitAscending() {
        for _ in 0 ..< 1_000_000 {
            _ = T(ascending:(ANKUInt128(), ANKInt128()))
        }
    }
    
    func testInitDescending() {
        for _ in 0 ..< 1_000_000 {
            _ = T(descending:(ANKInt128(), ANKUInt128()))
        }
    }
}

//*============================================================================*
// MARK: * UInt256
//*============================================================================*

final class UInt256Benchmarks: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        for _ in 0 ..< 1_000_000 {
            _ = T()
        }
    }
    
    func testInitX64() {
        for _ in 0 ..< 1_000_000 {
            _ = T(x64: X(1, 2, 3, 4))
        }
    }

    func testInitX32() {
        for _ in 0 ..< 1_000_000 {
            _ = T(x32: Y(1, 2, 3, 4, 5, 6, 7, 8))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        for _ in 0 ..< 1_000_000 {
            _ = T(bit: true)
        }
    }
    
    func testInitRepeatingBit() {
        for _ in 0 ..< 1_000_000 {
            _ = T(repeating: true)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Constants
    //=------------------------------------------------------------------------=
    
    @inlinable func testInitMin() {
        for _ in 0 ..< 1_000_000 {
            _ = T.min
        }
    }
    
    @inlinable func testInitMax() {
        for _ in 0 ..< 1_000_000 {
            _ = T.max
        }
    }
    
    @inlinable func testInitZero() {
        for _ in 0 ..< 1_000_000 {
            _ = T.zero
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Components
    //=------------------------------------------------------------------------=
    
    func testInitAscending() {
        for _ in 0 ..< 1_000_000 {
            _ = T(ascending:(ANKUInt128(), ANKUInt128()))
        }
    }
    
    func testInitDescending() {
        for _ in 0 ..< 1_000_000 {
            _ = T(descending:(ANKUInt128(), ANKUInt128()))
        }
    }
}

#endif
