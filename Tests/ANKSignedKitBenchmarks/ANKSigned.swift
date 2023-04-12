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
    
    func testInit() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T())
        }
    }
    
    func testInitDigit() {
        var abc = _blackHoleIdentity(T.Digit.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(digit: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit
    //=------------------------------------------------------------------------=
    
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
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Constants
    //=------------------------------------------------------------------------=
    
    func testInitMin() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T.min)
        }
    }
    
    func testInitMax() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T.max)
        }
    }
    
    func testInitZero() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T.zero)
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
