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
// MARK: * ANK x Signed x Comparisons
//*============================================================================*

final class ANKSignedBenchmarksOnComparisons: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsLessThan() {
        let lhs = _blackHoleIdentity(T(1, as: .plus ))
        let rhs = _blackHoleIdentity(T(1, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs < rhs)
            _blackHole(rhs < lhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Zero
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        let abc = _blackHoleIdentity(T(1, as: .plus ))
        let xyz = _blackHoleIdentity(T(1, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isZero)
            _blackHole(xyz.isZero)
        }
    }
    
    func testIsLessThanZero() {
        let abc = _blackHoleIdentity(T(1, as: .plus ))
        let xyz = _blackHoleIdentity(T(1, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isLessThanZero)
            _blackHole(xyz.isLessThanZero)
        }
    }
    
    func testIsMoreThanZero() {
        let abc = _blackHoleIdentity(T(1, as: .plus ))
        let xyz = _blackHoleIdentity(T(1, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isMoreThanZero)
            _blackHole(xyz.isMoreThanZero)
        }
    }
}

#endif
