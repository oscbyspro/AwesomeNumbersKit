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

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192 x Text
//*============================================================================*

final class Int192TestsOnText: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Decode
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix02() {
        XCTAssertEqual(T.min, T(decoding: "-1" + String(repeating: "0", count: T.bitWidth / 1 - 1), radix: 2))
        XCTAssertEqual(T.max, T(decoding:        String(repeating: "1", count: T.bitWidth / 1 - 1), radix: 2))
    }
    
    func testDecodingRadix04() {
        XCTAssertEqual(T.min, T(decoding: "-2" + String(repeating: "0", count: T.bitWidth / 2 - 1), radix: 4))
        XCTAssertEqual(T.max, T(decoding:  "1" + String(repeating: "3", count: T.bitWidth / 2 - 1), radix: 4))
    }

    func testDecodingRadix08() {
        XCTAssertEqual(T.min, T(decoding: "-4" + String(repeating: "0", count: 63), radix: 8))
        XCTAssertEqual(T.max, T(decoding:  "3" + String(repeating: "7", count: 63), radix: 8))
    }
    
    func testDecodingRadix10() {
        XCTAssertEqual(T.min, T(decoding: "-3138550867693340381917894711603833208051177722232017256448", radix: 10))
        XCTAssertEqual(T.max, T(decoding:  "3138550867693340381917894711603833208051177722232017256447", radix: 10))
    }
    
    func testDecodingRadix16() {
        XCTAssertEqual(T.min, T(decoding: "-8" + String(repeating: "0", count: T.bitWidth / 4 - 1), radix: 16))
        XCTAssertEqual(T.max, T(decoding:  "7" + String(repeating: "f", count: T.bitWidth / 4 - 1), radix: 16))
    }
    
    func testDecodingRadix32() {
        XCTAssertEqual(T.min, T(decoding: "-2" + String(repeating: "0", count: 38), radix: 32))
        XCTAssertEqual(T.max, T(decoding:  "1" + String(repeating: "v", count: 38), radix: 32))
    }
    
    func testDecodingRadix36() {
        XCTAssertEqual(T.min, T(decoding: "-ti1ia748rltwhw44z5hik9fpnjcgcvuf8do8w", radix: 36))
        XCTAssertEqual(T.max, T(decoding:  "ti1ia748rltwhw44z5hik9fpnjcgcvuf8do8v", radix: 36))
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
        XCTAssertEqual(T(decoding:  "1234567890"),          1234567890        )
        XCTAssertEqual(T(decoding:  "0x123456789abcdef0"),  0x123456789abcdef0)
        XCTAssertEqual(T(decoding:  "0o1234567012345670"),  0o1234567012345670)
        XCTAssertEqual(T(decoding:  "0b1010101010101010"),  0b1010101010101010)
        
        XCTAssertEqual(T(decoding: "+1234567890"),          1234567890        )
        XCTAssertEqual(T(decoding: "+0x123456789abcdef0"),  0x123456789abcdef0)
        XCTAssertEqual(T(decoding: "+0o1234567012345670"),  0o1234567012345670)
        XCTAssertEqual(T(decoding: "+0b1010101010101010"),  0b1010101010101010)
        
        XCTAssertEqual(T(decoding: "-1234567890"),         -1234567890        )
        XCTAssertEqual(T(decoding: "-0x123456789abcdef0"), -0x123456789abcdef0)
        XCTAssertEqual(T(decoding: "-0o1234567012345670"), -0o1234567012345670)
        XCTAssertEqual(T(decoding: "-0b1010101010101010"), -0b1010101010101010)
    }
    
    func testDecodingPrefixingZerosHasNoEffect() {
        let zero = String(repeating: "0", count: T.bitWidth) + "0"
        let one  = String(repeating: "0", count: T.bitWidth) + "1"
        
        for radix in 2 ... 36 {
            XCTAssertEqual(T(decoding: zero, radix: radix), T(0))
            XCTAssertEqual(T(decoding: one,  radix: radix), T(1))
        }
    }
    
    func testDecodingStringWithoutDigitsReturnsNil() {
        XCTAssertNil(T(decoding:  "", radix: 10))
        XCTAssertNil(T(decoding: "+", radix: 10))
        XCTAssertNil(T(decoding: "-", radix: 10))
        XCTAssertNil(T(decoding: "~", radix: 10))

        XCTAssertNil(T(decoding:  "", radix: 16))
        XCTAssertNil(T(decoding: "+", radix: 16))
        XCTAssertNil(T(decoding: "-", radix: 16))
        XCTAssertNil(T(decoding: "~", radix: 16))
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
    
    func testEncodingRadix02() {
        XCTAssertEqual(String(encoding: T.min, radix: 2), "-1" + String(repeating: "0", count: T.bitWidth / 1 - 1))
        XCTAssertEqual(String(encoding: T.max, radix: 2),        String(repeating: "1", count: T.bitWidth / 1 - 1))
    }
    
    func testEncodingRadix04() {
        XCTAssertEqual(String(encoding: T.min, radix: 4), "-2" + String(repeating: "0", count: T.bitWidth / 2 - 1))
        XCTAssertEqual(String(encoding: T.max, radix: 4),  "1" + String(repeating: "3", count: T.bitWidth / 2 - 1))
    }
    
    func testEncodingRadix08() {
        XCTAssertEqual(String(encoding: T.min, radix: 8), "-4" + String(repeating: "0", count: 63))
        XCTAssertEqual(String(encoding: T.max, radix: 8),  "3" + String(repeating: "7", count: 63))
    }
    
    func testEncodingRadix10() {
        XCTAssertEqual(String(encoding: T.min, radix: 10), "-3138550867693340381917894711603833208051177722232017256448")
        XCTAssertEqual(String(encoding: T.max, radix: 10),  "3138550867693340381917894711603833208051177722232017256447")
    }
    
    func testEncodingRadix16() {
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: false), "-8" + String(repeating: "0", count: T.bitWidth / 4 - 1))
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: true ), "-8" + String(repeating: "0", count: T.bitWidth / 4 - 1))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: false),  "7" + String(repeating: "f", count: T.bitWidth / 4 - 1))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: true ),  "7" + String(repeating: "F", count: T.bitWidth / 4 - 1))
    }
    
    func testEncodingRadix32() {
        XCTAssertEqual(String(encoding: T.min, radix: 32, uppercase: false), "-2" + String(repeating: "0", count: 38))
        XCTAssertEqual(String(encoding: T.min, radix: 32, uppercase: true ), "-2" + String(repeating: "0", count: 38))
        XCTAssertEqual(String(encoding: T.max, radix: 32, uppercase: false),  "1" + String(repeating: "v", count: 38))
        XCTAssertEqual(String(encoding: T.max, radix: 32, uppercase: true ),  "1" + String(repeating: "V", count: 38))
    }
    
    func testEncodingRadix36() {
        XCTAssertEqual(String(encoding: T.min, radix: 36, uppercase: false), "-ti1ia748rltwhw44z5hik9fpnjcgcvuf8do8w")
        XCTAssertEqual(String(encoding: T.min, radix: 36, uppercase: true ), "-TI1IA748RLTWHW44Z5HIK9FPNJCGCVUF8DO8W")
        XCTAssertEqual(String(encoding: T.max, radix: 36, uppercase: false),  "ti1ia748rltwhw44z5hik9fpnjcgcvuf8do8v")
        XCTAssertEqual(String(encoding: T.max, radix: 36, uppercase: true ),  "TI1IA748RLTWHW44Z5HIK9FPNJCGCVUF8DO8V")
    }
}

