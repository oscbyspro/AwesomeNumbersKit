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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256
//*============================================================================*

final class Int256Benchmarks: XCTestCase {
    
    typealias T =  ANKInt256
    typealias M = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T())
        }
    }
    
    func testInitX64() {
        var abc = _blackHoleIdentity(X(1, 2, 3, 4))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(x64: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }

    func testInitX32() {
        var abc = _blackHoleIdentity(Y(1, 2, 3, 4, 5, 6, 7, 8))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(x32: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        var abc = _blackHoleIdentity(true)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(bit: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInitRepeatingBit() {
        var abc = _blackHoleIdentity(true)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(repeating: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Constants
    //=------------------------------------------------------------------------=
    
    @inlinable func testInitMin() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T.min)
        }
    }
    
    @inlinable func testInitMax() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T.max)
        }
    }
    
    @inlinable func testInitZero() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T.zero)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Components
    //=------------------------------------------------------------------------=
    
    func testInitAscending() {
        var abc = _blackHoleIdentity(( T.Low(), T.High() ))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(ascending: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInitDescending() {
        var abc = _blackHoleIdentity(( T.High(), T.Low() ))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(descending: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
}

//*============================================================================*
// MARK: * UInt256
//*============================================================================*

final class UInt256Benchmarks: XCTestCase {
    
    typealias T = ANKUInt256
    typealias M = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        for _ in 0 ..< 1_000_000 {
            _blackHole(T())
        }
    }
    
    func testInitX64() {
        var abc = _blackHoleIdentity(X(1, 2, 3, 4))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(x64: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }

    func testInitX32() {
        var abc = _blackHoleIdentity(Y(1, 2, 3, 4, 5, 6, 7, 8))

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(x32: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        var abc = _blackHoleIdentity(true)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(bit: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInitRepeatingBit() {
        var abc = _blackHoleIdentity(true)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(repeating: abc))
            _blackHoleInoutIdentity(&abc)
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
    // MARK: Tests x Components
    //=------------------------------------------------------------------------=
    
    func testInitAscending() {
        var abc = _blackHoleIdentity(( T.Low(), T.High() ))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(ascending: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInitDescending() {
        var abc = _blackHoleIdentity(( T.High(), T.Low() ))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(descending: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
}

#endif
