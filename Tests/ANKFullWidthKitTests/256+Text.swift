//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKFullWidthKit
import XCTest

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Text
//*============================================================================*

final class Int256TestsOnText: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Decode
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix16() {
        XCTAssertEqual(T(decoding:  "ffffffffffffffff", radix: 16),  T(UInt64.max))
        XCTAssertEqual(T(decoding: "+ffffffffffffffff", radix: 16),  T(UInt64.max))
        XCTAssertEqual(T(decoding: "-ffffffffffffffff", radix: 16), -T(UInt64.max))
    }
    
    func testDecodingRadix10() {
        XCTAssertEqual(T(decoding:  "18446744073709551615", radix: 10),  T(UInt64.max))
        XCTAssertEqual(T(decoding: "+18446744073709551615", radix: 10),  T(UInt64.max))
        XCTAssertEqual(T(decoding: "-18446744073709551615", radix: 10), -T(UInt64.max))
    }
    
    func testDecodingRadixLiteralAsNumber() {
        XCTAssertEqual(T(decoding:  "0x", radix: 36),  33)
        XCTAssertEqual(T(decoding:  "0o", radix: 36),  24)
        XCTAssertEqual(T(decoding:  "0b", radix: 36),  11)
        
        XCTAssertEqual(T(decoding: "-0x", radix: 36), -33)
        XCTAssertEqual(T(decoding: "-0o", radix: 36), -24)
        XCTAssertEqual(T(decoding: "-0b", radix: 36), -11)
    }
    
    func testDecodingStringsWithOrWithoutSignAndRadixLiteral() {
        XCTAssertEqual( "1234567890",         T( 1234567890         as Int64))
        XCTAssertEqual( "0x123456789abcdef0", T( 0x123456789abcdef0 as Int64))
        XCTAssertEqual( "0o1234567012345670", T( 0o1234567012345670 as Int64))
        XCTAssertEqual( "0b1010101010101010", T( 0b1010101010101010 as Int64))
        
        XCTAssertEqual("+1234567890",         T(+1234567890         as Int64))
        XCTAssertEqual("+0x123456789abcdef0", T(+0x123456789abcdef0 as Int64))
        XCTAssertEqual("+0o1234567012345670", T(+0o1234567012345670 as Int64))
        XCTAssertEqual("+0b1010101010101010", T(+0b1010101010101010 as Int64))
        
        XCTAssertEqual("-1234567890",         T(-1234567890         as Int64))
        XCTAssertEqual("-0x123456789abcdef0", T(-0x123456789abcdef0 as Int64))
        XCTAssertEqual("-0o1234567012345670", T(-0o1234567012345670 as Int64))
        XCTAssertEqual("-0b1010101010101010", T(-0b1010101010101010 as Int64))
    }
    
    func testDecodingPrefixingZerosHasNoEffect() {
        XCTAssertEqual(T(decoding: String(repeating: "0", count: 99) + "0"), T(0))
        XCTAssertEqual(T(decoding: String(repeating: "0", count: 99) + "1"), T(1))
    }
    
    func testDecodingValueOutsideOfRepresentableRangeReturnsNil() {
        let positive = "+" + String(repeating: "1", count: T.bitWidth)
        let negative = "-" + String(repeating: "1", count: T.bitWidth)
        
        for radix in 2 ... 36 {
            XCTAssertNil(T(decoding: positive, radix: radix))
            XCTAssertNil(T(decoding: negative, radix: radix))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Encode
    //=------------------------------------------------------------------------=
    
    func testEncodingRadix16() {
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: false),  "7" + String(repeating: "f", count: 63))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: true ),  "7" + String(repeating: "F", count: 63))
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: false), "-8" + String(repeating: "0", count: 63))
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: true ), "-8" + String(repeating: "0", count: 63))
    }
    
    func testEncodingRadix10() {
        XCTAssertEqual(String(encoding: T.min, radix: 10), "-57896044618658097711785492504343953926634992332820282019728792003956564819968")
        XCTAssertEqual(String(encoding: T.max, radix: 10),  "57896044618658097711785492504343953926634992332820282019728792003956564819967")
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Random
    //=------------------------------------------------------------------------=
    
    func testCodingRandomOneWordIntegers() {
        for _ in 0 ..< 10 {
            let r = Int .random(in: 2 ... 36)
            let u = Bool.random()
            
            let a = Int.random(in: Int.min ... Int.max)
            let b = T(a)
            
            let x = String(/*-----*/ a, radix: r, uppercase: u)
            let y = String(encoding: b, radix: r, uppercase: u)
            
            XCTAssertEqual(x, y)
            XCTAssertEqual(a, Int(x,  radix: r))
            XCTAssertEqual(b, T(decoding: y, radix: r))
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Text
//*============================================================================*

final class UInt256TestsOnText: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Decode
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix16() {
        XCTAssertEqual(T(decoding:  "ffffffffffffffff", radix: 16), T(UInt64.max))
        XCTAssertEqual(T(decoding: "+ffffffffffffffff", radix: 16), T(UInt64.max))
        XCTAssertEqual(T(decoding:  "FFFFFFFFFFFFFFFF", radix: 16), T(UInt64.max))
        XCTAssertEqual(T(decoding: "+FFFFFFFFFFFFFFFF", radix: 16), T(UInt64.max))
    }
    
    func testDecodingRadix10() {
        XCTAssertEqual(T(decoding:  "18446744073709551615", radix: 10), T(UInt64.max))
        XCTAssertEqual(T(decoding: "+18446744073709551615", radix: 10), T(UInt64.max))
    }
    
    func testDecodingRadixLiteralAsNumber() {
        XCTAssertEqual(T(decoding:  "0x", radix: 36), 33)
        XCTAssertEqual(T(decoding:  "0o", radix: 36), 24)
        XCTAssertEqual(T(decoding:  "0b", radix: 36), 11)
        
        XCTAssertEqual(T(decoding: "+0x", radix: 36), 33)
        XCTAssertEqual(T(decoding: "+0o", radix: 36), 24)
        XCTAssertEqual(T(decoding: "+0b", radix: 36), 11)
    }
    
    func testDecodingStringsWithOrWithoutSignAndRadixLiteral() {
        XCTAssertEqual( "1234567890",         T( 1234567890         as UInt64))
        XCTAssertEqual( "0x123456789abcdef0", T( 0x123456789abcdef0 as UInt64))
        XCTAssertEqual( "0o1234567012345670", T( 0o1234567012345670 as UInt64))
        XCTAssertEqual( "0b1010101010101010", T( 0b1010101010101010 as UInt64))
        
        XCTAssertEqual("+1234567890",         T(+1234567890         as UInt64))
        XCTAssertEqual("+0x123456789abcdef0", T(+0x123456789abcdef0 as UInt64))
        XCTAssertEqual("+0o1234567012345670", T(+0o1234567012345670 as UInt64))
        XCTAssertEqual("+0b1010101010101010", T(+0b1010101010101010 as UInt64))
    }
    
    func testDecodingPrefixingZerosHasNoEffect() {
        XCTAssertEqual(T(decoding: String(repeating: "0", count: 99) + "0"), T(0))
        XCTAssertEqual(T(decoding: String(repeating: "0", count: 99) + "1"), T(1))
    }
    
    func testDecodingValueOutsideOfRepresentableRangeReturnsNil() {
        let positive = "+" + String(repeating: "1", count: T.bitWidth + 1)
        let negative = "-" + String(repeating: "1", count: 1)
        
        for radix in 2 ... 36 {
            XCTAssertNil(T(decoding: positive, radix: radix))
            XCTAssertNil(T(decoding: negative, radix: radix))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Encode
    //=------------------------------------------------------------------------=
    
    func testEncodingRadix16() {
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: false), "0")
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: true ), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: false), String(repeating: "f", count: 64))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: true ), String(repeating: "F", count: 64))
    }
    
    func testEncodingRadix10() {
        XCTAssertEqual(String(encoding: T.min, radix: 10), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 10), "115792089237316195423570985008687907853269984665640564039457584007913129639935")
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Random
    //=------------------------------------------------------------------------=
    
    func testCodingRandomOneWordIntegers() {
        for _ in 0 ..< 10 {
            let r = Int .random(in: 2 ... 36)
            let u = Bool.random()
            
            let a = UInt.random(in: UInt.min ... UInt.max)
            let b = T(a)
            
            let x = String(/*-----*/ a, radix: r, uppercase: u)
            let y = String(encoding: b, radix: r, uppercase: u)
            
            XCTAssertEqual(x, y)
            XCTAssertEqual(a, UInt(x, radix: r))
            XCTAssertEqual(b, T(decoding: y, radix: r))
        }
    }
}

#endif
