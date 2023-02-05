//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed x Text
//*============================================================================*

final class ANKSignedTestsOnText: XCTestCase {
    
    typealias T = ANKSigned<UInt64>
    typealias M = UInt64
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Decode
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix36() {
        XCTAssertEqual(T.min, T(decoding: "-3w5e11264sgsf", radix: 36))
        XCTAssertEqual(T.max, T(decoding:  "3w5e11264sgsf", radix: 36))
    }
        
    func testDecodingRadix32() {
        XCTAssertEqual(T.min, T(decoding: "-f" + String(repeating: "v", count: 12), radix: 32))
        XCTAssertEqual(T.max, T(decoding:  "f" + String(repeating: "v", count: 12), radix: 32))
    }
    
    func testDecodingRadix16() {
        XCTAssertEqual(T.min, T(decoding: "-ffffffffffffffff", radix: 16))
        XCTAssertEqual(T.max, T(decoding: "+ffffffffffffffff", radix: 16))
    }
    
    func testDecodingRadix10() {
        XCTAssertEqual(T.min, T(decoding: "-18446744073709551615", radix: 10))
        XCTAssertEqual(T.max, T(decoding:  "18446744073709551615", radix: 10))
    }
    
    func testDecodingRadix8() {
        XCTAssertEqual(T.min, T(decoding: "-1" + String(repeating: "7", count: 21), radix: 8))
        XCTAssertEqual(T.max, T(decoding:  "1" + String(repeating: "7", count: 21), radix: 8))
    }
    
    func testDecodingRadix4() {
        XCTAssertEqual(T.min, T(decoding: "-" + String(repeating: "3", count: 32), radix: 4))
        XCTAssertEqual(T.max, T(decoding:       String(repeating: "3", count: 32), radix: 4))
    }
    
    func testDecodingRadix2() {
        XCTAssertEqual(T.min, T(decoding: "-" + String(repeating: "1", count: 64), radix: 2))
        XCTAssertEqual(T.max, T(decoding:       String(repeating: "1", count: 64), radix: 2))
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
        XCTAssertEqual( "1234567890",         T(Int64( "1234567890",       radix: 10)!))
        XCTAssertEqual( "0x123456789abcdef0", T(Int64( "123456789abcdef0", radix: 16)!))
        XCTAssertEqual( "0o1234567012345670", T(Int64( "1234567012345670", radix: 08)!))
        XCTAssertEqual( "0b1010101010101010", T(Int64( "1010101010101010", radix: 02)!))
        
        XCTAssertEqual("+1234567890",         T(Int64( "1234567890",       radix: 10)!))
        XCTAssertEqual("+0x123456789abcdef0", T(Int64( "123456789abcdef0", radix: 16)!))
        XCTAssertEqual("+0o1234567012345670", T(Int64( "1234567012345670", radix: 08)!))
        XCTAssertEqual("+0b1010101010101010", T(Int64( "1010101010101010", radix: 02)!))
        
        XCTAssertEqual("-9876543210",         T(Int64("-9876543210",       radix: 10)!))
        XCTAssertEqual("-0x123456789abcdef0", T(Int64("-123456789abcdef0", radix: 16)!))
        XCTAssertEqual("-0o1234567012345670", T(Int64("-1234567012345670", radix: 08)!))
        XCTAssertEqual("-0b1010101010101010", T(Int64("-1010101010101010", radix: 02)!))
    }
    
    func testDecodingPrefixingZerosHasNoEffect() {
        XCTAssertEqual(T(decoding: String(repeating: "0", count: 99) + "0"), T(0))
        XCTAssertEqual(T(decoding: String(repeating: "0", count: 99) + "1"), T(1))
    }
    
    func testDecodingValueOutsideOfRepresentableRangeReturnsNil() {
        let positive = "+" + String(repeating: "1", count: M.bitWidth + 1)
        let negative = "-" + String(repeating: "1", count: M.bitWidth + 1)
        
        for radix in 2 ... 36 {
            XCTAssertNil(T(decoding: positive, radix: radix))
            XCTAssertNil(T(decoding: negative, radix: radix))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Encode
    //=------------------------------------------------------------------------=
    
    func testEncodingRadix36() {
        XCTAssertEqual(String(encoding: T.min, radix: 36, uppercase: false), "-3w5e11264sgsf")
        XCTAssertEqual(String(encoding: T.min, radix: 36, uppercase: true ), "-3W5E11264SGSF")
        XCTAssertEqual(String(encoding: T.max, radix: 36, uppercase: false),  "3w5e11264sgsf")
        XCTAssertEqual(String(encoding: T.max, radix: 36, uppercase: true ),  "3W5E11264SGSF")
    }
    
    func testEncodingRadix32() {
        XCTAssertEqual(String(encoding: T.min, radix: 32, uppercase: false), "-f" + String(repeating: "v", count: 12))
        XCTAssertEqual(String(encoding: T.min, radix: 32, uppercase: true ), "-F" + String(repeating: "V", count: 12))
        XCTAssertEqual(String(encoding: T.max, radix: 32, uppercase: false),  "f" + String(repeating: "v", count: 12))
        XCTAssertEqual(String(encoding: T.max, radix: 32, uppercase: true ),  "F" + String(repeating: "V", count: 12))
    }
    
    func testEncodingRadix16() {
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: false), "-" + String(repeating: "f", count: 16))
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: true ), "-" + String(repeating: "F", count: 16))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: false),       String(repeating: "f", count: 16))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: true ),       String(repeating: "F", count: 16))
    }
    
    func testEncodingRadix10() {
        XCTAssertEqual(String(encoding: T.min, radix: 10), "-18446744073709551615")
        XCTAssertEqual(String(encoding: T.max, radix: 10),  "18446744073709551615")
    }
    
    func testEncodingRadix8() {
        XCTAssertEqual(String(encoding: T.min, radix: 8), "-1" + String(repeating: "7", count: 21))
        XCTAssertEqual(String(encoding: T.max, radix: 8),  "1" + String(repeating: "7", count: 21))
    }
    
    func testEncodingRadix4() {
        XCTAssertEqual(String(encoding: T.min, radix: 4), "-" + String(repeating: "3", count: 32))
        XCTAssertEqual(String(encoding: T.max, radix: 4),       String(repeating: "3", count: 32))
    }
    
    func testEncodingRadix2() {
        XCTAssertEqual(String(encoding: T.min, radix: 2), "-" + String(repeating: "1", count: 64))
        XCTAssertEqual(String(encoding: T.max, radix: 2),       String(repeating: "1", count: 64))
    }
}

#endif
