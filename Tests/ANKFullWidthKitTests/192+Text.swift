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
import ANKFullWidthKit
import XCTest

private typealias X = ANK.U192X64
private typealias Y = ANK.U192X32

//*============================================================================*
// MARK: * ANK x Int192 x Text
//*============================================================================*

final class Int192TestsOnText: XCTestCase {
    
    typealias T  = Int192
    typealias T2 = ANKFullWidth<T, T.Magnitude>
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInitDescription() {
        XCTAssertEqual(T(   "10"),  10)
        XCTAssertEqual(T(  "+10"),  10)
        XCTAssertEqual(T(  "-10"), -10)
        XCTAssertEqual(T(  " 10"), nil)
        
        XCTAssertEqual(T( "0x10"), nil)
        XCTAssertEqual(T("+0x10"), nil)
        XCTAssertEqual(T("-0x10"), nil)
        XCTAssertEqual(T(" 0x10"), nil)
    }
    
    func testInstanceDescriptionUsesRadix10() {
        XCTAssertEqual( "10", T( 10).description)
        XCTAssertEqual("-10", T(-10).description)
        
        XCTAssertEqual( "10", String(describing: T( 10)))
        XCTAssertEqual("-10", String(describing: T(-10)))
    }
    
    func testMetaTypeDescriptionIsSimple() {
        XCTAssertEqual("Int192", T .description)
        XCTAssertEqual("Int384", T2.description)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Decode
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix02() {
        ANKAssertDecodeText(T.min, 2, "-1" + String(repeating: "0", count: T.bitWidth / 1 - 1))
        ANKAssertDecodeText(T.max, 2,        String(repeating: "1", count: T.bitWidth / 1 - 1))
    }
    
    func testDecodingRadix03() {
        ANKAssertDecodeText(T.min, 3,
        /*-----------------------*/ "-120201102001101000002" +
        "22102210012020102021201210011100212110221222012012" +
        "00011102210020110020202220120111200122011002002212" )
        ANKAssertDecodeText(T.max, 3,
        /*------------------------*/ "120201102001101000002" +
        "22102210012020102021201210011100212110221222012012" +
        "00011102210020110020202220120111200122011002002211" )
    }
    
    func testDecodingRadix04() {
        ANKAssertDecodeText(T.min, 4, "-2" + String(repeating: "0", count: T.bitWidth / 2 - 1))
        ANKAssertDecodeText(T.max, 4,  "1" + String(repeating: "3", count: T.bitWidth / 2 - 1))
    }

    func testDecodingRadix08() {
        ANKAssertDecodeText(T.min, 8, "-4" + String(repeating: "0", count: 63))
        ANKAssertDecodeText(T.max, 8,  "3" + String(repeating: "7", count: 63))
    }
    
    func testDecodingRadix10() {
        ANKAssertDecodeText(T.min, 10, "-3138550867693340381917894711603833208051177722232017256448")
        ANKAssertDecodeText(T.max, 10,  "3138550867693340381917894711603833208051177722232017256447")
    }
    
    func testDecodingRadix16() {
        ANKAssertDecodeText(T.min, 16, "-8" + String(repeating: "0", count: T.bitWidth / 4 - 1))
        ANKAssertDecodeText(T.max, 16,  "7" + String(repeating: "f", count: T.bitWidth / 4 - 1))
    }
    
    func testDecodingRadix32() {
        ANKAssertDecodeText(T.min, 32, "-2" + String(repeating: "0", count: 38))
        ANKAssertDecodeText(T.max, 32,  "1" + String(repeating: "v", count: 38))
    }
    
    func testDecodingRadix36() {
        ANKAssertDecodeText(T.min, 36, "-ti1ia748rltwhw44z5hik9fpnjcgcvuf8do8w")
        ANKAssertDecodeText(T.max, 36,  "ti1ia748rltwhw44z5hik9fpnjcgcvuf8do8v")
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
        let zero = String(repeating: "0", count: T.bitWidth) + "0"
        let one  = String(repeating: "0", count: T.bitWidth) + "1"
        
        for radix in 2 ... 36 {
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
        let positive = "+" + String(repeating: "1", count: T.bitWidth)
        let negative = "-" + String(repeating: "1", count: T.bitWidth)
        
        for radix in 2 ... 36 {
            ANKAssertDecodeText(T?.none, radix, positive)
            ANKAssertDecodeText(T?.none, radix, negative)
        }
        
        ANKAssertDecodeText(T?.none, 36, "-36ukv65j19b11mbvjyfui963v4my01krth19g3r3bk1ojlrwu9" ) // - 01
        ANKAssertDecodeText(T?.none, 36, "-36ukv65j19b11mbvjyfui963v4my01krth19g3r3bk1ojlrwu80") // * 36
        ANKAssertDecodeText(T?.none, 36,  "36ukv65j19b11mbvjyfui963v4my01krth19g3r3bk1ojlrwu8" ) // + 01
        ANKAssertDecodeText(T?.none, 36,  "36ukv65j19b11mbvjyfui963v4my01krth19g3r3bk1ojlrwu70") // * 36
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Encode
    //=------------------------------------------------------------------------=
    
    func testEncodingRadix02() {
        ANKAssertEncodeText(T.min, 2, false, "-1" + String(repeating: "0", count: T.bitWidth / 1 - 1))
        ANKAssertEncodeText(T.max, 2, false,        String(repeating: "1", count: T.bitWidth / 1 - 1))
    }
    
    func testEncodingRadix03() {
        ANKAssertEncodeText(T.min, 3, false,
        /*-----------------------*/ "-120201102001101000002" +
        "22102210012020102021201210011100212110221222012012" +
        "00011102210020110020202220120111200122011002002212" )
        ANKAssertEncodeText(T.max, 3, false,
        /*------------------------*/ "120201102001101000002" +
        "22102210012020102021201210011100212110221222012012" +
        "00011102210020110020202220120111200122011002002211" )
    }
    
    func testEncodingRadix04() {
        ANKAssertEncodeText(T.min, 4, false, "-2" + String(repeating: "0", count: T.bitWidth / 2 - 1))
        ANKAssertEncodeText(T.max, 4, false,  "1" + String(repeating: "3", count: T.bitWidth / 2 - 1))
    }
    
    func testEncodingRadix08() {
        ANKAssertEncodeText(T.min, 8, false, "-4" + String(repeating: "0", count: 63))
        ANKAssertEncodeText(T.max, 8, false,  "3" + String(repeating: "7", count: 63))
    }
    
    func testEncodingRadix10() {
        ANKAssertEncodeText(T.min, 10, false, "-3138550867693340381917894711603833208051177722232017256448")
        ANKAssertEncodeText(T.max, 10, false,  "3138550867693340381917894711603833208051177722232017256447")
    }
    
    func testEncodingRadix16() {
        ANKAssertEncodeText(T.min, 16, false, "-8" + String(repeating: "0", count: T.bitWidth / 4 - 1))
        ANKAssertEncodeText(T.min, 16, true , "-8" + String(repeating: "0", count: T.bitWidth / 4 - 1))
        ANKAssertEncodeText(T.max, 16, false,  "7" + String(repeating: "f", count: T.bitWidth / 4 - 1))
        ANKAssertEncodeText(T.max, 16, true ,  "7" + String(repeating: "F", count: T.bitWidth / 4 - 1))
    }

    func testEncodingRadix32() {
        ANKAssertEncodeText(T.min, 32, false, "-2" + String(repeating: "0", count: 38))
        ANKAssertEncodeText(T.min, 32, true , "-2" + String(repeating: "0", count: 38))
        ANKAssertEncodeText(T.max, 32, false,  "1" + String(repeating: "v", count: 38))
        ANKAssertEncodeText(T.max, 32, true ,  "1" + String(repeating: "V", count: 38))
    }
    
    func testEncodingRadix36() {
        ANKAssertEncodeText(T.min, 36, false, "-ti1ia748rltwhw44z5hik9fpnjcgcvuf8do8w")
        ANKAssertEncodeText(T.min, 36, true , "-TI1IA748RLTWHW44Z5HIK9FPNJCGCVUF8DO8W")
        ANKAssertEncodeText(T.max, 36, false,  "ti1ia748rltwhw44z5hik9fpnjcgcvuf8do8v")
        ANKAssertEncodeText(T.max, 36, true ,  "TI1IA748RLTWHW44Z5HIK9FPNJCGCVUF8DO8V")
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Text
//*============================================================================*

final class UInt192TestsOnText: XCTestCase {
    
    typealias T  = UInt192
    typealias T2 = ANKFullWidth<T, T.Magnitude>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInitDescription() {
        XCTAssertEqual(T(   "10"),  10)
        XCTAssertEqual(T(  "+10"),  10)
        XCTAssertEqual(T(  "-10"), nil)
        XCTAssertEqual(T(  " 10"), nil)
        
        XCTAssertEqual(T( "0x10"), nil)
        XCTAssertEqual(T("+0x10"), nil)
        XCTAssertEqual(T("-0x10"), nil)
        XCTAssertEqual(T(" 0x10"), nil)
    }
    
    func testInstanceDescriptionUsesRadix10() {
        XCTAssertEqual("10", T(10).description)
        XCTAssertEqual("10", String(describing: T(10)))
    }
    
    func testMetaTypeDescriptionIsSimple() {
        XCTAssertEqual("UInt192", T .description)
        XCTAssertEqual("UInt384", T2.description)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Decode
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix02() {
        ANKAssertDecodeText(T.min, 2, "0")
        ANKAssertDecodeText(T.max, 2, String(repeating: "1", count: T.bitWidth / 1))
    }
    
    func testDecodingRadix03() {
        ANKAssertDecodeText(T.min, 3, "0" )
        ANKAssertDecodeText(T.max, 3,
        /*-----------------------*/ "1011102211002202000012" +
        "21212120101110211120110120022201201221220221101101" +
        "00022212120110220111112211011000101021022011012200" )
    }
    
    func testDecodingRadix04() {
        ANKAssertDecodeText(T.min, 4, "0")
        ANKAssertDecodeText(T.max, 4, String(repeating: "3", count: T.bitWidth / 2))
    }
    
    func testDecodingRadix08() {
        ANKAssertDecodeText(T.min, 8, "0")
        ANKAssertDecodeText(T.max, 8, String(repeating: "7", count: 64))
    }
    
    func testDecodingRadix10() {
        ANKAssertDecodeText(T.min, 10, "0")
        ANKAssertDecodeText(T.max, 10, "6277101735386680763835789423207666416102355444464034512895")
    }
    
    func testDecodingRadix16() {
        ANKAssertDecodeText(T.min, 16, "0")
        ANKAssertDecodeText(T.max, 16, String(repeating: "f", count: T.bitWidth / 4))
    }
    
    func testDecodingRadix32() {
        ANKAssertDecodeText(T.min, 32, "0")
        ANKAssertDecodeText(T.max, 32, "3" + String(repeating: "v", count: 38))
    }
    
    func testDecodingRadix36() {
        ANKAssertDecodeText(T.min, 36, "0")
        ANKAssertDecodeText(T.max, 36, "1n030ke8hj7nszs89yaz14ivfb2owprougrchr")
    }
    
    func testDecodingRadixLiteralAsNumber() {
        ANKAssertDecodeText(T(33), 36,  "0x")
        ANKAssertDecodeText(T(24), 36,  "0o")
        ANKAssertDecodeText(T(11), 36,  "0b")
        
        ANKAssertDecodeText(T(33), 36, "+0x")
        ANKAssertDecodeText(T(24), 36, "+0o")
        ANKAssertDecodeText(T(11), 36, "+0b")
    }
    
    func testDecodingRadixLiteralAsRadixReturnsNil() {
        ANKAssertDecodeText(T?.none, 10,  "0x10")
        ANKAssertDecodeText(T?.none, 10,  "0o10")
        ANKAssertDecodeText(T?.none, 10,  "0b10")
        
        ANKAssertDecodeText(T?.none, 10, "+0x10")
        ANKAssertDecodeText(T?.none, 10, "+0o10")
        ANKAssertDecodeText(T?.none, 10, "+0b10")
    }
    
    func testDecodingStringsWithAndWithoutSign() {
        ANKAssertDecodeText(T(1234567890), 10,  "1234567890")
        ANKAssertDecodeText(T(1234567890), 10, "+1234567890")
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
        let zero = String(repeating: "0", count: T.bitWidth) + "0"
        let one  = String(repeating: "0", count: T.bitWidth) + "1"
        
        for radix in 2 ... 36 {
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
        let positive = "+" + String(repeating: "1", count: T.bitWidth + 1)
        let negative = "-" + String(repeating: "1", count: 1)
        
        for radix in 2 ... 36 {
            ANKAssertDecodeText(T?.none, radix, positive)
            ANKAssertDecodeText(T?.none, radix, negative)
        }
        
        ANKAssertDecodeText(T?.none, 36, "6dp5qcb22im238nr3wvp0ic7q99w035jmy2iw7i6n43d37jtog" ) // + 01
        ANKAssertDecodeText(T?.none, 36, "6dp5qcb22im238nr3wvp0ic7q99w035jmy2iw7i6n43d37jtof0") // * 36
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Encode
    //=------------------------------------------------------------------------=
    
    func testEncodingRadix02() {
        ANKAssertEncodeText(T.min, 2, false, "0")
        ANKAssertEncodeText(T.max, 2, false, String(repeating: "1", count: T.bitWidth / 1))
    }
    
    func testEncodingRadix03() {
        ANKAssertEncodeText(T.min, 3, false, "0" )
        ANKAssertEncodeText(T.max, 3, false,
        /*-----------------------*/ "1011102211002202000012" +
        "21212120101110211120110120022201201221220221101101" +
        "00022212120110220111112211011000101021022011012200" )
    }
    
    func testEncodingRadix04() {
        ANKAssertEncodeText(T.min, 4, false, "0")
        ANKAssertEncodeText(T.max, 4, false, String(repeating: "3", count: T.bitWidth / 2))
    }
    
    func testEncodingRadix08() {
        ANKAssertEncodeText(T.min, 8, false, "0")
        ANKAssertEncodeText(T.max, 8, false, String(repeating: "7", count: 64))
    }
    
    func testEncodingRadix10() {
        ANKAssertEncodeText(T.min, 10, false, "0")
        ANKAssertEncodeText(T.max, 10, false, "6277101735386680763835789423207666416102355444464034512895")
    }
    
    func testEncodingRadix16() {
        ANKAssertEncodeText(T.min, 16, false, "0")
        ANKAssertEncodeText(T.min, 16, true , "0")
        ANKAssertEncodeText(T.max, 16, false, String(repeating: "f", count: T.bitWidth / 4))
        ANKAssertEncodeText(T.max, 16, true , String(repeating: "F", count: T.bitWidth / 4))
    }
    
    func testEncodingRadix32() {
        ANKAssertEncodeText(T.min, 32, false, "0")
        ANKAssertEncodeText(T.min, 32, true , "0")
        ANKAssertEncodeText(T.max, 32, false, "3" + String(repeating: "v", count: 38))
        ANKAssertEncodeText(T.max, 32, true , "3" + String(repeating: "V", count: 38))
    }
    
    func testEncodingRadix36() {
        ANKAssertEncodeText(T.min, 36, false, "0")
        ANKAssertEncodeText(T.min, 36, true , "0")
        ANKAssertEncodeText(T.max, 36, false, "1n030ke8hj7nszs89yaz14ivfb2owprougrchr")
        ANKAssertEncodeText(T.max, 36, true , "1N030KE8HJ7NSZS89YAZ14IVFB2OWPROUGRCHR")
    }
}

#endif
