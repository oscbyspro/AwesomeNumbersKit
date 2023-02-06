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
    
    func testDecodingRadix36() {
        XCTAssertEqual(T.min, T(decoding: "-36ukv65j19b11mbvjyfui963v4my01krth19g3r3bk1ojlrwu8", radix: 36))
        XCTAssertEqual(T.max, T(decoding:  "36ukv65j19b11mbvjyfui963v4my01krth19g3r3bk1ojlrwu7", radix: 36))
    }
    
    func testDecodingRadix32() {
        XCTAssertEqual(T.min, T(decoding: "-1" + String(repeating: "0", count: 51), radix: 32))
        XCTAssertEqual(T.max, T(decoding:        String(repeating: "v", count: 51), radix: 32))
    }
    
    func testDecodingRadix16() {
        XCTAssertEqual(T.min, T(decoding: "-8" + String(repeating: "0", count: T.bitWidth / 4 - 1), radix: 16))
        XCTAssertEqual(T.max, T(decoding:  "7" + String(repeating: "f", count: T.bitWidth / 4 - 1), radix: 16))
    }
    
    func testDecodingRadix10() {
        XCTAssertEqual(T.min, T(decoding: "-57896044618658097711785492504343953926634992332820282019728792003956564819968", radix: 10))
        XCTAssertEqual(T.max, T(decoding:  "57896044618658097711785492504343953926634992332820282019728792003956564819967", radix: 10))
    }
    
    func testDecodingRadix8() {
        XCTAssertEqual(T.min, T(decoding: "-1" + String(repeating: "0", count: 85), radix: 8))
        XCTAssertEqual(T.max, T(decoding:        String(repeating: "7", count: 85), radix: 8))
    }
    
    func testDecodingRadix4() {
        XCTAssertEqual(T.min, T(decoding: "-2" + String(repeating: "0", count: T.bitWidth / 2 - 1), radix: 4))
        XCTAssertEqual(T.max, T(decoding:  "1" + String(repeating: "3", count: T.bitWidth / 2 - 1), radix: 4))
    }
    
    func testDecodingRadix2() {
        XCTAssertEqual(T.min, T(decoding: "-1" + String(repeating: "0", count: T.bitWidth / 1 - 1), radix: 2))
        XCTAssertEqual(T.max, T(decoding:        String(repeating: "1", count: T.bitWidth / 1 - 1), radix: 2))
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
    
    func testEncodingRadix36() {
        XCTAssertEqual(String(encoding: T.min, radix: 36, uppercase: false), "-36ukv65j19b11mbvjyfui963v4my01krth19g3r3bk1ojlrwu8")
        XCTAssertEqual(String(encoding: T.min, radix: 36, uppercase: true ), "-36UKV65J19B11MBVJYFUI963V4MY01KRTH19G3R3BK1OJLRWU8")
        XCTAssertEqual(String(encoding: T.max, radix: 36, uppercase: false),  "36ukv65j19b11mbvjyfui963v4my01krth19g3r3bk1ojlrwu7")
        XCTAssertEqual(String(encoding: T.max, radix: 36, uppercase: true ),  "36UKV65J19B11MBVJYFUI963V4MY01KRTH19G3R3BK1OJLRWU7")
    }
    
    func testEncodingRadix32() {
        XCTAssertEqual(String(encoding: T.min, radix: 32, uppercase: false), "-1" + String(repeating: "0", count: 51))
        XCTAssertEqual(String(encoding: T.min, radix: 32, uppercase: true ), "-1" + String(repeating: "0", count: 51))
        XCTAssertEqual(String(encoding: T.max, radix: 32, uppercase: false),        String(repeating: "v", count: 51))
        XCTAssertEqual(String(encoding: T.max, radix: 32, uppercase: true ),        String(repeating: "V", count: 51))
    }
    
    func testEncodingRadix16() {
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: false), "-8" + String(repeating: "0", count: T.bitWidth / 4 - 1))
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: true ), "-8" + String(repeating: "0", count: T.bitWidth / 4 - 1))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: false),  "7" + String(repeating: "f", count: T.bitWidth / 4 - 1))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: true ),  "7" + String(repeating: "F", count: T.bitWidth / 4 - 1))
    }
    
    func testEncodingRadix10() {
        XCTAssertEqual(String(encoding: T.min, radix: 10), "-57896044618658097711785492504343953926634992332820282019728792003956564819968")
        XCTAssertEqual(String(encoding: T.max, radix: 10),  "57896044618658097711785492504343953926634992332820282019728792003956564819967")
    }
    
    func testEncodingRadix8() {
        XCTAssertEqual(String(encoding: T.min, radix: 8), "-1" + String(repeating: "0", count: 85))
        XCTAssertEqual(String(encoding: T.max, radix: 8),        String(repeating: "7", count: 85))
    }
    
    func testEncodingRadix4() {
        XCTAssertEqual(String(encoding: T.min, radix: 4), "-2" + String(repeating: "0", count: T.bitWidth / 2 - 1))
        XCTAssertEqual(String(encoding: T.max, radix: 4),  "1" + String(repeating: "3", count: T.bitWidth / 2 - 1))
    }
    
    func testEncodingRadix2() {
        XCTAssertEqual(String(encoding: T.min, radix: 2), "-1" + String(repeating: "0", count: T.bitWidth / 1 - 1))
        XCTAssertEqual(String(encoding: T.max, radix: 2),        String(repeating: "1", count: T.bitWidth / 1 - 1))
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
    
    func testDecodingRadix36() {
        XCTAssertEqual(T.min, T(decoding: "0",  radix: 36))
        XCTAssertEqual(T.max, T(decoding: "6dp5qcb22im238nr3wvp0ic7q99w035jmy2iw7i6n43d37jtof", radix: 36))
    }
        
    func testDecodingRadix32() {
        XCTAssertEqual(T.min, T(decoding: "0",  radix: 32))
        XCTAssertEqual(T.max, T(decoding: "1" + String(repeating: "v", count: 51), radix: 32))
    }
    
    func testDecodingRadix16() {
        XCTAssertEqual(T.min, T(decoding: "0",  radix: 16))
        XCTAssertEqual(T.max, T(decoding: String(repeating: "f", count: T.bitWidth / 4), radix: 16))
    }
    
    func testDecodingRadix10() {
        XCTAssertEqual(T.min, T(decoding: "0",  radix: 10))
        XCTAssertEqual(T.max, T(decoding: "115792089237316195423570985008687907853269984665640564039457584007913129639935", radix: 10))
    }
    
    func testDecodingRadix8() {
        XCTAssertEqual(T.min, T(decoding: "0",  radix: 8))
        XCTAssertEqual(T.max, T(decoding: "1" + String(repeating: "7", count: 85), radix: 8))
    }
    
    func testDecodingRadix4() {
        XCTAssertEqual(T.min, T(decoding: "0",  radix: 4))
        XCTAssertEqual(T.max, T(decoding: String(repeating: "3", count: T.bitWidth / 2), radix: 4))
    }
    
    func testDecodingRadix2() {
        XCTAssertEqual(T.min, T(decoding: "0",  radix: 2))
        XCTAssertEqual(T.max, T(decoding: String(repeating: "1", count: T.bitWidth / 1), radix: 2))
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
    
    func testEncodingRadix36() {
        XCTAssertEqual(String(encoding: T.min, radix: 36, uppercase: false), "0")
        XCTAssertEqual(String(encoding: T.min, radix: 36, uppercase: true ), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 36, uppercase: false), "6dp5qcb22im238nr3wvp0ic7q99w035jmy2iw7i6n43d37jtof")
        XCTAssertEqual(String(encoding: T.max, radix: 36, uppercase: true ), "6DP5QCB22IM238NR3WVP0IC7Q99W035JMY2IW7I6N43D37JTOF")
    }
    
    func testEncodingRadix32() {
        XCTAssertEqual(String(encoding: T.min, radix: 32, uppercase: false), "0")
        XCTAssertEqual(String(encoding: T.min, radix: 32, uppercase: true ), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 32, uppercase: false), "1" + String(repeating: "v", count: 51))
        XCTAssertEqual(String(encoding: T.max, radix: 32, uppercase: true ), "1" + String(repeating: "V", count: 51))
    }
    
    func testEncodingRadix16() {
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: false), "0")
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: true ), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: false), String(repeating: "f", count: T.bitWidth / 4))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: true ), String(repeating: "F", count: T.bitWidth / 4))
    }
    
    func testEncodingRadix10() {
        XCTAssertEqual(String(encoding: T.min, radix: 10), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 10), "115792089237316195423570985008687907853269984665640564039457584007913129639935")
    }
    
    func testEncodingRadix8() {
        XCTAssertEqual(String(encoding: T.min, radix: 8), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 8), "1" + String(repeating: "7", count: 85))
    }
    
    func testEncodingRadix4() {
        XCTAssertEqual(String(encoding: T.min, radix: 4), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 4), String(repeating: "3", count: T.bitWidth / 2))
    }
    
    func testEncodingRadix2() {
        XCTAssertEqual(String(encoding: T.min, radix: 2), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 2), String(repeating: "1", count: T.bitWidth / 1))
    }
}

#endif
