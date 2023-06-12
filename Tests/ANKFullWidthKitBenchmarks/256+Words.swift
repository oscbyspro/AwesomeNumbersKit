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
// MARK: * ANK x Int256 x Words
//*============================================================================*

final class Int256BenchmarksOnWords: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Min Two's Complement
    //=------------------------------------------------------------------------=
    
    func testMinLastIndexReportingIsZeroOrMinusOne() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.minLastIndexReportingIsZeroOrMinusOne())
            ANK.blackHole(xyz.minLastIndexReportingIsZeroOrMinusOne())
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testMinWordCountReportingIsZeroOrMinusOne() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.minWordCountReportingIsZeroOrMinusOne())
            ANK.blackHole(xyz.minWordCountReportingIsZeroOrMinusOne())
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt256 x Words
//*============================================================================*

final class UInt256BenchmarksOnWords: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Min Two's Complement
    //=------------------------------------------------------------------------=
    
    func testMinLastIndexReportingIsZeroOrMinusOne() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.minLastIndexReportingIsZeroOrMinusOne())
            ANK.blackHole(xyz.minLastIndexReportingIsZeroOrMinusOne())
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testMinWordCountReportingIsZeroOrMinusOne() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.minWordCountReportingIsZeroOrMinusOne())
            ANK.blackHole(xyz.minWordCountReportingIsZeroOrMinusOne())
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

#endif
