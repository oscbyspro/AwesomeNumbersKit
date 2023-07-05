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
// MARK: * ANK x Int256 x Bits
//*============================================================================*

final class Int256BenchmarksOnBits: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testFromBit() {
        var abc = ANK.blackHoleIdentity(true )
        var xyz = ANK.blackHoleIdentity(false)
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(T(bit: abc))
            ANK.blackHole(T(bit: xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testFromRepeatingBit() {
        var abc = ANK.blackHoleIdentity(true )
        var xyz = ANK.blackHoleIdentity(false)
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(T(repeating: abc))
            ANK.blackHole(T(repeating: xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Accessors
    //=------------------------------------------------------------------------=
    
    func testBitWidth() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.bitWidth)
            ANK.blackHole(xyz.bitWidth)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testNonzeroBitCount() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.nonzeroBitCount)
            ANK.blackHole(xyz.nonzeroBitCount)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testLeadingZeroBitCount() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.leadingZeroBitCount)
            ANK.blackHole(xyz.leadingZeroBitCount)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testTrailingZeroBitCount() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.trailingZeroBitCount)
            ANK.blackHole(xyz.trailingZeroBitCount)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testMostSignificantBit() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.mostSignificantBit)
            ANK.blackHole(xyz.mostSignificantBit)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testLeastSignificantBit() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.leastSignificantBit)
            ANK.blackHole(xyz.leastSignificantBit)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt256 x Bits
//*============================================================================*

final class UInt256BenchmarksOnBits: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testFromBit() {
        var abc = ANK.blackHoleIdentity(true )
        var xyz = ANK.blackHoleIdentity(false)
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(T(bit: abc))
            ANK.blackHole(T(bit: xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testFromRepeatingBit() {
        var abc = ANK.blackHoleIdentity(true )
        var xyz = ANK.blackHoleIdentity(false)
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(T(repeating: abc))
            ANK.blackHole(T(repeating: xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Accessors
    //=------------------------------------------------------------------------=
    
    func testBitWidth() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.bitWidth)
            ANK.blackHole(xyz.bitWidth)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testNonzeroBitCount() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.nonzeroBitCount)
            ANK.blackHole(xyz.nonzeroBitCount)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testLeadingZeroBitCount() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.leadingZeroBitCount)
            ANK.blackHole(xyz.leadingZeroBitCount)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testTrailingZeroBitCount() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.trailingZeroBitCount)
            ANK.blackHole(xyz.trailingZeroBitCount)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testMostSignificantBit() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.mostSignificantBit)
            ANK.blackHole(xyz.mostSignificantBit)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testLeastSignificantBit() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.leastSignificantBit)
            ANK.blackHole(xyz.leastSignificantBit)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }    
}

#endif
