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
// MARK: * Signed x Text
//*============================================================================*

final class SignedTestsOnText: XCTestCase {
    
    typealias T = ANKSigned<UInt64>
    typealias M = UInt64
    
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
        XCTAssertEqual( "1234567890",         T(1234567890))
        XCTAssertEqual( "0x123456789abcdef0", T(0x123456789abcdef0))
        XCTAssertEqual( "0o1234567012345670", T(0o1234567012345670))
        XCTAssertEqual( "0b1010101010101010", T(0b1010101010101010))
        
        XCTAssertEqual("+1234567890",         T(1234567890))
        XCTAssertEqual("+0x123456789abcdef0", T(0x123456789abcdef0))
        XCTAssertEqual("+0o1234567012345670", T(0o1234567012345670))
        XCTAssertEqual("+0b1010101010101010", T(0b1010101010101010))

        XCTAssertEqual("-9876543210",         T(-9876543210))
        XCTAssertEqual("-0x123456789abcdef0", T(-0x123456789abcdef0))
        XCTAssertEqual("-0o1234567012345670", T(-0o1234567012345670))
        XCTAssertEqual("-0b1010101010101010", T(-0b1010101010101010))
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
    
    func testEncodingRadix16() {
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: false),       String(repeating: "f", count: 16))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: true ),       String(repeating: "F", count: 16))
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: false), "-" + String(repeating: "f", count: 16))
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: true ), "-" + String(repeating: "F", count: 16))
    }
    
    func testEncodingRadix10() {
        XCTAssertEqual(String(encoding: T.min, radix: 10), "-18446744073709551615")
        XCTAssertEqual(String(encoding: T.max, radix: 10),  "18446744073709551615")
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

#endif
