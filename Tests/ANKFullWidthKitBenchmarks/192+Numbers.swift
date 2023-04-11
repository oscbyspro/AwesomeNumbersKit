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

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192 x Numbers
//*============================================================================*

final class Int192BenchmarksOnNumbers: XCTestCase {
    
    typealias S =  ANKInt192
    typealias T =  ANKInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x [U]Int
    //=------------------------------------------------------------------------=
    
    func testInt() {
        let abc = _blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testUInt() {
        let abc = _blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testInt8() {
        let abc = _blackHoleIdentity(Int8.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testUInt8() {
        let abc = _blackHoleIdentity(UInt8.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testInt16() {
        let abc = _blackHoleIdentity(Int16.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testUInt16() {
        let abc = _blackHoleIdentity(UInt16.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testInt32() {
        let abc = _blackHoleIdentity(Int32.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testUInt32() {
        let abc = _blackHoleIdentity(UInt32.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testInt64() {
        let abc = _blackHoleIdentity(Int64.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testUInt64() {
        let abc = _blackHoleIdentity(UInt64.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Float
    //=------------------------------------------------------------------------=
    
    func testFloat32() {
        let abc = _blackHoleIdentity(Float32(UInt32.max))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
        }
    }
    
    func testFloat64() {
        let abc = _blackHoleIdentity(Float64(UInt64.max))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Complements
    //=------------------------------------------------------------------------=
    
    func testSignitude() {
        let abc = _blackHoleIdentity(S(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testMagnitude() {
        let abc = _blackHoleIdentity(M(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Sign & Magnitude
    //=------------------------------------------------------------------------=
        
    func testSignedMagnitude() {
        let abc = _blackHoleIdentity(ANKSigned(M(x64: X(0, 1, 2)), as: .plus ))
        let xyz = _blackHoleIdentity(ANKSigned(M(x64: X(0, 1, 2)), as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(xyz))

            _blackHole(T(exactly:  abc))
            _blackHole(T(exactly:  xyz))

            _blackHole(T(clamping: abc))
            _blackHole(T(clamping: xyz))
            
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHole(T(truncatingIfNeeded: xyz))
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
    // MARK: Tests x [U]Int
    //=------------------------------------------------------------------------=
    
    func testInt() {
        let abc = _blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testUInt() {
        let abc = _blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testInt8() {
        let abc = _blackHoleIdentity(Int8.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testUInt8() {
        let abc = _blackHoleIdentity(UInt8.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testInt16() {
        let abc = _blackHoleIdentity(Int16.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testUInt16() {
        let abc = _blackHoleIdentity(UInt16.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testInt32() {
        let abc = _blackHoleIdentity(Int32.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testUInt32() {
        let abc = _blackHoleIdentity(UInt32.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testInt64() {
        let abc = _blackHoleIdentity(Int64.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testUInt64() {
        let abc = _blackHoleIdentity(UInt64.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Float
    //=------------------------------------------------------------------------=
    
    func testFloat32() {
        let abc = _blackHoleIdentity(Float32(UInt32.max))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
        }
    }
    
    func testFloat64() {
        let abc = _blackHoleIdentity(Float64(UInt64.max))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Complements
    //=------------------------------------------------------------------------=
    
    func testSignitude() {
        let abc = _blackHoleIdentity(S(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    func testMagnitude() {
        let abc = _blackHoleIdentity(M(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Sign & Magnitude
    //=------------------------------------------------------------------------=
    
    func testSignedMagnitude() {
        let abc = _blackHoleIdentity(ANKSigned(M(x64: X(0, 1, 2)), as: .plus ))
        let xyz = _blackHoleIdentity(ANKSigned(M(x64: X(0, 1, 2)), as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole((    ))
            
            _blackHole(T(exactly:  abc))
            _blackHole(T(exactly:  xyz))

            _blackHole(T(clamping: abc))
            _blackHole(T(clamping: xyz))
            
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHole(T(truncatingIfNeeded: xyz))
        }
    }
}

#endif
