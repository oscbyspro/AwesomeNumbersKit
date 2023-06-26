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
        ANKAssertDecodeText(T.min, 02, "-" + String(repeating: "1", count: M.bitWidth / 1))
        ANKAssertDecodeText(T.max, 02,       String(repeating: "1", count: M.bitWidth / 1))
    }
    
    func testDecodingRadix03() {
        ANKAssertDecodeText(T.min, 03, "-11112220022122120101211020120210210211220")
        ANKAssertDecodeText(T.max, 03,  "11112220022122120101211020120210210211220")
    }
    
    func testDecodingRadix04() {
        ANKAssertDecodeText(T.min, 04, "-" + String(repeating: "3", count: M.bitWidth / 2))
        ANKAssertDecodeText(T.max, 04,       String(repeating: "3", count: M.bitWidth / 2))
    }
    
    func testDecodingRadix08() {
        ANKAssertDecodeText(T.min, 08, "-1" + String(repeating: "7", count: 21))
        ANKAssertDecodeText(T.max, 08,  "1" + String(repeating: "7", count: 21))
    }
    
    func testDecodingRadix10() {
        ANKAssertDecodeText(T.min, 10, "-18446744073709551615")
        ANKAssertDecodeText(T.max, 10,  "18446744073709551615")
    }

    func testDecodingRadix16() {
        ANKAssertDecodeText(T.min, 16, "-" + String(repeating: "f", count: M.bitWidth / 4))
        ANKAssertDecodeText(T.max, 16,       String(repeating: "f", count: M.bitWidth / 4))
    }
    
    func testDecodingRadix32() {
        ANKAssertDecodeText(T.min, 32, "-f" + String(repeating: "v", count: 12))
        ANKAssertDecodeText(T.max, 32,  "f" + String(repeating: "v", count: 12))
    }
    
    func testDecodingRadix36() {
        ANKAssertDecodeText(T.min, 36, "-3w5e11264sgsf")
        ANKAssertDecodeText(T.max, 36,  "3w5e11264sgsf")
    }
    
    func testDecodingRadixLiteralAsNumber() {
        ANKAssertDecodeText(T( 33), 36,  "0x")
        ANKAssertDecodeText(T( 24), 36,  "0o")
        ANKAssertDecodeText(T( 11), 36,  "0b")
        
        ANKAssertDecodeText(T( 33), 36, "+0x")
        ANKAssertDecodeText(T( 24), 36, "+0o")
        ANKAssertDecodeText(T( 11), 36, "+0b")
        
        ANKAssertDecodeText(T(-33), 36, "-0x")
        ANKAssertDecodeText(T(-24), 36, "-0o")
        ANKAssertDecodeText(T(-11), 36, "-0b")
    }
    
    func testDecodingRadixLiteralAsRadixReturnsNil() {
        ANKAssertDecodeText(T?.none, 10,  "0x10")
        ANKAssertDecodeText(T?.none, 10,  "0o10")
        ANKAssertDecodeText(T?.none, 10,  "0b10")
        
        ANKAssertDecodeText(T?.none, 10, "+0x10")
        ANKAssertDecodeText(T?.none, 10, "+0o10")
        ANKAssertDecodeText(T?.none, 10, "+0b10")
        
        ANKAssertDecodeText(T?.none, 10, "-0x10")
        ANKAssertDecodeText(T?.none, 10, "-0o10")
        ANKAssertDecodeText(T?.none, 10, "-0b10")
    }
    
    func testDecodingStringsWithAndWithoutSign() {
        ANKAssertDecodeText(T( 1234567890), 10,  "1234567890")
        ANKAssertDecodeText(T( 1234567890), 10, "+1234567890")
        ANKAssertDecodeText(T(-1234567890), 10, "-1234567890")
    }
    
    func testDecodingStrategyIsCaseInsensitive() {
        ANKAssertDecodeText(T(0xabcdef), 16, "abcdef")
        ANKAssertDecodeText(T(0xABCDEF), 16, "ABCDEF")
        ANKAssertDecodeText(T(0xaBcDeF), 16, "aBcDeF")
        ANKAssertDecodeText(T(0xAbCdEf), 16, "AbCdEf")
    }
    
    func testDecodingUnalignedStringsIsOK() {
        ANKAssertDecodeText(T(1), 10, "1")
        ANKAssertDecodeText(T(1), 16, "1")
    }
    
    func testDecodingPrefixingZerosHasNoEffect() {
        let zero = String(repeating: "0", count: M.bitWidth) + "0"
        let one  = String(repeating: "0", count: M.bitWidth) + "1"
        
        for radix in 02 ... 36 {
            ANKAssertDecodeText(T(0), radix, zero)
            ANKAssertDecodeText(T(1), radix, one )
        }
    }
        
    func testDecodingInvalidCharactersReturnsNil() {
        ANKAssertDecodeText(T?.none, 16, "/")
        ANKAssertDecodeText(T?.none, 16, "G")

        ANKAssertDecodeText(T?.none, 10, "/")
        ANKAssertDecodeText(T?.none, 10, ":")

        ANKAssertDecodeText(T?.none, 10, String(repeating: "1", count: 19) + "/")
        ANKAssertDecodeText(T?.none, 10, String(repeating: "1", count: 19) + ":")
    }
    
    func testDecodingStringsWithoutDigitsReturnsNil() {
        ANKAssertDecodeText(T?.none, 10,  "")
        ANKAssertDecodeText(T?.none, 10, "+")
        ANKAssertDecodeText(T?.none, 10, "-")
        ANKAssertDecodeText(T?.none, 10, "~")
        
        ANKAssertDecodeText(T?.none, 16,  "")
        ANKAssertDecodeText(T?.none, 16, "+")
        ANKAssertDecodeText(T?.none, 16, "-")
        ANKAssertDecodeText(T?.none, 16, "~")
    }
    
    func testDecodingValuesOutsideOfRepresentableRangeReturnsNil() {
        let positive = "+" + String(repeating: "1", count: M.bitWidth + 1)
        let negative = "-" + String(repeating: "1", count: M.bitWidth + 1)
        
        for radix in 02 ... 36 {
            ANKAssertDecodeText(T?.none, radix, positive)
            ANKAssertDecodeText(T?.none, radix, negative)
        }
        
        ANKAssertDecodeText(T?.none, 36, "-3w5e11264sgsg" ) // - 01
        ANKAssertDecodeText(T?.none, 36, "-3w5e11264sgsf0") // * 36
        ANKAssertDecodeText(T?.none, 36,  "3w5e11264sgsg" ) // + 01
        ANKAssertDecodeText(T?.none, 36,  "3w5e11264sgsf0") // * 36
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Encode
    //=------------------------------------------------------------------------=
    
    func testEncodingRadix02() {
        ANKAssertEncodeText(T.min, 02, false, "-" + String(repeating: "1", count: M.bitWidth / 1))
        ANKAssertEncodeText(T.max, 02, false,       String(repeating: "1", count: M.bitWidth / 1))
    }
    
    func testEncodingRadix03() {
        ANKAssertEncodeText(T.min, 03, false, "-11112220022122120101211020120210210211220")
        ANKAssertEncodeText(T.max, 03, false,  "11112220022122120101211020120210210211220")
    }
    
    func testEncodingRadix04() {
        ANKAssertEncodeText(T.min, 04, false, "-" + String(repeating: "3", count: M.bitWidth / 2))
        ANKAssertEncodeText(T.max, 04, false,       String(repeating: "3", count: M.bitWidth / 2))
    }
    
    func testEncodingRadix08() {
        ANKAssertEncodeText(T.min, 08, false, "-1" + String(repeating: "7", count: 21))
        ANKAssertEncodeText(T.max, 08, false,  "1" + String(repeating: "7", count: 21))
    }
    
    func testEncodingRadix10() {
        ANKAssertEncodeText(T.min, 10, false, "-18446744073709551615")
        ANKAssertEncodeText(T.max, 10, false,  "18446744073709551615")
    }
    
    func testEncodingRadix16() {
        ANKAssertEncodeText(T.min, 16, false, "-" + String(repeating: "f", count: M.bitWidth / 4))
        ANKAssertEncodeText(T.min, 16, true , "-" + String(repeating: "F", count: M.bitWidth / 4))
        ANKAssertEncodeText(T.max, 16, false,       String(repeating: "f", count: M.bitWidth / 4))
        ANKAssertEncodeText(T.max, 16, true ,       String(repeating: "F", count: M.bitWidth / 4))
    }
    
    func testEncodingRadix32() {
        ANKAssertEncodeText(T.min, 32, false, "-f" + String(repeating: "v", count: 12))
        ANKAssertEncodeText(T.min, 32, true , "-F" + String(repeating: "V", count: 12))
        ANKAssertEncodeText(T.max, 32, false,  "f" + String(repeating: "v", count: 12))
        ANKAssertEncodeText(T.max, 32, true ,  "F" + String(repeating: "V", count: 12))
    }
    
    func testEncodingRadix36() {
        ANKAssertEncodeText(T.min, 36, false, "-3w5e11264sgsf")
        ANKAssertEncodeText(T.min, 36, true , "-3W5E11264SGSF")
        ANKAssertEncodeText(T.max, 36, false,  "3w5e11264sgsf")
        ANKAssertEncodeText(T.max, 36, true ,  "3W5E11264SGSF")
    }
}

#endif
