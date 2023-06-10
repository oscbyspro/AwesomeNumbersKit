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

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192 x Numbers
//*============================================================================*

final class Int192TestsOnNumbers: XCTestCase {
    
    typealias S =  ANKInt192
    typealias T =  ANKInt192
    typealias M = ANKUInt192
    
    typealias S2 = S.DoubleWidth
    typealias T2 = T.DoubleWidth
    typealias M2 = M.DoubleWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Literal
    //=------------------------------------------------------------------------=
    
    func testFromLiteral() {
        XCTAssertEqual(T(x64:( 0,  0,  0)),  0)
        XCTAssertEqual(T(x64:(~0,  0,  0)),  18446744073709551615)
        XCTAssertEqual(T(x64:(~0, ~0,  0)),  340282366920938463463374607431768211455)
        XCTAssertEqual(T(x64:(~0, ~0, ~0)), -1)
        
        XCTAssertEqual(T.min, -3138550867693340381917894711603833208051177722232017256448)
        XCTAssertEqual(T.max,  3138550867693340381917894711603833208051177722232017256447)
        
        XCTAssertNil(T(_exactlyIntegerLiteral: -3138550867693340381917894711603833208051177722232017256449))
        XCTAssertNil(T(_exactlyIntegerLiteral:  3138550867693340381917894711603833208051177722232017256448))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int, Digit
    //=------------------------------------------------------------------------=
    
    func testFromInt() {
        XCTAssertEqual(T(Int.min), T(x64: X(UInt64(truncatingIfNeeded: Int.min), ~0, ~0)))
        XCTAssertEqual(T(Int.max), T(x64: X(UInt64(truncatingIfNeeded: Int.max),  0,  0)))
        
        XCTAssertEqual(T(exactly:  Int.min), T(x64: X(UInt64(truncatingIfNeeded: Int.min), ~0, ~0)))
        XCTAssertEqual(T(exactly:  Int.max), T(x64: X(UInt64(truncatingIfNeeded: Int.max),  0,  0)))
        
        XCTAssertEqual(T(clamping: Int.min), T(x64: X(UInt64(truncatingIfNeeded: Int.min), ~0, ~0)))
        XCTAssertEqual(T(clamping: Int.max), T(x64: X(UInt64(truncatingIfNeeded: Int.max),  0,  0)))
        
        XCTAssertEqual(T(truncatingIfNeeded: Int.min), T(x64: X(UInt64(truncatingIfNeeded: Int.min), ~0, ~0)))
        XCTAssertEqual(T(truncatingIfNeeded: Int.max), T(x64: X(UInt64(truncatingIfNeeded: Int.max),  0,  0)))
    }
    
    func testFromIntAsDigit() {
        XCTAssertEqual(T(digit: Int.min), T(x64: X(UInt64(truncatingIfNeeded: Int.min), ~0, ~0)))
        XCTAssertEqual(T(digit: Int.max), T(x64: X(UInt64(truncatingIfNeeded: Int.max),  0,  0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt
    //=------------------------------------------------------------------------=
    
    func testFromUInt() {
        XCTAssertEqual(T(UInt.min), T(x64: X(UInt64(truncatingIfNeeded: UInt.min), 0, 0)))
        XCTAssertEqual(T(UInt.max), T(x64: X(UInt64(truncatingIfNeeded: UInt.max), 0, 0)))
        
        XCTAssertEqual(T(exactly:  UInt.min), T(x64: X(UInt64(truncatingIfNeeded: UInt.min), 0, 0)))
        XCTAssertEqual(T(exactly:  UInt.max), T(x64: X(UInt64(truncatingIfNeeded: UInt.max), 0, 0)))
        
        XCTAssertEqual(T(clamping: UInt.min), T(x64: X(UInt64(truncatingIfNeeded: UInt.min), 0, 0)))
        XCTAssertEqual(T(clamping: UInt.max), T(x64: X(UInt64(truncatingIfNeeded: UInt.max), 0, 0)))
        
        XCTAssertEqual(T(truncatingIfNeeded: UInt.min), T(x64: X(UInt64(truncatingIfNeeded: UInt.min), 0, 0)))
        XCTAssertEqual(T(truncatingIfNeeded: UInt.max), T(x64: X(UInt64(truncatingIfNeeded: UInt.max), 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int8
    //=------------------------------------------------------------------------=
    
    func testFromInt8() {
        XCTAssertEqual(T(Int8.min), -128)
        XCTAssertEqual(T(Int8.max),  127)
        
        XCTAssertEqual(T(exactly:  Int8.min), -128)
        XCTAssertEqual(T(exactly:  Int8.max),  127)
        
        XCTAssertEqual(T(clamping: Int8.min), -128)
        XCTAssertEqual(T(clamping: Int8.max),  127)
        
        XCTAssertEqual(T(truncatingIfNeeded: Int8.min), -128)
        XCTAssertEqual(T(truncatingIfNeeded: Int8.max),  127)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt8
    //=------------------------------------------------------------------------=
    
    func testFromUInt8() {
        XCTAssertEqual(T(UInt8.min), 0)
        XCTAssertEqual(T(UInt8.max), 255)
        
        XCTAssertEqual(T(exactly:  UInt8.min), 0)
        XCTAssertEqual(T(exactly:  UInt8.max), 255)
        
        XCTAssertEqual(T(clamping: UInt8.min), 0)
        XCTAssertEqual(T(clamping: UInt8.max), 255)
        
        XCTAssertEqual(T(truncatingIfNeeded: UInt8.min), 0)
        XCTAssertEqual(T(truncatingIfNeeded: UInt8.max), 255)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int16
    //=------------------------------------------------------------------------=
    
    func testFromInt16() {
        XCTAssertEqual(T(Int16(  )), T())
        XCTAssertEqual(T(Int16.max), 32767)
        
        XCTAssertEqual(T(exactly:  Int16.min), -32768)
        XCTAssertEqual(T(exactly:  Int16.max),  32767)
        
        XCTAssertEqual(T(clamping: Int16.min), -32768)
        XCTAssertEqual(T(clamping: Int16.max),  32767)
        
        XCTAssertEqual(T(truncatingIfNeeded: Int16.min), -32768)
        XCTAssertEqual(T(truncatingIfNeeded: Int16.max),  32767)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt16
    //=------------------------------------------------------------------------=
    
    func testFromUInt16() {
        XCTAssertEqual(T(UInt16.min), 0)
        XCTAssertEqual(T(UInt16.max), 65535)
        
        XCTAssertEqual(T(exactly:  UInt16.min), 0)
        XCTAssertEqual(T(exactly:  UInt16.max), 65535)
        
        XCTAssertEqual(T(clamping: UInt16.min), 0)
        XCTAssertEqual(T(clamping: UInt16.max), 65535)
        
        XCTAssertEqual(T(truncatingIfNeeded: UInt16.min), 0)
        XCTAssertEqual(T(truncatingIfNeeded: UInt16.max), 65535)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int32
    //=------------------------------------------------------------------------=
    
    func testFromInt32() {
        XCTAssertEqual(T(Int32(  )), T())
        XCTAssertEqual(T(Int32.max), 2147483647)
        
        XCTAssertEqual(T(exactly:  Int32.min), -2147483648)
        XCTAssertEqual(T(exactly:  Int32.max),  2147483647)
        
        XCTAssertEqual(T(clamping: Int32.min), -2147483648)
        XCTAssertEqual(T(clamping: Int32.max),  2147483647)
        
        XCTAssertEqual(T(truncatingIfNeeded: Int32.min), -2147483648)
        XCTAssertEqual(T(truncatingIfNeeded: Int32.max),  2147483647)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt32
    //=------------------------------------------------------------------------=
    
    func testFromUInt32() {
        XCTAssertEqual(T(UInt32.min), 0)
        XCTAssertEqual(T(UInt32.max), 4294967295)
        
        XCTAssertEqual(T(exactly:  UInt32.min), 0)
        XCTAssertEqual(T(exactly:  UInt32.max), 4294967295)
        
        XCTAssertEqual(T(clamping: UInt32.min), 0)
        XCTAssertEqual(T(clamping: UInt32.max), 4294967295)
        
        XCTAssertEqual(T(truncatingIfNeeded: UInt32.min), 0)
        XCTAssertEqual(T(truncatingIfNeeded: UInt32.max), 4294967295)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int64
    //=------------------------------------------------------------------------=
    
    func testToInt64() {
        XCTAssertEqual(Int64(T(x64: X(1, 0, 0))), 1)
        XCTAssertEqual(Int64(T(x64: X(2, 0, 0))), 2)
        
        XCTAssertEqual(Int64(exactly:  T(x64: X( 1,  0,  0))),   1)
        XCTAssertEqual(Int64(exactly:  T(x64: X(~0,  0,  0))), nil)
        XCTAssertEqual(Int64(exactly:  T(x64: X( 1,  1,  1))), nil)
        XCTAssertEqual(Int64(exactly:  T(x64: X(~0, ~0, ~0))),  -1)

        XCTAssertEqual(Int64(clamping: T(x64: X( 1,  0,  0))), Int64( 1))
        XCTAssertEqual(Int64(clamping: T(x64: X(~0,  0,  0))), Int64.max)
        XCTAssertEqual(Int64(clamping: T(x64: X( 1,  1,  1))), Int64.max)
        XCTAssertEqual(Int64(clamping: T(x64: X(~0, ~0, ~0))), Int64(-1))

        XCTAssertEqual(Int64(truncatingIfNeeded: T(x64: X( 1,  0,  0))),  1)
        XCTAssertEqual(Int64(truncatingIfNeeded: T(x64: X(~0,  0,  0))), ~0)
        XCTAssertEqual(Int64(truncatingIfNeeded: T(x64: X( 1,  1,  1))),  1)
        XCTAssertEqual(Int64(truncatingIfNeeded: T(x64: X(~0, ~0, ~0))), ~0)
    }
    
    func testFromInt64() {
        XCTAssertEqual(T(Int64.min), T(x64: X(UInt64(truncatingIfNeeded: Int64.min), ~0, ~0)))
        XCTAssertEqual(T(Int64.max), T(x64: X(UInt64(truncatingIfNeeded: Int64.max),  0,  0)))
        
        XCTAssertEqual(T(exactly:  Int64.min), T(x64: X(UInt64(truncatingIfNeeded: Int64.min), ~0, ~0)))
        XCTAssertEqual(T(exactly:  Int64.max), T(x64: X(UInt64(truncatingIfNeeded: Int64.max),  0,  0)))
        
        XCTAssertEqual(T(clamping: Int64.min), T(x64: X(UInt64(truncatingIfNeeded: Int64.min), ~0, ~0)))
        XCTAssertEqual(T(clamping: Int64.max), T(x64: X(UInt64(truncatingIfNeeded: Int64.max),  0,  0)))
        
        XCTAssertEqual(T(truncatingIfNeeded: Int64.min), T(x64: X(UInt64(truncatingIfNeeded: Int64.min), ~0, ~0)))
        XCTAssertEqual(T(truncatingIfNeeded: Int64.max), T(x64: X(UInt64(truncatingIfNeeded: Int64.max),  0,  0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt64
    //=------------------------------------------------------------------------=
    
    func testToUInt64() {
        XCTAssertEqual(UInt64(T(x64: X( 1, 0, 0))),  1)
        XCTAssertEqual(UInt64(T(x64: X(~0, 0, 0))), ~0)
        
        XCTAssertEqual(UInt64(exactly:  T(x64: X( 1,  0,  0))),   1)
        XCTAssertEqual(UInt64(exactly:  T(x64: X(~0,  0,  0))),  ~0)
        XCTAssertEqual(UInt64(exactly:  T(x64: X( 1,  1,  1))), nil)
        XCTAssertEqual(UInt64(exactly:  T(x64: X(~0, ~0, ~0))), nil)

        XCTAssertEqual(UInt64(clamping: T(x64: X( 1,  0,  0))),   1)
        XCTAssertEqual(UInt64(clamping: T(x64: X(~0,  0,  0))),  ~0)
        XCTAssertEqual(UInt64(clamping: T(x64: X( 1,  1,  1))),  ~0)
        XCTAssertEqual(UInt64(clamping: T(x64: X(~0, ~0, ~0))),   0)

        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64: X( 1,  0,  0))),  1)
        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64: X(~0,  0,  0))), ~0)
        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64: X( 1,  1,  1))),  1)
        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64: X(~0, ~0, ~0))), ~0)
    }
    
    func testFromUInt64() {
        XCTAssertEqual(T(UInt64.min), T(x64: X(UInt64(truncatingIfNeeded: UInt64.min), 0, 0)))
        XCTAssertEqual(T(UInt64.max), T(x64: X(UInt64(truncatingIfNeeded: UInt64.max), 0, 0)))
        
        XCTAssertEqual(T(exactly:  UInt64.min), T(x64: X(UInt64(truncatingIfNeeded: UInt64.min), 0, 0)))
        XCTAssertEqual(T(exactly:  UInt64.max), T(x64: X(UInt64(truncatingIfNeeded: UInt64.max), 0, 0)))
        
        XCTAssertEqual(T(clamping: UInt64.min), T(x64: X(UInt64(truncatingIfNeeded: UInt64.min), 0, 0)))
        XCTAssertEqual(T(clamping: UInt64.max), T(x64: X(UInt64(truncatingIfNeeded: UInt64.max), 0, 0)))
        
        XCTAssertEqual(T(truncatingIfNeeded: UInt64.min), T(x64: X(UInt64(truncatingIfNeeded: UInt64.min), 0, 0)))
        XCTAssertEqual(T(truncatingIfNeeded: UInt64.max), T(x64: X(UInt64(truncatingIfNeeded: UInt64.max), 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Signitude
    //=------------------------------------------------------------------------=
    
    func testFromSignitude() {
        XCTAssertEqual(T(S.min), T.min)
        XCTAssertEqual(T(S.max), T.max)
        
        XCTAssertEqual(T(exactly:  S.min), T.min)
        XCTAssertEqual(T(exactly:  S.max), T.max)

        XCTAssertEqual(T(clamping: S.min), T.min)
        XCTAssertEqual(T(clamping: S.max), T.max)

        XCTAssertEqual(T(truncatingIfNeeded: S.min), T.min)
        XCTAssertEqual(T(truncatingIfNeeded: S.max), T.max)
    }

    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testFromMagnitude() {
        XCTAssertEqual(T(M.min), T(  ))
        XCTAssertEqual(T(M(44)), T(44))
        
        XCTAssertEqual(T(exactly:  M.min), T())
        XCTAssertEqual(T(exactly:  M.max), nil)

        XCTAssertEqual(T(clamping: M.min), T())
        XCTAssertEqual(T(clamping: M.max), T.max)

        XCTAssertEqual(T(truncatingIfNeeded: M.min), T(x64: X( 0,  0,  0)))
        XCTAssertEqual(T(truncatingIfNeeded: M.max), T(x64: X(~0, ~0, ~0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Double Width
    //=------------------------------------------------------------------------=
    
    func testToDoubleWidth() {
        XCTAssertEqual(T2(T(x64: X( 1,  0,  0))), T2(high:  0, low: M(x64: X( 1,  0,  0))))
        XCTAssertEqual(T2(T(x64: X(~0,  0,  0))), T2(high:  0, low: M(x64: X(~0,  0,  0))))
        XCTAssertEqual(T2(T(x64: X( 1,  1,  1))), T2(high:  0, low: M(x64: X( 1,  1,  1))))
        XCTAssertEqual(T2(T(x64: X(~0, ~0, ~0))), T2(high: -1, low: M(x64: X(~0, ~0, ~00))))
        
        XCTAssertEqual(T2(exactly:  T(x64: X( 1,  0,  0))), T2(high:  0, low: M(x64: X( 1,  0,  0))))
        XCTAssertEqual(T2(exactly:  T(x64: X(~0,  0,  0))), T2(high:  0, low: M(x64: X(~0,  0,  0))))
        XCTAssertEqual(T2(exactly:  T(x64: X( 1,  1,  1))), T2(high:  0, low: M(x64: X( 1,  1,  1))))
        XCTAssertEqual(T2(exactly:  T(x64: X(~0, ~0, ~0))), T2(high: -1, low: M(x64: X(~0, ~0, ~0))))
        
        XCTAssertEqual(T2(clamping: T(x64: X( 1,  0,  0))), T2(high:  0, low: M(x64: X( 1,  0,  0))))
        XCTAssertEqual(T2(clamping: T(x64: X(~0,  0,  0))), T2(high:  0, low: M(x64: X(~0,  0,  0))))
        XCTAssertEqual(T2(clamping: T(x64: X( 1,  1,  1))), T2(high:  0, low: M(x64: X( 1,  1,  1))))
        XCTAssertEqual(T2(clamping: T(x64: X(~0, ~0, ~0))), T2(high: -1, low: M(x64: X(~0, ~0, ~0))))
        
        XCTAssertEqual(T2(truncatingIfNeeded: T(x64: X( 1,  0,  0))), T2(high:  0, low: M(x64: X( 1,  0,  0))))
        XCTAssertEqual(T2(truncatingIfNeeded: T(x64: X(~0,  0,  0))), T2(high:  0, low: M(x64: X(~0,  0,  0))))
        XCTAssertEqual(T2(truncatingIfNeeded: T(x64: X( 1,  1,  1))), T2(high:  0, low: M(x64: X( 1,  1,  1))))
        XCTAssertEqual(T2(truncatingIfNeeded: T(x64: X(~0, ~0, ~0))), T2(high: -1, low: M(x64: X(~0, ~0, ~0))))
    }
    
    func testFromDoubleWidth() {
        XCTAssertEqual(T(T2(high: T(-1), low: M(bitPattern: T.min))), T.min)
        XCTAssertEqual(T(T2(high: T( 0), low: M(bitPattern: T.max))), T.max)
        
        XCTAssertEqual(T(exactly:  T2(high: T.min, low: M(bitPattern: T.min))),   nil)
        XCTAssertEqual(T(exactly:  T2(high: T(-1), low: M(bitPattern: T.min))), T.min)
        XCTAssertEqual(T(exactly:  T2(high: T( 0), low: M(bitPattern: T.max))), T.max)
        XCTAssertEqual(T(exactly:  T2(high: T.max, low: M(bitPattern: T.max))),   nil)
        
        XCTAssertEqual(T(clamping: T2(high: T.min, low: M(bitPattern: T.min))), T.min)
        XCTAssertEqual(T(clamping: T2(high: T(-1), low: M(bitPattern: T.min))), T.min)
        XCTAssertEqual(T(clamping: T2(high: T( 0), low: M(bitPattern: T.max))), T.max)
        XCTAssertEqual(T(clamping: T2(high: T.max, low: M(bitPattern: T.max))), T.max)
        
        XCTAssertEqual(T(truncatingIfNeeded: T2(high: T.min, low: M(bitPattern: T.min))), T.min)
        XCTAssertEqual(T(truncatingIfNeeded: T2(high: T(-1), low: M(bitPattern: T.min))), T.min)
        XCTAssertEqual(T(truncatingIfNeeded: T2(high: T( 0), low: M(bitPattern: T.max))), T.max)
        XCTAssertEqual(T(truncatingIfNeeded: T2(high: T.max, low: M(bitPattern: T.max))), T.max)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Sign & Magnitude
    //=------------------------------------------------------------------------=
    
    func testsFromSignedMagnitude() {
        XCTAssertEqual(T(Signed(M(44), as: .minus)), -T(44))
        XCTAssertEqual(T(Signed(M(44), as: .plus )),  T(44))
        
        XCTAssertEqual(T(exactly:  Signed(M.max, as: .minus)), nil)
        XCTAssertEqual(T(exactly:  Signed(M.max, as: .plus )), nil)

        XCTAssertEqual(T(clamping: Signed(M.max, as: .minus)), T.min)
        XCTAssertEqual(T(clamping: Signed(M.max, as: .plus )), T.max)

        XCTAssertEqual(T(truncatingIfNeeded: Signed(M.max, as: .minus)), T(x64: X( 1,  0,  0)))
        XCTAssertEqual(T(truncatingIfNeeded: Signed(M.max, as: .plus )), T(x64: X(~0, ~0, ~0)))
    }
    
    func testsFromSignedMagnitudePlusMinusZero() {
        XCTAssertEqual(T(ANKSigned(M(), as: .minus)), T())
        XCTAssertEqual(T(ANKSigned(M(), as: .plus )), T())

        XCTAssertEqual(T(exactly:  ANKSigned(M(), as: .minus)), T())
        XCTAssertEqual(T(exactly:  ANKSigned(M(), as: .plus )), T())
        
        XCTAssertEqual(T(clamping: ANKSigned(M(), as: .minus)), T())
        XCTAssertEqual(T(clamping: ANKSigned(M(), as: .plus )), T())
        
        XCTAssertEqual(T(truncatingIfNeeded: ANKSigned(M(), as: .minus)), T())
        XCTAssertEqual(T(truncatingIfNeeded: ANKSigned(M(), as: .plus )), T())
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
        XCTAssertEqual(T( Float32(22.0)),  22)
        XCTAssertEqual(T(-Float32(22.0)), -22)
        XCTAssertEqual(T( Float32(22.5)),  22)
        XCTAssertEqual(T(-Float32(22.5)), -22)
        
        XCTAssertEqual(T(exactly:  22.5), nil)
        XCTAssertEqual(T(exactly: -22.5), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float32(T.bitWidth))), nil)
        XCTAssertEqual(T(exactly: -pow(2, Float32(T.bitWidth))), nil)
        
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 0 - 1))), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 0 - 0))), 1 as T)
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 1 - 1))), T(x64: X(1 << 63, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 2 - 1))), T(x64: X(0, 1 << 63, 0)))
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
        XCTAssertEqual(T( Float64(22.0)),  22)
        XCTAssertEqual(T(-Float64(22.0)), -22)
        XCTAssertEqual(T( Float64(22.5)),  22)
        XCTAssertEqual(T(-Float64(22.5)), -22)
        
        XCTAssertEqual(T(exactly:  22.5), nil)
        XCTAssertEqual(T(exactly: -22.5), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float64(T.bitWidth))), nil)
        XCTAssertEqual(T(exactly: -pow(2, Float64(T.bitWidth))), nil)
        
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 0 - 1))), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 0 - 0))), 1 as T)
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 1 - 1))), T(x64: X(1 << 63, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 2 - 1))), T(x64: X(0, 1 << 63, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 3 - 2))), T(x64: X(0, 0, 1 << 62)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 3 - 1))), nil)
    }
    
    func testFromFloat64ValuesThatAreSpecial() {
        XCTAssertNil(T(exactly: Float64.nan))
        XCTAssertNil(T(exactly: Float64.infinity))
        XCTAssertNil(T(exactly: Float64.signalingNaN))
        XCTAssertNil(T(exactly: Float64.leastNormalMagnitude))
        XCTAssertNil(T(exactly: Float64.leastNonzeroMagnitude))
    }
}

