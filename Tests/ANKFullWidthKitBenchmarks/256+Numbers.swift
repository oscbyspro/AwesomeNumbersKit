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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Numbers
//*============================================================================*

final class Int256BenchmarksOnNumbers: XCTestCase {
    
    typealias S =  ANKInt256
    typealias T =  ANKInt256
    typealias M = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x [U]Int
    //=------------------------------------------------------------------------=
    
    func testInt() {
        var abc = _blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt() {
        var abc = _blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt8() {
        var abc = _blackHoleIdentity(Int8.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt8() {
        var abc = _blackHoleIdentity(UInt8.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt16() {
        var abc = _blackHoleIdentity(Int16.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt16() {
        var abc = _blackHoleIdentity(UInt16.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt32() {
        var abc = _blackHoleIdentity(Int32.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt32() {
        var abc = _blackHoleIdentity(UInt32.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt64() {
        var abc = _blackHoleIdentity(Int64.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt64() {
        var abc = _blackHoleIdentity(UInt64.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Float
    //=------------------------------------------------------------------------=
    
    func testFloat32() {
        var abc = _blackHoleIdentity(Float32(UInt32.max))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFloat64() {
        var abc = _blackHoleIdentity(Float64(UInt64.max))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testDigit() {
        var abc = _blackHoleIdentity(T.Digit.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(digit: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Complements
    //=------------------------------------------------------------------------=
    
    func testSignitude() {
        var abc = _blackHoleIdentity(S(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testMagnitude() {
        var abc = _blackHoleIdentity(M(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Sign & Magnitude
    //=------------------------------------------------------------------------=
    
    func testSignedMagnitude() {
        var abc = _blackHoleIdentity(ANKSigned(M(x64: X(0, 1, 2, 3)), as: .plus ))
        var xyz = _blackHoleIdentity(ANKSigned(M(x64: X(0, 1, 2, 3)), as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(xyz))

            _blackHole(T(exactly:  abc))
            _blackHole(T(exactly:  xyz))

            _blackHole(T(clamping: abc))
            _blackHole(T(clamping: xyz))
            
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHole(T(truncatingIfNeeded: xyz))
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Numbers
//*============================================================================*

final class UInt256BenchmarksOnNumbers: XCTestCase {
    
    typealias S =  ANKInt256
    typealias T = ANKUInt256
    typealias M = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x [U]Int
    //=------------------------------------------------------------------------=
    
    func testInt() {
        var abc = _blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt() {
        var abc = _blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt8() {
        var abc = _blackHoleIdentity(Int8.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt8() {
        var abc = _blackHoleIdentity(UInt8.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt16() {
        var abc = _blackHoleIdentity(Int16.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt16() {
        var abc = _blackHoleIdentity(UInt16.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt32() {
        var abc = _blackHoleIdentity(Int32.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt32() {
        var abc = _blackHoleIdentity(UInt32.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt64() {
        var abc = _blackHoleIdentity(Int64.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt64() {
        var abc = _blackHoleIdentity(UInt64.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Float
    //=------------------------------------------------------------------------=
    
    func testFloat32() {
        var abc = _blackHoleIdentity(Float32(UInt32.max))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFloat64() {
        var abc = _blackHoleIdentity(Float64(UInt64.max))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testDigit() {
        var abc = _blackHoleIdentity(T.Digit.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(T(digit: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Complements
    //=------------------------------------------------------------------------=
    
    func testSignitude() {
        var abc = _blackHoleIdentity(S(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testMagnitude() {
        var abc = _blackHoleIdentity(M(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole(T(exactly:  abc))
            _blackHole(T(clamping: abc))
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Sign & Magnitude
    //=------------------------------------------------------------------------=
    
    func testSignedMagnitude() {
        var abc = _blackHoleIdentity(ANKSigned(M(x64: X(0, 1, 2, 3)), as: .plus ))
        var xyz = _blackHoleIdentity(ANKSigned(M(x64: X(0, 1, 2, 3)), as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(T(abc))
            _blackHole((    ))

            _blackHole(T(exactly:  abc))
            _blackHole(T(exactly:  xyz))

            _blackHole(T(clamping: abc))
            _blackHole(T(clamping: xyz))
            
            _blackHole(T(truncatingIfNeeded: abc))
            _blackHole(T(truncatingIfNeeded: xyz))
            
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&xyz)
        }
    }
}

#endif
