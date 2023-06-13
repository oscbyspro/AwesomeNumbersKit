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
import ANKFullWidthKit
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed
//*============================================================================*

final class ANKSignedBenchmarks: XCTestCase {
    
    typealias T = ANKSigned<UInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Normalization
    //=------------------------------------------------------------------------=
    
    func testIsNormal() {
        var abc = ANK.blackHoleIdentity(T(0, as: .plus ))
        var xyz = ANK.blackHoleIdentity(T(0, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.isNormal)
            ANK.blackHole(xyz.isNormal)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testNormalizedSign() {
        var abc = ANK.blackHoleIdentity(T(0, as: .plus ))
        var xyz = ANK.blackHoleIdentity(T(0, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.normalizedSign)
            ANK.blackHole(xyz.normalizedSign)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

#endif
