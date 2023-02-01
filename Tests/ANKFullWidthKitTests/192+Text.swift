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
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: false),  "7" + String(repeating: "f", count: 47))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: true ),  "7" + String(repeating: "F", count: 47))
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: false), "-8" + String(repeating: "0", count: 47))
        XCTAssertEqual(String(encoding: T.min, radix: 16, uppercase: true ), "-8" + String(repeating: "0", count: 47))
    }
    
    func testEncodingRadix10() {
        XCTAssertEqual(String(encoding: T.min, radix: 10), "-3138550867693340381917894711603833208051177722232017256448")
        XCTAssertEqual(String(encoding: T.max, radix: 10),  "3138550867693340381917894711603833208051177722232017256447")
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
// MARK: * UInt192 x Text
//*============================================================================*

final class UInt192TestsOnText: XCTestCase {
    
    typealias T = ANKUInt192
    
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
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: false), String(repeating: "f", count: 48))
        XCTAssertEqual(String(encoding: T.max, radix: 16, uppercase: true ), String(repeating: "F", count: 48))
    }
    
    func testEncodingRadix10() {
        XCTAssertEqual(String(encoding: T.min, radix: 10), "0")
        XCTAssertEqual(String(encoding: T.max, radix: 10), "6277101735386680763835789423207666416102355444464034512895")
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
