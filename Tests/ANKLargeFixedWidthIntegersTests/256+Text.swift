//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKLargeFixedWidthIntegers
import XCTest

//*============================================================================*
// MARK: * Int256 x Text
//*============================================================================*

final class Int256TestsOnText: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testRadixLiteralAsNumber() {
        XCTAssertEqual(T(decode:  "0x", radix: 36),  33)
        XCTAssertEqual(T(decode:  "0o", radix: 36),  24)
        XCTAssertEqual(T(decode:  "0b", radix: 36),  11)
        XCTAssertEqual(T(decode: "-0x", radix: 36), -33)
        XCTAssertEqual(T(decode: "-0o", radix: 36), -24)
        XCTAssertEqual(T(decode: "-0b", radix: 36), -11)
    }
    
    func testStringLiterals() {
        XCTAssertEqual("1234567890",          T(1234567890))
        XCTAssertEqual("0x123456789abcdef0",  T(0x123456789abcdef0))
        XCTAssertEqual("0o1234567012345670",  T(0o1234567012345670))
        XCTAssertEqual("0b1010101010101010",  T(0b1010101010101010))

        XCTAssertEqual("-9876543210",         T(-9876543210))
        XCTAssertEqual("-0x123456789abcdef0", T(-0x123456789abcdef0))
        XCTAssertEqual("-0o1234567012345670", T(-0o1234567012345670))
        XCTAssertEqual("-0b1010101010101010", T(-0b1010101010101010))
    }
    
    func testDecodeKnownSample() {
        XCTAssertEqual(T(decode:  "0000000000000000", radix: 16),  T(0))
        XCTAssertEqual(T(decode: "+0000000000000000", radix: 16),  T(0))
        XCTAssertEqual(T(decode: "-0000000000000000", radix: 16),  T(0))
        XCTAssertEqual(T(decode:  "ffffffffffffffff", radix: 16),  T(UInt.max))
        XCTAssertEqual(T(decode: "+ffffffffffffffff", radix: 16),  T(UInt.max))
        XCTAssertEqual(T(decode: "-ffffffffffffffff", radix: 16), -T(UInt.max))
    }
    
    func testEncodeKnownSample() {
        XCTAssertEqual(String(encode: T( 0), radix: 10),  "0")
        XCTAssertEqual(String(encode: T( 0), radix: 16),  "0")
        
        XCTAssertEqual(String(encode: T(-1), radix: 10), "-1")
        XCTAssertEqual(String(encode: T(-1), radix: 16), "-1")
    }
    
    func testKnownSampleRoundTrip() {
        let s36 = "-zyxwvutsrqponmlkjihgfedcba9876543210"
        let s12 = "-989845357808467761b337462360bba70a5664a6599aa166a630"

        let u36 = T(decode: s36, radix: 36)!
        let u12 = T(decode: s12, radix: 12)!

        XCTAssertEqual(u36, u12)
        XCTAssertEqual(String(encode: u36, radix: 36), s36)
        XCTAssertEqual(String(encode: u12, radix: 12), s12)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Random
    //=------------------------------------------------------------------------=
    
    func testRandomSample() {
        for _ in 0 ..< 10 {
            let uppercase = Bool.random()
            let radix = Int.random(in:    2 ...   36)
            let small = Int.random(in: .min ... .max)
            let large = T(small)
            
            let smallText = String(/*---*/ small, radix: radix, uppercase: uppercase)
            let largeText = String(encode: large, radix: radix, uppercase: uppercase)
            
            XCTAssertEqual(smallText, largeText)
            XCTAssertEqual(Int(/*---*/ smallText, radix: radix), small)
            XCTAssertEqual(  T(decode: largeText, radix: radix), large)
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Text
//*============================================================================*

final class UInt256TestsOnText: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testRadixLiteralAsNumber() {
        XCTAssertEqual(T(decode:  "0x", radix: 36), 33)
        XCTAssertEqual(T(decode:  "0o", radix: 36), 24)
        XCTAssertEqual(T(decode:  "0b", radix: 36), 11)
        XCTAssertEqual(T(decode: "+0x", radix: 36), 33)
        XCTAssertEqual(T(decode: "+0o", radix: 36), 24)
        XCTAssertEqual(T(decode: "+0b", radix: 36), 11)
    }
    
    func testStringLiterals() {
        XCTAssertEqual("1234567890",          T(1234567890))
        XCTAssertEqual("0x123456789abcdef0",  T(0x123456789abcdef0))
        XCTAssertEqual("0o1234567012345670",  T(0o1234567012345670))
        XCTAssertEqual("0b1010101010101010",  T(0b1010101010101010))
    }
    
    func testDecodeKnownSample() {
        XCTAssertEqual(T(decode: "0000000000000000", radix: 16), T(0))
        XCTAssertEqual(T(decode: "ffffffffffffffff", radix: 16), T(UInt.max))
        
        XCTAssertEqual(T(decode: "+0000000000000000", radix: 16), T(0))
        XCTAssertEqual(T(decode: "+ffffffffffffffff", radix: 16), T(UInt.max))
        
        XCTAssertEqual(T(decode: "-0000000000000000", radix: 16), T(0))
        XCTAssertEqual(T(decode: "-ffffffffffffffff", radix: 16), nil )
        
        XCTAssertEqual(T(decode: String(repeating: "f", count: 64), radix: 16), .max)
        XCTAssertEqual(T(decode: String(repeating: "f", count: 65), radix: 16),  nil)
    }
    
    func testEncodeKnownSample() {
        XCTAssertEqual(String(encode: T(0), radix: 10), "0")
        XCTAssertEqual(String(encode: T(0), radix: 16), "0")
    }
    
    func testKnownSampleRoundTrip() {
        let s36 = "zyxwvutsrqponmlkjihgfedcba9876543210"
        let s12 = "989845357808467761b337462360bba70a5664a6599aa166a630"
        
        let u36 = T(decode: s36, radix: 36)!
        let u12 = T(decode: s12, radix: 12)!
                
        XCTAssertEqual(u36, u12)
        XCTAssertEqual(String(encode: u36, radix: 36), s36)
        XCTAssertEqual(String(encode: u12, radix: 12), s12)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Random
    //=------------------------------------------------------------------------=
    
    func testRandomSample() {
        for _ in 0 ..< 10 {
            let uppercase = Bool.random()
            let radix =  Int.random(in: 2 ...   36)
            let small = UInt.random(in: 0 ... .max)
            let large = T(small)
            
            let smallText = String(/*---*/ small, radix: radix, uppercase: uppercase)
            let largeText = String(encode: large, radix: radix, uppercase: uppercase)
            
            XCTAssertEqual(smallText, largeText)
            XCTAssertEqual(UInt(/*---*/ smallText, radix: radix), small)
            XCTAssertEqual(   T(decode: largeText, radix: radix), large)
        }
    }
}

#endif
