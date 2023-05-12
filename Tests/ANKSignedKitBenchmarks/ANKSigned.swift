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
// MARK: * ANK x Signed
//*============================================================================*

final class ANKSignedBenchmarks: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
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
    
    func testInitBit() {
        var abc = _blackHoleIdentity(true )
        var xyz = _blackHoleIdentity(false)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(bit: abc))
            _blackHole(T(bit: xyz))
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testInitDigit() {
        var abc = _blackHoleIdentity(D.min)
        var xyz = _blackHoleIdentity(D.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(digit: abc))
            _blackHole(T(digit: xyz))
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Normalization
    //=------------------------------------------------------------------------=
    
    func testIsNormal() {
        var abc = _blackHoleIdentity(T(0, as: .plus ))
        var xyz = _blackHoleIdentity(T(0, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isNormal)
            _blackHole(xyz.isNormal)
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testNormalizedSign() {
        var abc = _blackHoleIdentity(T(0, as: .plus ))
        var xyz = _blackHoleIdentity(T(0, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.normalizedSign)
            _blackHole(xyz.normalizedSign)
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
}

#endif
