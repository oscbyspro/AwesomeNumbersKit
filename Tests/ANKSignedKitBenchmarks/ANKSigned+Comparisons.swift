//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

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
        let lhs = T(1, as: .plus )
        let rhs = T(1, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs < rhs
            _ = rhs < lhs
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Zero
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        let abc = T(1, as: .plus )
        let xyz = T(1, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.isZero
            _ = xyz.isZero
        }
    }
    
    func testIsLessThanZero() {
        let abc = T(1, as: .plus )
        let xyz = T(1, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.isLessThanZero
            _ = xyz.isLessThanZero
        }
    }
    
    func testIsMoreThanZero() {
        let abc = T(1, as: .plus )
        let xyz = T(1, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.isMoreThanZero
            _ = xyz.isMoreThanZero
        }
    }
}

#endif
