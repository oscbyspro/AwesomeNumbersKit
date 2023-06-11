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

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * ANK x Int192 x Words
//*============================================================================*

final class Int192BenchmarksOnWords: XCTestCase {
    
    typealias T = Int192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Min Two's Complement
    //=------------------------------------------------------------------------=
    
    func testMinLastIndexReportingIsZeroOrMinusOne() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.minLastIndexReportingIsZeroOrMinusOne())
            ANK.blackHole(xyz.minLastIndexReportingIsZeroOrMinusOne())
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testMinWordCountReportingIsZeroOrMinusOne() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.minWordCountReportingIsZeroOrMinusOne())
            ANK.blackHole(xyz.minWordCountReportingIsZeroOrMinusOne())
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Words
//*============================================================================*

final class UInt192BenchmarksOnWords: XCTestCase {
    
    typealias T = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Min Two's Complement
    //=------------------------------------------------------------------------=
    
    func testMinLastIndexReportingIsZeroOrMinusOne() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.minLastIndexReportingIsZeroOrMinusOne())
            ANK.blackHole(xyz.minLastIndexReportingIsZeroOrMinusOne())
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testMinWordCountReportingIsZeroOrMinusOne() {
        var abc = ANK.blackHoleIdentity( T(x64: X(0, 0, 0)))
        var xyz = ANK.blackHoleIdentity(~T(x64: X(0, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.minWordCountReportingIsZeroOrMinusOne())
            ANK.blackHole(xyz.minWordCountReportingIsZeroOrMinusOne())
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

#endif