//*============================================================================*
// MARK: * UInt192 x Text
//*============================================================================*

final class UInt192TestsOnText: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Decode
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix02() {
        XCTAssertEqual(T.min, T(decoding: "0",  radix: 2))
        XCTAssertEqual(T.max, T(decoding: String(repeating: "1", count: T.bitWidth / 1), radix: 2))
    }
    
    func testDecodingRadix04() {
        XCTAssertEqual(T.min, T(decoding: "0",  radix: 4))
        XCTAssertEqual(T.max, T(decoding: String(repeating: "3", count: T.bitWidth / 2), radix: 4))
    }
    
    func testDecodingRadix08() {
        XCTAssertEqual(T.min, T(decoding: "0",  radix: 8))
        XCTAssertEqual(T.max, T(decoding: String(repeating: "7", count: 64), radix: 8))
    }
    
    func testDecodingRadix10() {
        XCTAssertEqual(T.min, T(decoding: "0",  radix: 10))
        XCTAssertEqual(T.max, T(decoding: "6277101735386680763835789423207666416102355444464034512895", radix: 10))
    }
    
    func testDecodingRadix16() {
        XCTAssertEqual(T.min, T(decoding: "0",  radix: 16))
        XCTAssertEqual(T.max, T(decoding: String(repeating: "f", count: T.bitWidth / 4), radix: 16))
    }
    
    func testDecodingRadix32() {
        XCTAssertEqual(T.min, T(decoding: "0",  radix: 32))
        XCTAssertEqual(T.max, T(decoding: "3" + String(repeating: "v", count: 38), radix: 32))
    }
    
    func testDecodingRadix36() {
        XCTAssertEqual(T.min, T(decoding: "0",  radix: 36))
        XCTAssertEqual(T.max, T(decoding: "1n030ke8hj7nszs89yaz14ivfb2owprougrchr", radix: 36))
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
        XCTAssertEqual(T(decoding:  "1234567890"),         1234567890        )
        XCTAssertEqual(T(decoding:  "0x123456789abcdef0"), 0x123456789abcdef0)
        XCTAssertEqual(T(decoding:  "0o1234567012345670"), 0o1234567012345670)
        XCTAssertEqual(T(decoding:  "0b1010101010101010"), 0b1010101010101010)
        
        XCTAssertEqual(T(decoding: "+1234567890"),         1234567890        )
        XCTAssertEqual(T(decoding: "+0x123456789abcdef0"), 0x123456789abcdef0)
        XCTAssertEqual(T(decoding: "+0o1234567012345670"), 0o1234567012345670)
        XCTAssertEqual(T(decoding: "+0b1010101010101010"), 0b1010101010101010)
    }
    
    func testDecodingPrefixingZerosHasNoEffect() {
        let zero = String(repeating: "0", count: T.bitWidth) + "0"
        let one  = String(repeating: "0", count: T.bitWidth) + "1"
        
        for radix in 2 ... 36 {
            XCTAssertEqual(T(decoding: zero, radix: radix), T(0))
            XCTAssertEqual(T(decoding: one,  radix: radix), T(1))
        }
    }
    
    func testDecodingStringWithoutDigitsReturnsNil() {
        XCTAssertNil(T(decoding:  "", radix: 10))
        XCTAssertNil(T(decoding: "+", radix: 10))
        XCTAssertNil(T(decoding: "-", radix: 10))
        XCTAssertNil(T(decoding: "~", radix: 10))

        XCTAssertNil(T(decoding:  "", radix: 16))
        XCTAssertNil(T(decoding: "+", radix: 16))
        XCTAssertNil(T(decoding: "-", radix: 16))
        XCTAssertNil(T(decoding: "~", radix: 16))
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
    
    func testEncodingRadix02() {
        XCTAssertEqual(String(encoding: T.min, radix: 2), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 2), String(repeating: "1", count: T.bitWidth / 1))
    }
    
    func testEncodingRadix04() {
        XCTAssertEqual(String(encoding: T.min, radix: 4), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 4), String(repeating: "3", count: T.bitWidth / 2))
    }
    
    func testEncodingRadix08() {
        XCTAssertEqual(String(encoding: T.min, radix: 8), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 8), String(repeating: "7", count: 64))
    }
    
    func testEncodingRadix10() {
        XCTAssertEqual(String(encoding: T.min, radix: 10), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 10), "6277101735386680763835789423207666416102355444464034512895")
    }
    
    func testEncodingRadix16() {
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: false), "0")
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: true ), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: false), String(repeating: "f", count: T.bitWidth / 4))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: true ), String(repeating: "F", count: T.bitWidth / 4))
    }
    
    func testEncodingRadix32() {
        XCTAssertEqual(String(encoding: T.min, radix: 32, uppercase: false), "0")
        XCTAssertEqual(String(encoding: T.min, radix: 32, uppercase: true ), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 32, uppercase: false), "3" + String(repeating: "v", count: 38))
        XCTAssertEqual(String(encoding: T.max, radix: 32, uppercase: true ), "3" + String(repeating: "V", count: 38))
    }
    
    func testEncodingRadix36() {
        XCTAssertEqual(String(encoding: T.min, radix: 36, uppercase: false), "0")
        XCTAssertEqual(String(encoding: T.min, radix: 36, uppercase: true ), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 36, uppercase: false), "1n030ke8hj7nszs89yaz14ivfb2owprougrchr")
        XCTAssertEqual(String(encoding: T.max, radix: 36, uppercase: true ), "1N030KE8HJ7NSZS89YAZ14IVFB2OWPROUGRCHR")
    }
}

#endif
