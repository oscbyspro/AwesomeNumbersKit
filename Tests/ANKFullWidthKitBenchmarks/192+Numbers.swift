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
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testZero() {
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(   ))
            ANK.blackHole(T.zero)
        }
    }
    
    func testEdges() {
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T.min)
            ANK.blackHole(T.max)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Integers
    //=------------------------------------------------------------------------=
    
    func testToInt() {
        var abc = ANK.blackHoleIdentity(T(Int.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(Int(abc))
            ANK.blackHole(Int(exactly:  abc))
            ANK.blackHole(Int(clamping: abc))
            ANK.blackHole(Int(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromInt() {
        var abc = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToUInt() {
        var abc = ANK.blackHoleIdentity(T(UInt.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(UInt(abc))
            ANK.blackHole(UInt(exactly:  abc))
            ANK.blackHole(UInt(clamping: abc))
            ANK.blackHole(UInt(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromUInt() {
        var abc = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToInt8() {
        var abc = ANK.blackHoleIdentity(T(Int8.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(Int8(abc))
            ANK.blackHole(Int8(exactly:  abc))
            ANK.blackHole(Int8(clamping: abc))
            ANK.blackHole(Int8(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromInt8() {
        var abc = ANK.blackHoleIdentity(Int8.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToUInt8() {
        var abc = ANK.blackHoleIdentity(T(UInt8.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(UInt8(abc))
            ANK.blackHole(UInt8(exactly:  abc))
            ANK.blackHole(UInt8(clamping: abc))
            ANK.blackHole(UInt8(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromUInt8() {
        var abc = ANK.blackHoleIdentity(UInt8.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToInt16() {
        var abc = ANK.blackHoleIdentity(T(Int16.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(Int16(abc))
            ANK.blackHole(Int16(exactly:  abc))
            ANK.blackHole(Int16(clamping: abc))
            ANK.blackHole(Int16(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromInt16() {
        var abc = ANK.blackHoleIdentity(Int16.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToUInt16() {
        var abc = ANK.blackHoleIdentity(T(UInt16.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(UInt16(abc))
            ANK.blackHole(UInt16(exactly:  abc))
            ANK.blackHole(UInt16(clamping: abc))
            ANK.blackHole(UInt16(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromUInt16() {
        var abc = ANK.blackHoleIdentity(UInt16.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToInt32() {
        var abc = ANK.blackHoleIdentity(T(Int32.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(Int32(abc))
            ANK.blackHole(Int32(exactly:  abc))
            ANK.blackHole(Int32(clamping: abc))
            ANK.blackHole(Int32(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromInt32() {
        var abc = ANK.blackHoleIdentity(Int32.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToUInt32() {
        var abc = ANK.blackHoleIdentity(T(UInt32.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(UInt32(abc))
            ANK.blackHole(UInt32(exactly:  abc))
            ANK.blackHole(UInt32(clamping: abc))
            ANK.blackHole(UInt32(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromUInt32() {
        var abc = ANK.blackHoleIdentity(UInt32.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToInt64() {
        var abc = ANK.blackHoleIdentity(T(Int64.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(Int64(abc))
            ANK.blackHole(Int64(exactly:  abc))
            ANK.blackHole(Int64(clamping: abc))
            ANK.blackHole(Int64(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromInt64() {
        var abc = ANK.blackHoleIdentity(Int64.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToUInt64() {
        var abc = ANK.blackHoleIdentity(T(UInt64.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(UInt64(abc))
            ANK.blackHole(UInt64(exactly:  abc))
            ANK.blackHole(UInt64(clamping: abc))
            ANK.blackHole(UInt64(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromUInt64() {
        var abc = ANK.blackHoleIdentity(UInt64.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Complements
    //=------------------------------------------------------------------------=
    
    func testToDigit() {
        var abc = ANK.blackHoleIdentity(T(T.Digit.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T.Digit(abc))
            ANK.blackHole(T.Digit(exactly:  abc))
            ANK.blackHole(T.Digit(clamping: abc))
            ANK.blackHole(T.Digit(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromDigit() {
        var abc = ANK.blackHoleIdentity(T.Digit.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(digit: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToSignitude() {
        var abc = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))

        for _ in 0 ..< 250_000 {
            ANK.blackHole(S(abc))
            ANK.blackHole(S(exactly:  abc))
            ANK.blackHole(S(clamping: abc))
            ANK.blackHole(S(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromSignitude() {
        var abc = ANK.blackHoleIdentity(S(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToMagnitude() {
        var abc = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(M(abc))
            ANK.blackHole(M(exactly:  abc))
            ANK.blackHole(M(clamping: abc))
            ANK.blackHole(M(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromMagnitude() {
        var abc = ANK.blackHoleIdentity(M(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 250_000 {
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
    
    // TODO: brrr
    func testToFloat16() {
        var abc = ANK.blackHoleIdentity(T.max)
        
        for _ in 0 ..< 1_000 {
            ANK.blackHole(Float16(abc))
            ANK.blackHole(Float16(exactly: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromFloat16() {
        var abc = ANK.blackHoleIdentity(Float16(123))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    // TODO: brrr
    func testToFloat32() {
        var abc = ANK.blackHoleIdentity(T.max)
        
        for _ in 0 ..< 1_000 {
            ANK.blackHole(Float32(abc))
            ANK.blackHole(Float32(exactly: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromFloat32() {
        var abc = ANK.blackHoleIdentity(Float32(UInt32.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    // TODO: brrr
    func testToFloat64() {
        var abc = ANK.blackHoleIdentity(T.max)
        
        for _ in 0 ..< 1_000 {
            ANK.blackHole(Float64(abc))
            ANK.blackHole(Float64(exactly: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromFloat64() {
        var abc = ANK.blackHoleIdentity(Float64(UInt64.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly: abc))
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
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testZero() {
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T(   ))
            ANK.blackHole(T.zero)
        }
    }
    
    func testEdges() {
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(T.min)
            ANK.blackHole(T.max)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Integers
    //=------------------------------------------------------------------------=
    
    func testToInt() {
        var abc = ANK.blackHoleIdentity(T(Int.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(Int(abc))
            ANK.blackHole(Int(exactly:  abc))
            ANK.blackHole(Int(clamping: abc))
            ANK.blackHole(Int(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromInt() {
        var abc = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToUInt() {
        var abc = ANK.blackHoleIdentity(T(UInt.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(UInt(abc))
            ANK.blackHole(UInt(exactly:  abc))
            ANK.blackHole(UInt(clamping: abc))
            ANK.blackHole(UInt(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromUInt() {
        var abc = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToInt8() {
        var abc = ANK.blackHoleIdentity(T(Int8.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(Int8(abc))
            ANK.blackHole(Int8(exactly:  abc))
            ANK.blackHole(Int8(clamping: abc))
            ANK.blackHole(Int8(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromInt8() {
        var abc = ANK.blackHoleIdentity(Int8.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToUInt8() {
        var abc = ANK.blackHoleIdentity(T(UInt8.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(UInt8(abc))
            ANK.blackHole(UInt8(exactly:  abc))
            ANK.blackHole(UInt8(clamping: abc))
            ANK.blackHole(UInt8(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromUInt8() {
        var abc = ANK.blackHoleIdentity(UInt8.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToInt16() {
        var abc = ANK.blackHoleIdentity(T(Int16.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(Int16(abc))
            ANK.blackHole(Int16(exactly:  abc))
            ANK.blackHole(Int16(clamping: abc))
            ANK.blackHole(Int16(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromInt16() {
        var abc = ANK.blackHoleIdentity(Int16.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToUInt16() {
        var abc = ANK.blackHoleIdentity(T(UInt16.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(UInt16(abc))
            ANK.blackHole(UInt16(exactly:  abc))
            ANK.blackHole(UInt16(clamping: abc))
            ANK.blackHole(UInt16(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromUInt16() {
        var abc = ANK.blackHoleIdentity(UInt16.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToInt32() {
        var abc = ANK.blackHoleIdentity(T(Int32.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(Int32(abc))
            ANK.blackHole(Int32(exactly:  abc))
            ANK.blackHole(Int32(clamping: abc))
            ANK.blackHole(Int32(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromInt32() {
        var abc = ANK.blackHoleIdentity(Int32.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToUInt32() {
        var abc = ANK.blackHoleIdentity(T(UInt32.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(UInt32(abc))
            ANK.blackHole(UInt32(exactly:  abc))
            ANK.blackHole(UInt32(clamping: abc))
            ANK.blackHole(UInt32(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromUInt32() {
        var abc = ANK.blackHoleIdentity(UInt32.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToInt64() {
        var abc = ANK.blackHoleIdentity(T(Int64.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(Int64(abc))
            ANK.blackHole(Int64(exactly:  abc))
            ANK.blackHole(Int64(clamping: abc))
            ANK.blackHole(Int64(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromInt64() {
        var abc = ANK.blackHoleIdentity(Int64.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToUInt64() {
        var abc = ANK.blackHoleIdentity(T(UInt64.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(UInt64(abc))
            ANK.blackHole(UInt64(exactly:  abc))
            ANK.blackHole(UInt64(clamping: abc))
            ANK.blackHole(UInt64(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromUInt64() {
        var abc = ANK.blackHoleIdentity(UInt64.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Complements
    //=------------------------------------------------------------------------=
    
    func testToDigit() {
        var abc = ANK.blackHoleIdentity(T(T.Digit.max))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T.Digit(abc))
            ANK.blackHole(T.Digit(exactly:  abc))
            ANK.blackHole(T.Digit(clamping: abc))
            ANK.blackHole(T.Digit(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromDigit() {
        var abc = ANK.blackHoleIdentity(T.Digit.max)

        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(digit: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToSignitude() {
        var abc = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))

        for _ in 0 ..< 250_000 {
            ANK.blackHole(S(abc))
            ANK.blackHole(S(exactly:  abc))
            ANK.blackHole(S(clamping: abc))
            ANK.blackHole(S(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromSignitude() {
        var abc = ANK.blackHoleIdentity(S(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly:  abc))
            ANK.blackHole(T(clamping: abc))
            ANK.blackHole(T(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testToMagnitude() {
        var abc = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(M(abc))
            ANK.blackHole(M(exactly:  abc))
            ANK.blackHole(M(clamping: abc))
            ANK.blackHole(M(truncatingIfNeeded: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromMagnitude() {
        var abc = ANK.blackHoleIdentity(M(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 250_000 {
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
    
    // TODO: brrr
    func testToFloat16() {
        var abc = ANK.blackHoleIdentity(T.max)
        
        for _ in 0 ..< 1_000 {
            ANK.blackHole(Float16(abc))
            ANK.blackHole(Float16(exactly: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromFloat16() {
        var abc = ANK.blackHoleIdentity(Float16(123))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    // TODO: brrr
    func testToFloat32() {
        var abc = ANK.blackHoleIdentity(T.max)
        
        for _ in 0 ..< 1_000 {
            ANK.blackHole(Float32(abc))
            ANK.blackHole(Float32(exactly: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromFloat32() {
        var abc = ANK.blackHoleIdentity(Float32(123))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    // TODO: brrr
    func testToFloat64() {
        var abc = ANK.blackHoleIdentity(T.max)
        
        for _ in 0 ..< 1_000 {
            ANK.blackHole(Float64(abc))
            ANK.blackHole(Float64(exactly: abc))
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testFromFloat64() {
        var abc = ANK.blackHoleIdentity(Float64(123))
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(abc))
            ANK.blackHole(T(exactly: abc))
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
