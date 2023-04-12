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
        var lhs = _blackHoleIdentity(T(1, as: .plus ))
        var rhs = _blackHoleIdentity(T(1, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs < rhs)
            _blackHole(rhs < lhs)
            
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Zero
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        var abc = _blackHoleIdentity(T(1, as: .plus ))
        var xyz = _blackHoleIdentity(T(1, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isZero)
            _blackHole(xyz.isZero)
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testIsLessThanZero() {
        var abc = _blackHoleIdentity(T(1, as: .plus ))
        var xyz = _blackHoleIdentity(T(1, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isLessThanZero)
            _blackHole(xyz.isLessThanZero)
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testIsMoreThanZero() {
        var abc = _blackHoleIdentity(T(1, as: .plus ))
        var xyz = _blackHoleIdentity(T(1, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isMoreThanZero)
            _blackHole(xyz.isMoreThanZero)
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
}

#endif
