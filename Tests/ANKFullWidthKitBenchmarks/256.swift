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
// MARK: * ANK x Int256
//*============================================================================*

final class Int256Benchmarks: XCTestCase {
    
    typealias T =  Int256
    typealias M = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testFromComponents() {
        var abc = ANK.blackHoleIdentity(LH( T.Low .zero, T.High.zero ))
        var xyz = ANK.blackHoleIdentity(HL( T.High.zero, T.Low .zero ))

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(T(ascending:  abc))
            ANK.blackHole(T(descending: xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt256
//*============================================================================*

final class UInt256Benchmarks: XCTestCase {
    
    typealias T = UInt256
    typealias M = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testFromComponents() {
        var abc = ANK.blackHoleIdentity(LH( T.Low .zero, T.High.zero ))
        var xyz = ANK.blackHoleIdentity(HL( T.High.zero, T.Low .zero ))

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(T(ascending:  abc))
            ANK.blackHole(T(descending: xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

#endif
