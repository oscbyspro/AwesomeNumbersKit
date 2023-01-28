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

//*============================================================================*
// MARK: * Int192 x Numbers
//*============================================================================*

final class Int192BenchmarksOnNumbers: XCTestCase {
    
    typealias S =  ANKInt192
    typealias T =  ANKInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInt() {
        let abc = Int.max
        
        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
            _ = T(clamping: abc)
            _ = T(truncatingIfNeeded: abc)
        }
    }
    
    func testUInt() {
        let abc = UInt.max
        
        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
            _ = T(clamping: abc)
            _ = T(truncatingIfNeeded: abc)
        }
    }
    
    func testSignitude() {
        let abc = S(x64:(0, 1, 2))
        
        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
            _ = T(clamping: abc)
            _ = T(truncatingIfNeeded: abc)
        }
    }
    
    func testMagnitude() {
        let abc = M(x64:(0, 1, 2))
        
        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
            _ = T(clamping: abc)
            _ = T(truncatingIfNeeded: abc)
        }
    }
    
    func testInt64() {
        let abc = Int64.max

        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
            _ = T(clamping: abc)
            _ = T(truncatingIfNeeded: abc)
        }
    }
    
    func testUInt64() {
        let abc = UInt64.max

        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
            _ = T(clamping: abc)
            _ = T(truncatingIfNeeded: abc)
        }
    }
    
    func testFloat64() {
        let abc = Float64(UInt64.max)
        
        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Sign & Magnitude
    //=------------------------------------------------------------------------=
        
    func testSignedMagnitude() {
        let abc = ANKSigned(M(x64:(0, 1, 2)), as: .plus )
        let xyz = ANKSigned(M(x64:(0, 1, 2)), as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(xyz)

            _ = T(exactly:  abc)
            _ = T(exactly:  xyz)

            _ = T(clamping: abc)
            _ = T(clamping: xyz)
            
            _ = T(truncatingIfNeeded: abc)
            _ = T(truncatingIfNeeded: xyz)
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Numbers
//*============================================================================*

final class UInt192BenchmarksOnNumbers: XCTestCase {
    
    typealias S =  ANKInt192
    typealias T = ANKUInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInt() {
        let abc = Int.max
        
        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
            _ = T(clamping: abc)
            _ = T(truncatingIfNeeded: abc)
        }
    }
    
    func testUInt() {
        let abc = UInt.max
        
        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
            _ = T(clamping: abc)
            _ = T(truncatingIfNeeded: abc)
        }
    }
    
    func testSignitude() {
        let abc = S(x64:(0, 1, 2))
        
        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
            _ = T(clamping: abc)
            _ = T(truncatingIfNeeded: abc)
        }
    }
    
    func testMagnitude() {
        let abc = M(x64:(0, 1, 2))
        
        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
            _ = T(clamping: abc)
            _ = T(truncatingIfNeeded: abc)
        }
    }
    
    func testInt64() {
        let abc = Int64.max

        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
            _ = T(clamping: abc)
            _ = T(truncatingIfNeeded: abc)
        }
    }
    
    func testUInt64() {
        let abc = UInt64.max

        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
            _ = T(clamping: abc)
            _ = T(truncatingIfNeeded: abc)
        }
    }
    
    func testFloat64() {
        let abc = Float64(UInt64.max)
        
        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Sign & Magnitude
    //=------------------------------------------------------------------------=
    
    func testSignedMagnitude() {
        let abc = ANKSigned(M(x64:(0, 1, 2)), as: .plus )
        let xyz = ANKSigned(M(x64:(0, 1, 2)), as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = /*-*/

            _ = T(exactly:  abc)
            _ = T(exactly:  xyz)

            _ = T(clamping: abc)
            _ = T(clamping: xyz)
            
            _ = T(truncatingIfNeeded: abc)
            _ = T(truncatingIfNeeded: xyz)
        }
    }
}

#endif
