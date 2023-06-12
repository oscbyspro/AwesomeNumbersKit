//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKCoreKit
@testable import ANKFullWidthKit
import XCTest

private typealias X = ANK.U256X64
private typealias Y = ANK.U256X32

//*============================================================================*
// MARK: * ANK x Int256 x Numbers
//*============================================================================*

final class Int256TestsOnNumbers: XCTestCase {
    
    typealias S =  Int256
    typealias T =  Int256
    typealias M = UInt256
    
    typealias S2 = S.DoubleWidth
    typealias T2 = T.DoubleWidth
    typealias M2 = M.DoubleWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Literal
    //=------------------------------------------------------------------------=
    
    func testFromLiteral() {
        XCTAssertEqual(T(x64:( 0,  0,  0,  0)),  0)
        XCTAssertEqual(T(x64:(~0,  0,  0,  0)),  18446744073709551615)
        XCTAssertEqual(T(x64:(~0, ~0,  0,  0)),  340282366920938463463374607431768211455)
        XCTAssertEqual(T(x64:(~0, ~0, ~0,  0)),  6277101735386680763835789423207666416102355444464034512895)
        XCTAssertEqual(T(x64:(~0, ~0, ~0, ~0)), -1)
        
        XCTAssertEqual(T.min, -57896044618658097711785492504343953926634992332820282019728792003956564819968)
        XCTAssertEqual(T.max,  57896044618658097711785492504343953926634992332820282019728792003956564819967)
        
        XCTAssertNil(T(exactlyIntegerLiteral: -57896044618658097711785492504343953926634992332820282019728792003956564819969))
        XCTAssertNil(T(exactlyIntegerLiteral:  57896044618658097711785492504343953926634992332820282019728792003956564819968))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int, Digit
    //=------------------------------------------------------------------------=
    
    func testFromInt() {
        ANKAssertNumbers(from: Int.min, default: ~T(x64: X(UInt64(Int.max), 0, 0, 0)))
        ANKAssertNumbers(from: Int.max, default:  T(x64: X(UInt64(Int.max), 0, 0, 0)))
    }
    
    func testFromIntAsDigit() {
        XCTAssertEqual(T(digit: Int.min), ~T(x64: X(UInt64(Int.max), 0, 0, 0)))
        XCTAssertEqual(T(digit: Int.max),  T(x64: X(UInt64(Int.max), 0, 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt
    //=------------------------------------------------------------------------=
    
    func testFromUInt() {
        ANKAssertNumbers(from: UInt.min, default: T(x64: X(UInt64(UInt.min), 0, 0, 0)))
        ANKAssertNumbers(from: UInt.max, default: T(x64: X(UInt64(UInt.max), 0, 0, 0)))
    }
    
    func testFromUIntAsBits() {
        XCTAssertEqual(T(_truncatingBits: UInt.min), T(x64: X(UInt64(UInt.min), 0, 0, 0)))
        XCTAssertEqual(T(_truncatingBits: UInt.max), T(x64: X(UInt64(UInt.max), 0, 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int8
    //=------------------------------------------------------------------------=
    
    func testFromInt8() {
        ANKAssertNumbers(from: Int8.min, default: T(-128))
        ANKAssertNumbers(from: Int8.max, default: T( 127))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt8
    //=------------------------------------------------------------------------=
    
    func testFromUInt8() {
        ANKAssertNumbers(from: UInt8.min, default: T())
        ANKAssertNumbers(from: UInt8.max, default: T(255))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int16
    //=------------------------------------------------------------------------=
    
    func testFromInt16() {
        ANKAssertNumbers(from: Int16.min, default: T(-32768))
        ANKAssertNumbers(from: Int16.max, default: T( 32767))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt16
    //=------------------------------------------------------------------------=
    
    func testFromUInt16() {
        ANKAssertNumbers(from: UInt16.min, default: T())
        ANKAssertNumbers(from: UInt16.max, default: T( 65535))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int32
    //=------------------------------------------------------------------------=
    
    func testFromInt32() {
        ANKAssertNumbers(from: Int32.min, default: T(-2147483648))
        ANKAssertNumbers(from: Int32.max, default: T( 2147483647))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt32
    //=------------------------------------------------------------------------=
    
    func testFromUInt32() {
        ANKAssertNumbers(from: UInt32.min, default: T())
        ANKAssertNumbers(from: UInt32.max, default: T(4294967295))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int64
    //=------------------------------------------------------------------------=
    
    func testToInt64() {
        ANKAssertNumbers(from: T(x64: X( 1,  0,  0,  0)), default: Int64( 1))
        ANKAssertNumbers(from: T(x64: X(~0,  0,  0,  0)), exactly: nil, clamping: Int64.max, truncating: -1)
        ANKAssertNumbers(from: T(x64: X( 1,  1,  1,  1)), exactly: nil, clamping: Int64.max, truncating:  1)
        ANKAssertNumbers(from: T(x64: X(~0, ~0, ~0, ~0)), default: Int64(-1))
    }
    
    func testFromInt64() {
        ANKAssertNumbers(from: Int64.min, default: T(-9223372036854775808))
        ANKAssertNumbers(from: Int64.max, default: T( 9223372036854775807))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt64
    //=------------------------------------------------------------------------=
    
    func testToUInt64() {
        ANKAssertNumbers(from: T(x64: X( 1,  0,  0,  0)), default: UInt64( 1))
        ANKAssertNumbers(from: T(x64: X(~0,  0,  0,  0)), default: UInt64.max)
        ANKAssertNumbers(from: T(x64: X( 1,  1,  1,  1)), exactly: nil, clamping: ~0, truncating: UInt64( 1))
        ANKAssertNumbers(from: T(x64: X(~0, ~0, ~0, ~0)), exactly: nil, clamping:  0, truncating: UInt64.max)
    }
    
    func testFromUInt64() {
        ANKAssertNumbers(from: UInt64.min, default: T())
        ANKAssertNumbers(from: UInt64.max, default: T(18446744073709551615))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Signitude
    //=------------------------------------------------------------------------=
    
    func testFromSignitude() {
        ANKAssertNumbers(from: S.min, default: T.min)
        ANKAssertNumbers(from: S.max, default: T.max)
    }

    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testFromMagnitude() {
        ANKAssertNumbers(from: M.min, exactly: T(), clamping: 00000, truncating: T(bitPattern: M.min))
        ANKAssertNumbers(from: M.max, exactly: nil, clamping: T.max, truncating: T(bitPattern: M.max))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Double Width
    //=------------------------------------------------------------------------=
    
    func testToDoubleWidth() {
        ANKAssertNumbers(from: T(x64: X( 1,  0,  0,  0)), default: T2(high:  0, low: M(x64: X( 1,  0,  0,  0))))
        ANKAssertNumbers(from: T(x64: X(~0,  0,  0,  0)), default: T2(high:  0, low: M(x64: X(~0,  0,  0,  0))))
        ANKAssertNumbers(from: T(x64: X( 1,  1,  1,  1)), default: T2(high:  0, low: M(x64: X( 1,  1,  1,  1))))
        ANKAssertNumbers(from: T(x64: X(~0, ~0, ~0, ~0)), default: T2(high: -1, low: M(x64: X(~0, ~0, ~0, ~0))))
    }
    
    func testFromDoubleWidth() {
        ANKAssertNumbers(from: T2(high: T.min, low: M(bitPattern: T.min)), default: T.min, exactly: nil)
        ANKAssertNumbers(from: T2(high: T(-1), low: M(bitPattern: T.min)), default: T.min)
        ANKAssertNumbers(from: T2(high: T( 0), low: M(bitPattern: T.max)), default: T.max)
        ANKAssertNumbers(from: T2(high: T.max, low: M(bitPattern: T.max)), default: T.max, exactly: nil)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Float32
    //=------------------------------------------------------------------------=
    
    func testToFloat32() {
        XCTAssertEqual(Float32(T(-1)), Float32(-1))
        XCTAssertEqual(Float32(T( 0)), Float32( 0))
        XCTAssertEqual(Float32(T( 1)), Float32( 1))
        
        XCTAssertEqual(Float32(T( Int32.min)), Float32( Int32.min))
        XCTAssertEqual(Float32(T( Int32.max)), Float32( Int32.max))

        XCTAssertEqual(Float32(T(UInt32.min)), Float32(UInt32.min))
        XCTAssertEqual(Float32(T(UInt32.max)), Float32(UInt32.max))
    }
        
    func testFromFloat32() {
        XCTAssertEqual(T(Float32(  22.0)),  22)
        XCTAssertEqual(T(Float32( -22.0)), -22)
        XCTAssertEqual(T(Float32(  22.5)),  22)
        XCTAssertEqual(T(Float32( -22.5)), -22)
        
        XCTAssertEqual(T(exactly:  22.5), nil)
        XCTAssertEqual(T(exactly: -22.5), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float32(T.bitWidth))), nil)
        XCTAssertEqual(T(exactly: -pow(2, Float32(T.bitWidth))), nil)
        
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 0 - 1))), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 0 - 0))), T(x64: X(1,       0, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 1 - 1))), T(x64: X(1 << 63, 0, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 2 - 1))), T(x64: X(0, 1 << 63, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 2 - 0))), nil)
    }
    
    func testFromFloat32ValuesThatAreSpecial() {
        XCTAssertNil(T(exactly: Float32.nan))
        XCTAssertNil(T(exactly: Float32.infinity))
        XCTAssertNil(T(exactly: Float32.signalingNaN))
        XCTAssertNil(T(exactly: Float32.leastNormalMagnitude))
        XCTAssertNil(T(exactly: Float32.leastNonzeroMagnitude))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Float64
    //=------------------------------------------------------------------------=
    
    func testToFloat64() {
        XCTAssertEqual(Float64(T(-1)), Float64(-1))
        XCTAssertEqual(Float64(T( 0)), Float64( 0))
        XCTAssertEqual(Float64(T( 1)), Float64( 1))
        
        XCTAssertEqual(Float64(T( Int64.min)), Float64( Int64.min))
        XCTAssertEqual(Float64(T( Int64.max)), Float64( Int64.max))

        XCTAssertEqual(Float64(T(UInt64.min)), Float64(UInt64.min))
        XCTAssertEqual(Float64(T(UInt64.max)), Float64(UInt64.max))
    }
        
    func testFromFloat64() {
        XCTAssertEqual(T(Float64(  22.0)),  22)
        XCTAssertEqual(T(Float64( -22.0)), -22)
        XCTAssertEqual(T(Float64(  22.5)),  22)
        XCTAssertEqual(T(Float64( -22.5)), -22)
        
        XCTAssertEqual(T(exactly:  22.5), nil)
        XCTAssertEqual(T(exactly: -22.5), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float64(T.bitWidth))), nil)
        XCTAssertEqual(T(exactly: -pow(2, Float64(T.bitWidth))), nil)
        
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 0 - 1))), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 0 - 0))), T(x64: X(1,       0, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 1 - 1))), T(x64: X(1 << 63, 0, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 2 - 1))), T(x64: X(0, 1 << 63, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 3 - 1))), T(x64: X(0, 0, 1 << 63, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 4 - 2))), T(x64: X(0, 0, 0, 1 << 62)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 4 - 1))), nil)
    }
    
    func testFromFloat64ValuesThatAreSpecial() {
        XCTAssertNil(T(exactly: Float64.nan))
        XCTAssertNil(T(exactly: Float64.infinity))
        XCTAssertNil(T(exactly: Float64.signalingNaN))
        XCTAssertNil(T(exactly: Float64.leastNormalMagnitude))
        XCTAssertNil(T(exactly: Float64.leastNonzeroMagnitude))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Sign & Magnitude
    //=------------------------------------------------------------------------=
    
    func testsFromSignAndMagnitude() {
        XCTAssertEqual(T.exactly (sign: .plus,  magnitude: M( 1)), T( 1))
        XCTAssertEqual(T.clamping(sign: .plus,  magnitude: M( 1)), T( 1))
        
        XCTAssertEqual(T.exactly (sign: .minus, magnitude: M( 1)), T(-1))
        XCTAssertEqual(T.clamping(sign: .minus, magnitude: M( 1)), T(-1))
        
        XCTAssertEqual(T.exactly (sign: .plus,  magnitude: M.max),   nil)
        XCTAssertEqual(T.clamping(sign: .plus,  magnitude: M.max), T.max)
        
        XCTAssertEqual(T.exactly (sign: .minus, magnitude: M.max),   nil)
        XCTAssertEqual(T.clamping(sign: .minus, magnitude: M.max), T.min)
        
        XCTAssertEqual(T.exactly (sign: .plus,  magnitude: T.max.magnitude), T.max)
        XCTAssertEqual(T.clamping(sign: .plus,  magnitude: T.max.magnitude), T.max)
        
        XCTAssertEqual(T.exactly (sign: .minus, magnitude: T.min.magnitude), T.min)
        XCTAssertEqual(T.clamping(sign: .minus, magnitude: T.min.magnitude), T.min)
    }

    func testsFromSignAndMagnitudeAsPlusMinusZero() {
        XCTAssertEqual(T.exactly (sign: .plus,  magnitude: M(  )), T(  ))
        XCTAssertEqual(T.clamping(sign: .plus,  magnitude: M(  )), T(  ))
        
        XCTAssertEqual(T.exactly (sign: .minus, magnitude: M(  )), T(  ))
        XCTAssertEqual(T.clamping(sign: .minus, magnitude: M(  )), T(  ))
    }
}

