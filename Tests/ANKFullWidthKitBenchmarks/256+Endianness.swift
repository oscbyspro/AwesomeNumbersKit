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
// MARK: * ANK x Int256 x Endianness
//*============================================================================*

final class Int256BenchmarksOnEndianness: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBigEndian() {
        var abc = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.bigEndian)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testLittleEndian() {
        var abc = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.littleEndian)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testByteSwapped() {
        var abc = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.byteSwapped)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt256 x Endianness
//*============================================================================*

final class UInt256BenchmarksOnEndianness: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBigEndian() {
        var abc = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.bigEndian)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testLittleEndian() {
        var abc = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.littleEndian)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testByteSwapped() {
        var abc = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.byteSwapped)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
}

#endif
