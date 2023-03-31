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
    
    func testDecodingRadix02() {
        XCTAssertEqual(T.min, T(decoding: "-" + String(repeating: "1", count: M.bitWidth / 1), radix: 2))
        XCTAssertEqual(T.max, T(decoding:       String(repeating: "1", count: M.bitWidth / 1), radix: 2))
    }
    
    func testDecodingRadix04() {
        XCTAssertEqual(T.min, T(decoding: "-" + String(repeating: "3", count: M.bitWidth / 2), radix: 4))
        XCTAssertEqual(T.max, T(decoding:       String(repeating: "3", count: M.bitWidth / 2), radix: 4))
    }
    
    func testDecodingRadix08() {
        XCTAssertEqual(T.min, T(decoding: "-1" + String(repeating: "7", count: 21), radix: 8))
        XCTAssertEqual(T.max, T(decoding:  "1" + String(repeating: "7", count: 21), radix: 8))
    }
    
    func testDecodingRadix10() {
        XCTAssertEqual(T.min, T(decoding: "-18446744073709551615", radix: 10))
        XCTAssertEqual(T.max, T(decoding:  "18446744073709551615", radix: 10))
    }

    func testDecodingRadix16() {
        XCTAssertEqual(T.min, T(decoding: "-" + String(repeating: "f", count: M.bitWidth / 4), radix: 16))
        XCTAssertEqual(T.max, T(decoding:       String(repeating: "f", count: M.bitWidth / 4), radix: 16))
    }
    
    func testDecodingRadix32() {
        XCTAssertEqual(T.min, T(decoding: "-f" + String(repeating: "v", count: 12), radix: 32))
        XCTAssertEqual(T.max, T(decoding:  "f" + String(repeating: "v", count: 12), radix: 32))
    }
    
    func testDecodingRadix36() {
        XCTAssertEqual(T.min, T(decoding: "-3w5e11264sgsf", radix: 36))
        XCTAssertEqual(T.max, T(decoding:  "3w5e11264sgsf", radix: 36))
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
        XCTAssertEqual(T(decoding:  "1234567890"),         T( 1234567890         as Int64))
        XCTAssertEqual(T(decoding:  "0x123456789abcdef0"), T( 0x123456789abcdef0 as Int64))
        XCTAssertEqual(T(decoding:  "0o1234567012345670"), T( 0o1234567012345670 as Int64))
        XCTAssertEqual(T(decoding:  "0b1010101010101010"), T( 0b1010101010101010 as Int64))
        
        XCTAssertEqual(T(decoding: "+1234567890"),         T(+1234567890         as Int64))
        XCTAssertEqual(T(decoding: "+0x123456789abcdef0"), T(+0x123456789abcdef0 as Int64))
        XCTAssertEqual(T(decoding: "+0o1234567012345670"), T(+0o1234567012345670 as Int64))
        XCTAssertEqual(T(decoding: "+0b1010101010101010"), T(+0b1010101010101010 as Int64))
        
        XCTAssertEqual(T(decoding: "-1234567890"),         T(-1234567890         as Int64))
        XCTAssertEqual(T(decoding: "-0x123456789abcdef0"), T(-0x123456789abcdef0 as Int64))
        XCTAssertEqual(T(decoding: "-0o1234567012345670"), T(-0o1234567012345670 as Int64))
        XCTAssertEqual(T(decoding: "-0b1010101010101010"), T(-0b1010101010101010 as Int64))
    }
    
    func testDecodingPrefixingZerosHasNoEffect() {
        let zero = String(repeating: "0", count: M.bitWidth) + "0"
        let one  = String(repeating: "0", count: M.bitWidth) + "1"
        
        for radix in 2 ... 36 {
            XCTAssertEqual(T(decoding: zero, radix: radix), T(0))
            XCTAssertEqual(T(decoding: one,  radix: radix), T(1))
        }
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
    
    func testEncodingRadix02() {
        XCTAssertEqual(String(encoding: T.min, radix: 2), "-" + String(repeating: "1", count: M.bitWidth / 1))
        XCTAssertEqual(String(encoding: T.max, radix: 2),       String(repeating: "1", count: M.bitWidth / 1))
    }
    
    func testEncodingRadix04() {
        XCTAssertEqual(String(encoding: T.min, radix: 4), "-" + String(repeating: "3", count: M.bitWidth / 2))
        XCTAssertEqual(String(encoding: T.max, radix: 4),       String(repeating: "3", count: M.bitWidth / 2))
    }
    
    func testEncodingRadix08() {
        XCTAssertEqual(String(encoding: T.min, radix: 8), "-1" + String(repeating: "7", count: 21))
        XCTAssertEqual(String(encoding: T.max, radix: 8),  "1" + String(repeating: "7", count: 21))
    }
    
    func testEncodingRadix10() {
        XCTAssertEqual(String(encoding: T.min, radix: 10), "-18446744073709551615")
        XCTAssertEqual(String(encoding: T.max, radix: 10),  "18446744073709551615")
    }
    
    func testEncodingRadix16() {
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: false), "-" + String(repeating: "f", count: M.bitWidth / 4))
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: true ), "-" + String(repeating: "F", count: M.bitWidth / 4))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: false),       String(repeating: "f", count: M.bitWidth / 4))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: true ),       String(repeating: "F", count: M.bitWidth / 4))
    }
    
    func testEncodingRadix32() {
        XCTAssertEqual(String(encoding: T.min, radix: 32, uppercase: false), "-f" + String(repeating: "v", count: 12))
        XCTAssertEqual(String(encoding: T.min, radix: 32, uppercase: true ), "-F" + String(repeating: "V", count: 12))
        XCTAssertEqual(String(encoding: T.max, radix: 32, uppercase: false),  "f" + String(repeating: "v", count: 12))
        XCTAssertEqual(String(encoding: T.max, radix: 32, uppercase: true ),  "F" + String(repeating: "V", count: 12))
    }
    
    func testEncodingRadix36() {
        XCTAssertEqual(String(encoding: T.min, radix: 36, uppercase: false), "-3w5e11264sgsf")
        XCTAssertEqual(String(encoding: T.min, radix: 36, uppercase: true ), "-3W5E11264SGSF")
        XCTAssertEqual(String(encoding: T.max, radix: 36, uppercase: false),  "3w5e11264sgsf")
        XCTAssertEqual(String(encoding: T.max, radix: 36, uppercase: true ),  "3W5E11264SGSF")
    }
}

#endif
