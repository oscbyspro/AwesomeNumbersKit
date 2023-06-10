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
// MARK: * ANK x Signed x Complements
//*============================================================================*

final class ANKSignedBenchmarksOnComplements: XCTestCase {
    
    typealias T = ANKSigned<UInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        var abc = ANK.blackHoleIdentity(T.max)
        var xyz = ANK.blackHoleIdentity(T.min)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.magnitude)
            ANK.blackHole(xyz.magnitude)
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

#endif
