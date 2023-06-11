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
// MARK: * ANK x Signed x Numbers
//*============================================================================*

final class ANKSignedBenchmarksOnNumbers: XCTestCase {
    
    typealias S =  Int256
    typealias M = UInt256
    
    typealias T = ANKSigned<UInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Signitude
    //=------------------------------------------------------------------------=
    
    func testToSignitude() {
        var abc = ANK.blackHoleIdentity(T(S.min))
        var xyz = ANK.blackHoleIdentity(T(S.max))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(S(exactly:  abc))
            ANK.blackHole(S(exactly:  xyz))
            
            ANK.blackHole(S(clamping: abc))
            ANK.blackHole(S(clamping: xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testFromSignitude() {
        var abc = ANK.blackHoleIdentity(S.min)
        var xyz = ANK.blackHoleIdentity(S.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(exactly:  xyz))
            
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(clamping: xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testToMagnitude() {
        var abc = ANK.blackHoleIdentity(T(S.min))
        var xyz = ANK.blackHoleIdentity(T(S.max))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(M(exactly:  abc))
            ANK.blackHole(M(exactly:  xyz))
            
            ANK.blackHole(M(clamping: abc))
            ANK.blackHole(M(clamping: xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
    
    func testFromMagnitude() {
        var abc = ANK.blackHoleIdentity(M.min)
        var xyz = ANK.blackHoleIdentity(M.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(exactly:  xyz))
            
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(clamping: xyz))
            
            ANK.blackHoleInoutIdentity(&abc)
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

#endif
