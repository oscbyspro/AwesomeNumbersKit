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
// MARK: * ANK x Int192 x Strides
//*============================================================================*

final class Int192BenchmarksOnStrides: XCTestCase {
    
    typealias T = Int192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdvancedBy() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.advanced(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testDistanceTo() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(~1, ~2, ~3)).advanced(by: Int.max))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.distance(to: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Strides
//*============================================================================*

final class UInt192BenchmarksOnStrides: XCTestCase {
    
    typealias T = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdvancedBy() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.advanced(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testDistanceTo() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(~1, ~2, ~3)).advanced(by: Int.max))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.distance(to: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
