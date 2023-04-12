//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import ANKFoundation
import ANKFullWidthKit
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Sign
//*============================================================================*

final class ANKSignBenchmarks: XCTestCase {
    
    typealias T = ANKSign
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Initializers
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        var abc = _blackHoleIdentity(true )
        var xyz = _blackHoleIdentity(false)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(xyz))
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testInitWithFloatingPointSign() {
        var abc = _blackHoleIdentity(FloatingPointSign.plus )
        var xyz = _blackHoleIdentity(FloatingPointSign.minus)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(xyz))
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Accessors
    //=------------------------------------------------------------------------=
    
    func testBit() {
        var abc = _blackHoleIdentity(T.plus )
        var xyz = _blackHoleIdentity(T.minus)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.bit)
            _blackHole(xyz.bit)
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testDescription() {
        var abc = _blackHoleIdentity(T.plus )
        var xyz = _blackHoleIdentity(T.minus)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.description)
            _blackHole(xyz.description)
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Transformations
    //=------------------------------------------------------------------------=
    
    func testNot() {
        var abc = _blackHoleIdentity(T.plus )
        var xyz = _blackHoleIdentity(T.minus)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(~abc)
            _blackHole(~xyz)
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testAnd() {
        var lhs = _blackHoleIdentity(T.plus )
        var rhs = _blackHoleIdentity(T.minus)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs & rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testOr() {
        var lhs = _blackHoleIdentity(T.plus )
        var rhs = _blackHoleIdentity(T.minus)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs | rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testXor() {
        var lhs = _blackHoleIdentity(T.plus )
        var rhs = _blackHoleIdentity(T.minus)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs ^ rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
