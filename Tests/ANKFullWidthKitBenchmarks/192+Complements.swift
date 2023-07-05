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

private typealias X = ANK.U192X64
private typealias Y = ANK.U192X32

//*============================================================================*
// MARK: * ANK x Int192 x Complements
//*============================================================================*

final class Int192BenchmarksOnComplements: XCTestCase {
    
    typealias T =  Int192
    typealias M = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit Pattern
    //=------------------------------------------------------------------------=
    
    func testToBitPattern() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0)))

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.bitPattern)
            ANK.blackHole(xyz.bitPattern)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testFromBitPattern() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(T(bitPattern: abc))
            ANK.blackHole(T(bitPattern: xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.magnitude)
            ANK.blackHole(xyz.magnitude)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Two's Complement
    //=------------------------------------------------------------------------=
    
    func testTwosComplement() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0)))

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.twosComplement())
            ANK.blackHole(xyz.twosComplement())
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testTwosComplementSubsequence() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0)))

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.twosComplementSubsequence(true))
            ANK.blackHole(xyz.twosComplementSubsequence(true))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Complements
//*============================================================================*

final class UInt192BenchmarksOnComplements: XCTestCase {
    
    typealias T = UInt192
    typealias M = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit Pattern
    //=------------------------------------------------------------------------=
    
    func testToBitPattern() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0)))

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.bitPattern)
            ANK.blackHole(xyz.bitPattern)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testFromBitPattern() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(T(bitPattern: abc))
            ANK.blackHole(T(bitPattern: xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.magnitude)
            ANK.blackHole(xyz.magnitude)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Two's Complement
    //=------------------------------------------------------------------------=
    
    func testTwosComplement() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0)))

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.twosComplement())
            ANK.blackHole(xyz.twosComplement())
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testTwosComplementSubsequence() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0)))

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(abc.twosComplementSubsequence(true))
            ANK.blackHole(xyz.twosComplementSubsequence(true))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

#endif