//*============================================================================*
// MARK: * ANK x UInt256 x Numbers
//*============================================================================*

final class UInt256TestsOnNumbers: XCTestCase {
    
    typealias S =  Int256
    typealias T = UInt256
    typealias M = UInt256
    
    typealias S2 = S.DoubleWidth
    typealias T2 = T.DoubleWidth
    typealias M2 = M.DoubleWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Literal
    //=------------------------------------------------------------------------=
    
    func testFromLiteral() {
        XCTAssertEqual(T(x64:( 0,  0,  0,  0)), 0)
        XCTAssertEqual(T(x64:(~0,  0,  0,  0)), 18446744073709551615)
        XCTAssertEqual(T(x64:(~0, ~0,  0,  0)), 340282366920938463463374607431768211455)
        XCTAssertEqual(T(x64:(~0, ~0, ~0,  0)), 6277101735386680763835789423207666416102355444464034512895)
        XCTAssertEqual(T(x64:(~0, ~0, ~0, ~0)), 115792089237316195423570985008687907853269984665640564039457584007913129639935)
        
        XCTAssertNil(T(exactlyIntegerLiteral:  -1))
        XCTAssertNil(T(exactlyIntegerLiteral:   115792089237316195423570985008687907853269984665640564039457584007913129639936))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int
    //=------------------------------------------------------------------------=
    
    func testFromInt() {
        ANKAssertNumbers(from: Int.min, exactly: nil, clamping: 0, truncating: ~T(x64: X(UInt64(Int.max), 0, 0, 0)))
        ANKAssertNumbers(from: Int.max, default: /*-------------------------*/  T(x64: X(UInt64(Int.max), 0, 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt, Digit
    //=------------------------------------------------------------------------=
    
    func testFromUInt() {
        ANKAssertNumbers(from: UInt.min, default: T(x64: X(UInt64(UInt.min), 0, 0, 0)))
        ANKAssertNumbers(from: UInt.max, default: T(x64: X(UInt64(UInt.max), 0, 0, 0)))
    }
    
    func testFromUIntAsDigit() {
        XCTAssertEqual(T(digit: UInt.min), T(x64: X(UInt64(UInt.min), 0, 0, 0)))
        XCTAssertEqual(T(digit: UInt.max), T(x64: X(UInt64(UInt.max), 0, 0, 0)))
    }
    
    func testFromUIntAsBits() {
        XCTAssertEqual(T(_truncatingBits: UInt.min), T(x64: X(UInt64(UInt.min), 0, 0, 0)))
        XCTAssertEqual(T(_truncatingBits: UInt.max), T(x64: X(UInt64(UInt.max), 0, 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int8
    //=------------------------------------------------------------------------=
    
    func testFromInt8() {
        ANKAssertNumbers(from: Int8.min, exactly: nil, clamping: 0, truncating: ~T(127))
        ANKAssertNumbers(from: Int8.max, default: /*-------------------------*/  T(127))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt8
    //=------------------------------------------------------------------------=
    
    func testFromUInt8() {
        ANKAssertNumbers(from: UInt8.min, default: T())
        ANKAssertNumbers(from: UInt8.max, default: T(255))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int16
    //=------------------------------------------------------------------------=
    
    func testFromInt16() {
        ANKAssertNumbers(from: Int16.min, exactly: nil, clamping: 0, truncating: ~T(32767))
        ANKAssertNumbers(from: Int16.max, default: /*-------------------------*/  T(32767))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt16
    //=------------------------------------------------------------------------=
    
    func testFromUInt16() {
        ANKAssertNumbers(from: UInt16.min, default: T())
        ANKAssertNumbers(from: UInt16.max, default: T(65535))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int32
    //=------------------------------------------------------------------------=
    
    func testFromInt32() {
        ANKAssertNumbers(from: Int32.min, exactly: nil, clamping: 0, truncating: ~T(2147483647))
        ANKAssertNumbers(from: Int32.max, default: /*-------------------------*/  T(2147483647))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt32
    //=------------------------------------------------------------------------=
    
    func testFromUInt32() {
        ANKAssertNumbers(from: UInt32.min, default: T())
        ANKAssertNumbers(from: UInt32.max, default: T(4294967295))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int64
    //=------------------------------------------------------------------------=
    
    func testToInt64() {
        ANKAssertNumbers(from: T(x64: X( 1,  0,  0,  0)), default: Int64( 1))
        ANKAssertNumbers(from: T(x64: X(~0,  0,  0,  0)), exactly: nil, clamping: Int64.max, truncating: ~0)
        ANKAssertNumbers(from: T(x64: X( 1,  1,  1,  1)), exactly: nil, clamping: Int64.max, truncating:  1)
        ANKAssertNumbers(from: T(x64: X(~0, ~0, ~0, ~0)), exactly: nil, clamping: Int64.max, truncating: ~0)
    }
    
    func testFromInt64() {
        ANKAssertNumbers(from: Int64.min, exactly: nil, clamping: 0, truncating: ~T(x64: X(UInt64(Int64.max), 0, 0, 0)))
        ANKAssertNumbers(from: Int64.max, default: /*-------------------------*/  T(x64: X(UInt64(Int64.max), 0, 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt64
    //=------------------------------------------------------------------------=
    
    func testToUInt64() {
        ANKAssertNumbers(from: T(x64: X( 1,  0,  0,  0)), default: UInt64( 1))
        ANKAssertNumbers(from: T(x64: X(~0,  0,  0,  0)), default: UInt64.max)
        ANKAssertNumbers(from: T(x64: X( 1,  1,  1,  1)), exactly: nil, clamping: UInt64.max, truncating:  1)
        ANKAssertNumbers(from: T(x64: X(~0, ~0, ~0, ~0)), exactly: nil, clamping: UInt64.max, truncating: ~0)
    }
    
    func testFromUInt64() {
        ANKAssertNumbers(from: UInt64.min, default: T(x64: X(UInt64.min, 0, 0, 0)))
        ANKAssertNumbers(from: UInt64.max, default: T(x64: X(UInt64.max, 0, 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Signitude
    //=------------------------------------------------------------------------=
    
    func testFromSignitude() {
        ANKAssertNumbers(from: S.min, exactly: nil, clamping: 0, truncating: T(bitPattern: S.min))
        ANKAssertNumbers(from: S.max, default: /*-------------------------*/ T(bitPattern: S.max))
    }

    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testFromMagnitude() {
        ANKAssertNumbers(from: M.min, default: T.min)
        ANKAssertNumbers(from: M.max, default: T.max)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Double Width
    //=------------------------------------------------------------------------=
    
    func testToDoubleWidth() {
        ANKAssertNumbers(from: T(x64: X( 1,  0,  0,  0)), default: T2(low: M(x64: X( 1,  0,  0,  0))))
        ANKAssertNumbers(from: T(x64: X(~0,  0,  0,  0)), default: T2(low: M(x64: X(~0,  0,  0,  0))))
        ANKAssertNumbers(from: T(x64: X( 1,  1,  1,  1)), default: T2(low: M(x64: X( 1,  1,  1,  1))))
        ANKAssertNumbers(from: T(x64: X(~0, ~0, ~0, ~0)), default: T2(low: M(x64: X(~0, ~0, ~0, ~0))))
    }
    
    func testFromDoubleWidth() {
        ANKAssertNumbers(from: T2(high: T.min, low: M.min), default: T(  ))
        ANKAssertNumbers(from: T2(high: T(  ), low: M.min), default: T.min)
        ANKAssertNumbers(from: T2(high: T(  ), low: M.max), default: T.max)
        ANKAssertNumbers(from: T2(high: T.max, low: M.max), default: T.max, exactly: nil)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Float32
    //=------------------------------------------------------------------------=
    
    func testToFloat32() {
        XCTAssertEqual(Float32(T(0)), Float32(0))
        XCTAssertEqual(Float32(T(1)), Float32(1))
        
        XCTAssertEqual(Float32(T(UInt32.min)), Float32(UInt32.min))
        XCTAssertEqual(Float32(T(UInt32.max)), Float32(UInt32.max))
    }
        
    func testFromFloat32() {
        XCTAssertEqual(T(Float32(  22.0)), 22)
        XCTAssertEqual(T(Float32(  22.5)), 22)
        
        XCTAssertEqual(T(exactly:  22.5), nil)
        XCTAssertEqual(T(exactly: -22.5), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float32(T.bitWidth))), nil)
        XCTAssertEqual(T(exactly: -pow(2, Float32(T.bitWidth))), nil)
        
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 0 - 1))), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 0 - 0))), T(x64: X(1,       0, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 1 - 1))), T(x64: X(1 << 63, 0, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 2 - 1))), T(x64: X(0, 1 << 63, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 2 - 0))), nil)
    }
    
    func testFromFloat32ValuesThatAreSpecial() {
        XCTAssertNil(T(exactly: Float32.nan))
        XCTAssertNil(T(exactly: Float32.infinity))
        XCTAssertNil(T(exactly: Float32.signalingNaN))
        XCTAssertNil(T(exactly: Float32.leastNormalMagnitude))
        XCTAssertNil(T(exactly: Float32.leastNonzeroMagnitude))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Float64
    //=------------------------------------------------------------------------=
    
    func testToFloat64() {
        XCTAssertEqual(Float64(T(0)), Float64(0))
        XCTAssertEqual(Float64(T(1)), Float64(1))
        
        XCTAssertEqual(Float64(T(UInt64.min)), Float64(UInt64.min))
        XCTAssertEqual(Float64(T(UInt64.max)), Float64(UInt64.max))
    }
        
    func testFromFloat64() {
        XCTAssertEqual(T(Float64(  22.0)), 22)
        XCTAssertEqual(T(Float64(  22.5)), 22)
        
        XCTAssertEqual(T(exactly:  22.5), nil)
        XCTAssertEqual(T(exactly: -22.5), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float64(T.bitWidth))), nil)
        XCTAssertEqual(T(exactly: -pow(2, Float64(T.bitWidth))), nil)
        
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 0 - 1))), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 0 - 0))), T(x64: X(1,       0, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 1 - 1))), T(x64: X(1 << 63, 0, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 2 - 1))), T(x64: X(0, 1 << 63, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 3 - 1))), T(x64: X(0, 0, 1 << 63, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 4 - 1))), T(x64: X(0, 0, 0, 1 << 63)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 4 - 0))), nil)
    }
    
    func testFromFloat64ValuesThatAreSpecial() {
        XCTAssertNil(T(exactly: Float64.nan))
        XCTAssertNil(T(exactly: Float64.infinity))
        XCTAssertNil(T(exactly: Float64.signalingNaN))
        XCTAssertNil(T(exactly: Float64.leastNormalMagnitude))
        XCTAssertNil(T(exactly: Float64.leastNonzeroMagnitude))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Sign & Magnitude
    //=------------------------------------------------------------------------=
    
    func testsFromSignAndMagnitude() {
        XCTAssertEqual(T.exactly (sign: .plus,  magnitude: M( 1)), T( 1))
        XCTAssertEqual(T.clamping(sign: .plus,  magnitude: M( 1)), T( 1))
        
        XCTAssertEqual(T.exactly (sign: .minus, magnitude: M( 1)),   nil)
        XCTAssertEqual(T.clamping(sign: .minus, magnitude: M( 1)), T.min)
        
        XCTAssertEqual(T.exactly (sign: .plus,  magnitude: M.max), T.max)
        XCTAssertEqual(T.clamping(sign: .plus,  magnitude: M.max), T.max)
        
        XCTAssertEqual(T.exactly (sign: .minus, magnitude: M.max),   nil)
        XCTAssertEqual(T.clamping(sign: .minus, magnitude: M.max), T.min)
        
        XCTAssertEqual(T.exactly (sign: .plus,  magnitude: T.max.magnitude), T.max)
        XCTAssertEqual(T.clamping(sign: .plus,  magnitude: T.max.magnitude), T.max)
        
        XCTAssertEqual(T.exactly (sign: .minus, magnitude: T.min.magnitude), T.min)
        XCTAssertEqual(T.clamping(sign: .minus, magnitude: T.min.magnitude), T.min)
    }
    
    func testsFromSignAndMagnitudeAsPlusMinusZero() {
        XCTAssertEqual(T.exactly (sign: .plus,  magnitude: M(  )), T(  ))
        XCTAssertEqual(T.clamping(sign: .plus,  magnitude: M(  )), T(  ))
        
        XCTAssertEqual(T.exactly (sign: .minus, magnitude: M(  )), T(  ))
        XCTAssertEqual(T.clamping(sign: .minus, magnitude: M(  )), T(  ))
    }
}

#endif
