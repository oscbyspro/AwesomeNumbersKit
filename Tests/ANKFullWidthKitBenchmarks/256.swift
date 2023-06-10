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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256
//*============================================================================*

final class Int256Benchmarks: XCTestCase {
    
    typealias T =  Int256
    typealias M = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInitZero() {
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(   ))
            ANK.blackHole(T.zero)
        }
    }
    
    func testInitEdges() {
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T.min )
            ANK.blackHole(T.max )
        }
    }
    
    func testInitComponents() {
        var abc = ANK.blackHoleIdentity(LH( T.Low (), T.High() ))
        var xyz = ANK.blackHoleIdentity(HL( T.High(), T.Low () ))

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(ascending:  abc))
            ANK.blackHole(T(descending: xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

//*============================================================================*
// MARK: * UInt256
//*============================================================================*

final class UInt256Benchmarks: XCTestCase {
    
    typealias T = UInt256
    typealias M = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInitZero() {
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(   ))
            ANK.blackHole(T.zero)
        }
    }
    
    func testInitEdges() {
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T.min )
            ANK.blackHole(T.max )
        }
    }
    
    func testInitComponents() {
        var abc = ANK.blackHoleIdentity(LH( T.Low (), T.High() ))
        var xyz = ANK.blackHoleIdentity(HL( T.High(), T.Low () ))

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(ascending:  abc))
            ANK.blackHole(T(descending: xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

#endif
