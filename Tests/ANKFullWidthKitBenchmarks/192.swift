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
import XCTest

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192
//*============================================================================*

final class Int192Benchmarks: XCTestCase {
    
    typealias T =  ANKInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInitZero() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(   ))
            _blackHole(T.zero)
        }
    }
    
    func testInitEdges() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T.min )
            _blackHole(T.max )
        }
    }
    
    func testInitComponents() {
        var abc = _blackHoleIdentity(LH( T.Low (), T.High() ))
        var xyz = _blackHoleIdentity(HL( T.High(), T.Low () ))

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(ascending:  abc))
            _blackHole(T(descending: xyz))
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
}

//*============================================================================*
// MARK: * UInt192
//*============================================================================*

final class UInt192Benchmarks: XCTestCase {
    
    typealias T = ANKUInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInitZero() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(   ))
            _blackHole(T.zero)
        }
    }
    
    func testInitEdges() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T.min )
            _blackHole(T.max )
        }
    }
    
    func testInitComponents() {
        var abc = _blackHoleIdentity(LH( T.Low (), T.High() ))
        var xyz = _blackHoleIdentity(HL( T.High(), T.Low () ))

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(ascending:  abc))
            _blackHole(T(descending: xyz))
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
}

#endif
