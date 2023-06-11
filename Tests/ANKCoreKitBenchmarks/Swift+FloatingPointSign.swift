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
import XCTest

//*============================================================================*
// MARK: * ANK x Swift x Floating Point Sign
//*============================================================================*

final class ANKSwiftBenchmarksOnFloatingPointSign: XCTestCase {
    
    typealias T = FloatingPointSign
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Initializers
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        var abc = ANK.blackHoleIdentity(true )
        var xyz = ANK.blackHoleIdentity(false)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Accessors
    //=------------------------------------------------------------------------=
    
    func testBit() {
        var abc = ANK.blackHoleIdentity(T.plus )
        var xyz = ANK.blackHoleIdentity(T.minus)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.bit)
            ANK.blackHole(xyz.bit)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Transformations
    //=------------------------------------------------------------------------=
    
    func testNot() {
        var abc = ANK.blackHoleIdentity(T.plus )
        var xyz = ANK.blackHoleIdentity(T.minus)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(~abc)
            ANK.blackHole(~xyz)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testAnd() {
        var lhs = ANK.blackHoleIdentity(T.plus )
        var rhs = ANK.blackHoleIdentity(T.minus)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs & rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testOr() {
        var lhs = ANK.blackHoleIdentity(T.plus )
        var rhs = ANK.blackHoleIdentity(T.minus)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs | rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testXor() {
        var lhs = ANK.blackHoleIdentity(T.plus )
        var rhs = ANK.blackHoleIdentity(T.minus)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs ^ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
