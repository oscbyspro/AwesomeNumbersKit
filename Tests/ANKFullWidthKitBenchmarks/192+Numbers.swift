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
import XCTest

private typealias X = ANK.U192X64
private typealias Y = ANK.U192X32

//*============================================================================*
// MARK: * ANK x Int192 x Numbers
//*============================================================================*

final class Int192BenchmarksOnNumbers: XCTestCase {
    
    typealias S =  Int192
    typealias T =  Int192
    typealias M = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x [U]Int
    //=------------------------------------------------------------------------=
    
    func testInt() {
        var abc = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt() {
        var abc = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt8() {
        var abc = ANK.blackHoleIdentity(Int8.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt8() {
        var abc = ANK.blackHoleIdentity(UInt8.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt16() {
        var abc = ANK.blackHoleIdentity(Int16.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt16() {
        var abc = ANK.blackHoleIdentity(UInt16.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt32() {
        var abc = ANK.blackHoleIdentity(Int32.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt32() {
        var abc = ANK.blackHoleIdentity(UInt32.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt64() {
        var abc = ANK.blackHoleIdentity(Int64.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt64() {
        var abc = ANK.blackHoleIdentity(UInt64.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Float
    //=------------------------------------------------------------------------=
    
    func testFloat32() {
        var abc = ANK.blackHoleIdentity(Float32(UInt32.max))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFloat64() {
        var abc = ANK.blackHoleIdentity(Float64(UInt64.max))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testDigit() {
        var abc = ANK.blackHoleIdentity(T.Digit.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(digit: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Complements
    //=------------------------------------------------------------------------=
    
    func testSignitude() {
        var abc = ANK.blackHoleIdentity(S(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testMagnitude() {
        var abc = ANK.blackHoleIdentity(M(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Sign & Magnitude
    //=------------------------------------------------------------------------=

    func testSignAndMagnitude() {
        var abc = ANK.blackHoleIdentity((sign: FloatingPointSign.plus,  magnitude: M(x64: X(0, 1, 2))))
        var xyz = ANK.blackHoleIdentity((sign: FloatingPointSign.minus, magnitude: M(x64: X(0, 1, 2))))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T.exactly (sign: abc.sign, magnitude: abc.magnitude))
            ANK.blackHole(T.clamping(sign: abc.sign, magnitude: abc.magnitude))
            ANK.blackHoleInoutIdentity(&abc)
            
            ANK.blackHole(T.exactly (sign: xyz.sign, magnitude: xyz.magnitude))
            ANK.blackHole(T.clamping(sign: xyz.sign, magnitude: xyz.magnitude))
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Numbers
//*============================================================================*

final class UInt192BenchmarksOnNumbers: XCTestCase {
    
    typealias S =  Int192
    typealias T = UInt192
    typealias M = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x [U]Int
    //=------------------------------------------------------------------------=
    
    func testInt() {
        var abc = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt() {
        var abc = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt8() {
        var abc = ANK.blackHoleIdentity(Int8.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt8() {
        var abc = ANK.blackHoleIdentity(UInt8.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt16() {
        var abc = ANK.blackHoleIdentity(Int16.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt16() {
        var abc = ANK.blackHoleIdentity(UInt16.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt32() {
        var abc = ANK.blackHoleIdentity(Int32.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt32() {
        var abc = ANK.blackHoleIdentity(UInt32.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testInt64() {
        var abc = ANK.blackHoleIdentity(Int64.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testUInt64() {
        var abc = ANK.blackHoleIdentity(UInt64.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Float
    //=------------------------------------------------------------------------=
    
    func testFloat32() {
        var abc = ANK.blackHoleIdentity(Float32(UInt32.max))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFloat64() {
        var abc = ANK.blackHoleIdentity(Float64(UInt64.max))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testDigit() {
        var abc = ANK.blackHoleIdentity(T.Digit.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(digit: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Complements
    //=------------------------------------------------------------------------=
    
    func testSignitude() {
        var abc = ANK.blackHoleIdentity(S(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testMagnitude() {
        var abc = ANK.blackHoleIdentity(M(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Sign & Magnitude
    //=------------------------------------------------------------------------=
    
    func testSignAndMagnitude() {
        var abc = ANK.blackHoleIdentity((sign: FloatingPointSign.plus,  magnitude: M(x64: X(0, 1, 2))))
        var xyz = ANK.blackHoleIdentity((sign: FloatingPointSign.minus, magnitude: M(x64: X(0, 1, 2))))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T.exactly (sign: abc.sign, magnitude: abc.magnitude))
            ANK.blackHole(T.clamping(sign: abc.sign, magnitude: abc.magnitude))
            ANK.blackHoleInoutIdentity(&abc)
            
            ANK.blackHole(T.exactly (sign: xyz.sign, magnitude: xyz.magnitude))
            ANK.blackHole(T.clamping(sign: xyz.sign, magnitude: xyz.magnitude))
            ANK.blackHoleInoutIdentity(&xyz)
        }
    }
}

#endif
