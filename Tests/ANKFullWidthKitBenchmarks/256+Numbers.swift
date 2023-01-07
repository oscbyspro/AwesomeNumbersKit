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
// MARK: * Int256 x Numbers
//*============================================================================*

final class Int256BenchmarksOnNumbers: XCTestCase {
    
    typealias T = ANKInt256
    typealias S = ANKInt256
    typealias M = T.Magnitude
    
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
        let abc = S(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
            _ = T(clamping: abc)
            _ = T(truncatingIfNeeded: abc)
        }
    }
    
    func testMagnitude() {
        let abc = M(x64:(0, 1, 2, 3))
        
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
        let abc = M(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = T(asSignMagnitude: abc, uncheckedIsLessThanZero: false)
            _ = T(asSignMagnitude: abc, uncheckedIsLessThanZero: true )

            _ = T(exactlyAsSignMagnitude:  abc, uncheckedIsLessThanZero: false)
            _ = T(exactlyAsSignMagnitude:  abc, uncheckedIsLessThanZero: true )

            _ = T(clampingAsSignMagnitude: abc, uncheckedIsLessThanZero: false)
            _ = T(clampingAsSignMagnitude: abc, uncheckedIsLessThanZero: true )
            
            _ = T(truncatingIfNeededAsSignMagnitude: abc, uncheckedIsLessThanZero: false)
            _ = T(truncatingIfNeededAsSignMagnitude: abc, uncheckedIsLessThanZero: true )
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Numbers
//*============================================================================*

final class UInt256BenchmarksOnNumbers: XCTestCase {
    
    typealias T = ANKUInt256
    typealias S =  ANKInt256
    typealias M = T.Magnitude
    
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
        let abc = S(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = T(abc)
            _ = T(exactly:  abc)
            _ = T(clamping: abc)
            _ = T(truncatingIfNeeded: abc)
        }
    }
    
    func testMagnitude() {
        let abc = M(x64:(0, 1, 2, 3))
        
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
        let abc = M(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = T(asSignMagnitude: abc, uncheckedIsLessThanZero: false)
            /*-------------------------------------------------------*/

            _ = T(exactlyAsSignMagnitude:  abc, uncheckedIsLessThanZero: false)
            _ = T(exactlyAsSignMagnitude:  abc, uncheckedIsLessThanZero: true )

            _ = T(clampingAsSignMagnitude: abc, uncheckedIsLessThanZero: false)
            _ = T(clampingAsSignMagnitude: abc, uncheckedIsLessThanZero: true )
            
            _ = T(truncatingIfNeededAsSignMagnitude: abc, uncheckedIsLessThanZero: false)
            _ = T(truncatingIfNeededAsSignMagnitude: abc, uncheckedIsLessThanZero: true )
        }
    }
}

#endif