//*============================================================================*
// MARK: * UInt192 x Numbers
//*============================================================================*

final class UInt192TestsOnNumbers: XCTestCase {
    
    typealias S =  ANKInt192
    typealias T = ANKUInt192
    typealias M = ANKUInt192
    
    typealias S2 = S.DoubleWidth
    typealias T2 = T.DoubleWidth
    typealias M2 = M.DoubleWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Literal
    //=------------------------------------------------------------------------=
    
    func testFromLiteral() {
        XCTAssertEqual(T(x64:( 0,  0,  0)), 0)
        XCTAssertEqual(T(x64:(~0,  0,  0)), 18446744073709551615)
        XCTAssertEqual(T(x64:(~0, ~0,  0)), 340282366920938463463374607431768211455)
        XCTAssertEqual(T(x64:(~0, ~0, ~0)), 6277101735386680763835789423207666416102355444464034512895)
        
        XCTAssertNil(T(_exactlyIntegerLiteral: -1))
        XCTAssertNil(T(_exactlyIntegerLiteral:  6277101735386680763835789423207666416102355444464034512896))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int
    //=------------------------------------------------------------------------=
    
    func testFromInt() {
        XCTAssertEqual(T(Int(  )), T())
        XCTAssertEqual(T(Int.max), T(x64: X(UInt64(truncatingIfNeeded: Int.max), 0, 0)))
        
        XCTAssertEqual(T(exactly:  Int.min), nil)
        XCTAssertEqual(T(exactly:  Int.max), T(x64: X(UInt64(truncatingIfNeeded: Int.max), 0, 0)))
        
        XCTAssertEqual(T(clamping: Int.min), T(x64: X(UInt64(truncatingIfNeeded: Int(  )), 0, 0)))
        XCTAssertEqual(T(clamping: Int.max), T(x64: X(UInt64(truncatingIfNeeded: Int.max), 0, 0)))
        
        XCTAssertEqual(T(truncatingIfNeeded: Int.min), T(x64: X(UInt64(truncatingIfNeeded: Int.min), ~0, ~0)))
        XCTAssertEqual(T(truncatingIfNeeded: Int.max), T(x64: X(UInt64(truncatingIfNeeded: Int.max),  0,  0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt, Digit
    //=------------------------------------------------------------------------=
    
    func testFromUInt() {
        XCTAssertEqual(T(UInt.min), T(x64: X(UInt64(truncatingIfNeeded: UInt.min), 0, 0)))
        XCTAssertEqual(T(UInt.max), T(x64: X(UInt64(truncatingIfNeeded: UInt.max), 0, 0)))
        
        XCTAssertEqual(T(exactly:  UInt.min), T(x64: X(UInt64(truncatingIfNeeded: UInt.min), 0, 0)))
        XCTAssertEqual(T(exactly:  UInt.max), T(x64: X(UInt64(truncatingIfNeeded: UInt.max), 0, 0)))
        
        XCTAssertEqual(T(clamping: UInt.min), T(x64: X(UInt64(truncatingIfNeeded: UInt.min), 0, 0)))
        XCTAssertEqual(T(clamping: UInt.max), T(x64: X(UInt64(truncatingIfNeeded: UInt.max), 0, 0)))
        
        XCTAssertEqual(T(truncatingIfNeeded: UInt.min), T(x64: X(UInt64(truncatingIfNeeded: UInt.min), 0, 0)))
        XCTAssertEqual(T(truncatingIfNeeded: UInt.max), T(x64: X(UInt64(truncatingIfNeeded: UInt.max), 0, 0)))
    }
    
    func testFromUIntAsDigit() {
        XCTAssertEqual(T(digit: UInt.min), T(x64: X(UInt64(truncatingIfNeeded: UInt.min), 0, 0)))
        XCTAssertEqual(T(digit: UInt.max), T(x64: X(UInt64(truncatingIfNeeded: UInt.max), 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int8
    //=------------------------------------------------------------------------=
    
    func testFromInt8() {
        XCTAssertEqual(T(Int8(  )), T())
        XCTAssertEqual(T(Int8.max), 127)
        
        XCTAssertEqual(T(exactly:  Int8.min), nil)
        XCTAssertEqual(T(exactly:  Int8.max), 127)
        
        XCTAssertEqual(T(clamping: Int8.min), T())
        XCTAssertEqual(T(clamping: Int8.max), 127)
        
        XCTAssertEqual(T(truncatingIfNeeded: Int8.min), ~T(127))
        XCTAssertEqual(T(truncatingIfNeeded: Int8.max),  T(127))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt8
    //=------------------------------------------------------------------------=
    
    func testFromUInt8() {
        XCTAssertEqual(T(UInt8.min), 0)
        XCTAssertEqual(T(UInt8.max), 255)
        
        XCTAssertEqual(T(exactly:  UInt8.min), 0)
        XCTAssertEqual(T(exactly:  UInt8.max), 255)
        
        XCTAssertEqual(T(clamping: UInt8.min), 0)
        XCTAssertEqual(T(clamping: UInt8.max), 255)
        
        XCTAssertEqual(T(truncatingIfNeeded: UInt8.min), 0)
        XCTAssertEqual(T(truncatingIfNeeded: UInt8.max), 255)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int16
    //=------------------------------------------------------------------------=
    
    func testFromInt16() {
        XCTAssertEqual(T(Int16(  )), T())
        XCTAssertEqual(T(Int16.max), 32767)
        
        XCTAssertEqual(T(exactly:  Int16.min), nil)
        XCTAssertEqual(T(exactly:  Int16.max), 32767)
        
        XCTAssertEqual(T(clamping: Int16.min), T())
        XCTAssertEqual(T(clamping: Int16.max), 32767)
        
        XCTAssertEqual(T(truncatingIfNeeded: Int16.min), ~T(32767))
        XCTAssertEqual(T(truncatingIfNeeded: Int16.max),  T(32767))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt16
    //=------------------------------------------------------------------------=
    
    func testFromUInt16() {
        XCTAssertEqual(T(UInt16.min), 0)
        XCTAssertEqual(T(UInt16.max), 65535)
        
        XCTAssertEqual(T(exactly:  UInt16.min), 0)
        XCTAssertEqual(T(exactly:  UInt16.max), 65535)
        
        XCTAssertEqual(T(clamping: UInt16.min), 0)
        XCTAssertEqual(T(clamping: UInt16.max), 65535)
        
        XCTAssertEqual(T(truncatingIfNeeded: UInt16.min), 0)
        XCTAssertEqual(T(truncatingIfNeeded: UInt16.max), 65535)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int32
    //=------------------------------------------------------------------------=
    
    func testFromInt32() {
        XCTAssertEqual(T(Int32(  )), T())
        XCTAssertEqual(T(Int32.max), 2147483647)
        
        XCTAssertEqual(T(exactly:  Int32.min), nil)
        XCTAssertEqual(T(exactly:  Int32.max), 2147483647)
        
        XCTAssertEqual(T(clamping: Int32.min), T())
        XCTAssertEqual(T(clamping: Int32.max), 2147483647)
        
        XCTAssertEqual(T(truncatingIfNeeded: Int32.min), ~T(2147483647))
        XCTAssertEqual(T(truncatingIfNeeded: Int32.max),  T(2147483647))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt32
    //=------------------------------------------------------------------------=
    
    func testFromUInt32() {
        XCTAssertEqual(T(UInt32.min), 0)
        XCTAssertEqual(T(UInt32.max), 4294967295)
        
        XCTAssertEqual(T(exactly:  UInt32.min), 0)
        XCTAssertEqual(T(exactly:  UInt32.max), 4294967295)
        
        XCTAssertEqual(T(clamping: UInt32.min), 0)
        XCTAssertEqual(T(clamping: UInt32.max), 4294967295)
        
        XCTAssertEqual(T(truncatingIfNeeded: UInt32.min), 0)
        XCTAssertEqual(T(truncatingIfNeeded: UInt32.max), 4294967295)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int64
    //=------------------------------------------------------------------------=
    
    func testToInt64() {
        XCTAssertEqual(Int64(T(x64: X(1, 0, 0))), 1)
        XCTAssertEqual(Int64(T(x64: X(2, 0, 0))), 2)
        
        XCTAssertEqual(Int64(exactly:  T(x64: X( 1,  0,  0))),   1)
        XCTAssertEqual(Int64(exactly:  T(x64: X(~0,  0,  0))), nil)
        XCTAssertEqual(Int64(exactly:  T(x64: X( 1,  1,  1))), nil)
        XCTAssertEqual(Int64(exactly:  T(x64: X(~0, ~0, ~0))), nil)
        
        XCTAssertEqual(Int64(clamping: T(x64: X( 1,  0,  0))), Int64( 1))
        XCTAssertEqual(Int64(clamping: T(x64: X(~0,  0,  0))), Int64.max)
        XCTAssertEqual(Int64(clamping: T(x64: X( 1,  1,  1))), Int64.max)
        XCTAssertEqual(Int64(clamping: T(x64: X(~0, ~0, ~0))), Int64.max)
        
        XCTAssertEqual(Int64(truncatingIfNeeded: T(x64: X( 1,  0,  0))),  1)
        XCTAssertEqual(Int64(truncatingIfNeeded: T(x64: X(~0,  0,  0))), ~0)
        XCTAssertEqual(Int64(truncatingIfNeeded: T(x64: X( 1,  1,  1))),  1)
        XCTAssertEqual(Int64(truncatingIfNeeded: T(x64: X(~0, ~0, ~0))), ~0)
    }
    
    func testFromInt64() {
        XCTAssertEqual(T(Int64(  )), T())
        XCTAssertEqual(T(Int64.max), T(x64: X(UInt64(truncatingIfNeeded: Int64.max), 0, 0)))
        
        XCTAssertEqual(T(exactly:  Int64.min), nil)
        XCTAssertEqual(T(exactly:  Int64.max), T(x64: X(UInt64(truncatingIfNeeded: Int64.max), 0, 0)))
        
        XCTAssertEqual(T(clamping: Int64.min), T(x64: X(UInt64(truncatingIfNeeded: Int64(  )), 0, 0)))
        XCTAssertEqual(T(clamping: Int64.max), T(x64: X(UInt64(truncatingIfNeeded: Int64.max), 0, 0)))
        
        XCTAssertEqual(T(truncatingIfNeeded: Int64.min), T(x64: X(UInt64(truncatingIfNeeded: Int64.min), ~0, ~0)))
        XCTAssertEqual(T(truncatingIfNeeded: Int64.max), T(x64: X(UInt64(truncatingIfNeeded: Int64.max),  0,  0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt64
    //=------------------------------------------------------------------------=
    
    func testToUInt64() {
        XCTAssertEqual(UInt64(T(x64: X( 1, 0, 0))),  1)
        XCTAssertEqual(UInt64(T(x64: X(~0, 0, 0))), ~0)
        
        XCTAssertEqual(UInt64(exactly:  T(x64: X( 1,  0,  0))),   1)
        XCTAssertEqual(UInt64(exactly:  T(x64: X(~0,  0,  0))),  ~0)
        XCTAssertEqual(UInt64(exactly:  T(x64: X( 1,  1,  1))), nil)
        XCTAssertEqual(UInt64(exactly:  T(x64: X(~0, ~0, ~0))), nil)
        
        XCTAssertEqual(UInt64(clamping: T(x64: X( 1,  0,  0))),   1)
        XCTAssertEqual(UInt64(clamping: T(x64: X(~0,  0,  0))),  ~0)
        XCTAssertEqual(UInt64(clamping: T(x64: X( 1,  1,  1))),  ~0)
        XCTAssertEqual(UInt64(clamping: T(x64: X(~0, ~0, ~0))),  ~0)
        
        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64: X( 1,  0,  0))),  1)
        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64: X(~0,  0,  0))), ~0)
        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64: X( 1,  1,  1))),  1)
        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64: X(~0, ~0, ~0))), ~0)
    }
    
    func testFromUInt64() {
        XCTAssertEqual(T(UInt64.min), T(x64: X(UInt64(truncatingIfNeeded: UInt64.min), 0, 0)))
        XCTAssertEqual(T(UInt64.max), T(x64: X(UInt64(truncatingIfNeeded: UInt64.max), 0, 0)))
        
        XCTAssertEqual(T(exactly:  UInt64.min), T(x64: X(UInt64(truncatingIfNeeded: UInt64.min), 0, 0)))
        XCTAssertEqual(T(exactly:  UInt64.max), T(x64: X(UInt64(truncatingIfNeeded: UInt64.max), 0, 0)))
        
        XCTAssertEqual(T(clamping: UInt64.min), T(x64: X(UInt64(truncatingIfNeeded: UInt64.min), 0, 0)))
        XCTAssertEqual(T(clamping: UInt64.max), T(x64: X(UInt64(truncatingIfNeeded: UInt64.max), 0, 0)))
        
        XCTAssertEqual(T(truncatingIfNeeded: UInt64.min), T(x64: X(UInt64(truncatingIfNeeded: UInt64.min), 0, 0)))
        XCTAssertEqual(T(truncatingIfNeeded: UInt64.max), T(x64: X(UInt64(truncatingIfNeeded: UInt64.max), 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Signitude
    //=------------------------------------------------------------------------=
    
    func testFromSignitude() {
        XCTAssertEqual(T(S(  )), T())
        XCTAssertEqual(T(S.max), T(x64: X(~0, ~0, UInt64(bitPattern: Int64.max))))
        
        XCTAssertEqual(T(exactly:  S.min), nil)
        XCTAssertEqual(T(exactly:  S.max), T(x64: X(~0, ~0, UInt64(bitPattern: Int64.max))))

        XCTAssertEqual(T(clamping: S.min), T(x64: X( 0,  0, UInt64(bitPattern: Int64(  )))))
        XCTAssertEqual(T(clamping: S.max), T(x64: X(~0, ~0, UInt64(bitPattern: Int64.max))))

        XCTAssertEqual(T(truncatingIfNeeded: S.min), T(x64: X( 0,  0, UInt64(bitPattern: Int64.min))))
        XCTAssertEqual(T(truncatingIfNeeded: S.max), T(x64: X(~0, ~0, UInt64(bitPattern: Int64.max))))
    }

    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testFromMagnitude() {
        XCTAssertEqual(T(M.min), T.min)
        XCTAssertEqual(T(M.max), T.max)
        
        XCTAssertEqual(T(exactly:  M.min), T.min)
        XCTAssertEqual(T(exactly:  M.max), T.max)

        XCTAssertEqual(T(clamping: M.min), T.min)
        XCTAssertEqual(T(clamping: M.max), T.max)

        XCTAssertEqual(T(truncatingIfNeeded: M.min), T.min)
        XCTAssertEqual(T(truncatingIfNeeded: M.max), T.max)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Double Width
    //=------------------------------------------------------------------------=
    
    func testToDoubleWidth() {
        XCTAssertEqual(T2(T(x64: X( 1,  0,  0))), T2(low: M(x64: X( 1,  0,  0))))
        XCTAssertEqual(T2(T(x64: X(~0,  0,  0))), T2(low: M(x64: X(~0,  0,  0))))
        XCTAssertEqual(T2(T(x64: X( 1,  1,  1))), T2(low: M(x64: X( 1,  1,  1))))
        XCTAssertEqual(T2(T(x64: X(~0, ~0, ~0))), T2(low: M(x64: X(~0, ~0, ~0))))
        
        XCTAssertEqual(T2(exactly:  T(x64: X( 1,  0,  0))), T2(low: M(x64: X( 1,  0,  0))))
        XCTAssertEqual(T2(exactly:  T(x64: X(~0,  0,  0))), T2(low: M(x64: X(~0,  0,  0))))
        XCTAssertEqual(T2(exactly:  T(x64: X( 1,  1,  1))), T2(low: M(x64: X( 1,  1,  1))))
        XCTAssertEqual(T2(exactly:  T(x64: X(~0, ~0, ~0))), T2(low: M(x64: X(~0, ~0, ~0))))
        
        XCTAssertEqual(T2(clamping: T(x64: X( 1,  0,  0))), T2(low: M(x64: X( 1,  0,  0))))
        XCTAssertEqual(T2(clamping: T(x64: X(~0,  0,  0))), T2(low: M(x64: X(~0,  0,  0))))
        XCTAssertEqual(T2(clamping: T(x64: X( 1,  1,  1))), T2(low: M(x64: X( 1,  1,  1))))
        XCTAssertEqual(T2(clamping: T(x64: X(~0, ~0, ~0))), T2(low: M(x64: X(~0, ~0, ~0))))
        
        XCTAssertEqual(T2(truncatingIfNeeded: T(x64: X( 1,  0,  0))), T2(low: M(x64: X( 1,  0,  0))))
        XCTAssertEqual(T2(truncatingIfNeeded: T(x64: X(~0,  0,  0))), T2(low: M(x64: X(~0,  0,  0))))
        XCTAssertEqual(T2(truncatingIfNeeded: T(x64: X( 1,  1,  1))), T2(low: M(x64: X( 1,  1,  1))))
        XCTAssertEqual(T2(truncatingIfNeeded: T(x64: X(~0, ~0, ~0))), T2(low: M(x64: X(~0, ~0, ~0))))
    }
    
    func testFromDoubleWidth() {
        XCTAssertEqual(T(T2(high: T(  ), low: M.min)), T.min)
        XCTAssertEqual(T(T2(high: T(  ), low: M.max)), T.max)
        
        XCTAssertEqual(T(exactly:  T2(high: T.min, low: M.min)), T(  ))
        XCTAssertEqual(T(exactly:  T2(high: T(  ), low: M.min)), T.min)
        XCTAssertEqual(T(exactly:  T2(high: T(  ), low: M.max)), T.max)
        XCTAssertEqual(T(exactly:  T2(high: T.max, low: M.max)),   nil)
        
        XCTAssertEqual(T(clamping: T2(high: T.min, low: M.min)), T(  ))
        XCTAssertEqual(T(clamping: T2(high: T(  ), low: M.min)), T.min)
        XCTAssertEqual(T(clamping: T2(high: T(  ), low: M.max)), T.max)
        XCTAssertEqual(T(clamping: T2(high: T.max, low: M.max)), T.max)
        
        XCTAssertEqual(T(truncatingIfNeeded: T2(high: T.min, low: M.min)), T(  ))
        XCTAssertEqual(T(truncatingIfNeeded: T2(high: T(  ), low: M.min)), T.min)
        XCTAssertEqual(T(truncatingIfNeeded: T2(high: T(  ), low: M.max)), T.max)
        XCTAssertEqual(T(truncatingIfNeeded: T2(high: T.max, low: M.max)), T.max)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Sign & Magnitude
    //=------------------------------------------------------------------------=

    func testsFromSignedMagnitude() {
        XCTAssertEqual(T(ANKSigned(M(  ), as: .minus)),  T(  ))
        XCTAssertEqual(T(ANKSigned(M.max, as: .plus )),  T.max)

        XCTAssertEqual(T(exactly:  ANKSigned(M.max, as: .minus)),   nil)
        XCTAssertEqual(T(exactly:  ANKSigned(M.max, as: .plus )), T.max)
        
        XCTAssertEqual(T(clamping: ANKSigned(M.max, as: .minus)), T.min)
        XCTAssertEqual(T(clamping: ANKSigned(M.max, as: .plus )), T.max)

        XCTAssertEqual(T(truncatingIfNeeded: ANKSigned(M.max, as: .minus)), T(x64: X( 1,  0,  0)))
        XCTAssertEqual(T(truncatingIfNeeded: ANKSigned(M.max, as: .plus )), T(x64: X(~0, ~0, ~0)))
    }
    
    func testsFromSignedMagnitudePlusMinusZero() {
        XCTAssertEqual(T(ANKSigned(M(), as: .minus)), T())
        XCTAssertEqual(T(ANKSigned(M(), as: .plus )), T())

        XCTAssertEqual(T(exactly:  ANKSigned(M(), as: .minus)), T())
        XCTAssertEqual(T(exactly:  ANKSigned(M(), as: .plus )), T())
        
        XCTAssertEqual(T(clamping: ANKSigned(M(), as: .minus)), T())
        XCTAssertEqual(T(clamping: ANKSigned(M(), as: .plus )), T())
        
        XCTAssertEqual(T(truncatingIfNeeded: ANKSigned(M(), as: .minus)), T())
        XCTAssertEqual(T(truncatingIfNeeded: ANKSigned(M(), as: .plus )), T())
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
        XCTAssertEqual(T(Float32(22.0)),  22)
        XCTAssertEqual(T(Float32(22.5)),  22)
        
        XCTAssertEqual(T(exactly:  22.5), nil)
        XCTAssertEqual(T(exactly: -22.5), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float32(T.bitWidth))), nil)
        XCTAssertEqual(T(exactly: -pow(2, Float32(T.bitWidth))), nil)
        
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 0 - 1))), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 0 - 0))), 1 as T)
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 1 - 1))), T(x64: X(1 << 63, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float32(64 * 2 - 1))), T(x64: X(0, 1 << 63, 0)))
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
        XCTAssertEqual(T(Float64(22.0)),  22)
        XCTAssertEqual(T(Float64(22.5)),  22)
        
        XCTAssertEqual(T(exactly:  22.5), nil)
        XCTAssertEqual(T(exactly: -22.5), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float64(T.bitWidth))), nil)
        XCTAssertEqual(T(exactly: -pow(2, Float64(T.bitWidth))), nil)
        
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 0 - 1))), nil)
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 0 - 0))), 1 as T)
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 1 - 1))), T(x64: X(1 << 63, 0, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 2 - 1))), T(x64: X(0, 1 << 63, 0)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 3 - 1))), T(x64: X(0, 0, 1 << 63)))
        XCTAssertEqual(T(exactly:  pow(2, Float64(64 * 3 - 0))), nil)
    }
    
    func testFromFloat64ValuesThatAreSpecial() {
        XCTAssertNil(T(exactly: Float64.nan))
        XCTAssertNil(T(exactly: Float64.infinity))
        XCTAssertNil(T(exactly: Float64.signalingNaN))
        XCTAssertNil(T(exactly: Float64.leastNormalMagnitude))
        XCTAssertNil(T(exactly: Float64.leastNonzeroMagnitude))
    }
}

#endif
