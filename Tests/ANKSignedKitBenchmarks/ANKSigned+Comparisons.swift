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
    
    func testIsEqualTo() {
        var lhs = ANK.blackHoleIdentity(T(1, as: .plus ))
        var rhs = ANK.blackHoleIdentity(T(1, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs == rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testIsLessThan() {
        var lhs = ANK.blackHoleIdentity(T(1, as: .plus ))
        var rhs = ANK.blackHoleIdentity(T(1, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs < rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testComparedTo() {
        var lhs = ANK.blackHoleIdentity(T(1, as: .plus ))
        var rhs = ANK.blackHoleIdentity(T(1, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.compared(to: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Zero
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        var abc = ANK.blackHoleIdentity(T(1, as: .plus ))
        var xyz = ANK.blackHoleIdentity(T(1, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.isZero)
            ANK.blackHole(xyz.isZero)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testIsLessThanZero() {
        var abc = ANK.blackHoleIdentity(T(1, as: .plus ))
        var xyz = ANK.blackHoleIdentity(T(1, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.isLessThanZero)
            ANK.blackHole(xyz.isLessThanZero)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testIsMoreThanZero() {
        var abc = ANK.blackHoleIdentity(T(1, as: .plus ))
        var xyz = ANK.blackHoleIdentity(T(1, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.isMoreThanZero)
            ANK.blackHole(xyz.isMoreThanZero)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

#endif
