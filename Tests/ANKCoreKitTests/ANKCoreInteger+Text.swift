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
import XCTest

//*============================================================================*
// MARK: * ANK x Core Integer x Text
//*============================================================================*

final class ANKCoreIntegerTestsOnText: XCTestCase {
    
    typealias T = any ANKCoreInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = ANKCoreIntegerTests.types
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Decode
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix10() {
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertDecodeText(T( 123), 10,  "123")
            ANKAssertDecodeText(T( 123), 10, "+123")
            
            guard type.isSigned else { return }
            
            ANKAssertDecodeText(T(-123), 10, "-123")
        }
        
        for type: T in types {
            whereIs(type)
        }
    }
    
    func testDecodingRadix16() {
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertDecodeText(T( 123), 16,  "7b")
            ANKAssertDecodeText(T( 123), 16, "+7b")
            
            guard type.isSigned else { return }
            
            ANKAssertDecodeText(T(-123), 16, "-7b")
        }
        
        for type: T in types {
            whereIs(type)
        }
    }
    
    func testDecodingRadixLiteralAsNumber() {
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertDecodeText(T( 33), 36,  "0x")
            ANKAssertDecodeText(T( 24), 36,  "0o")
            ANKAssertDecodeText(T( 11), 36,  "0b")
            
            ANKAssertDecodeText(T( 33), 36, "+0x")
            ANKAssertDecodeText(T( 24), 36, "+0o")
            ANKAssertDecodeText(T( 11), 36, "+0b")
            
            guard type.isSigned else { return }
            
            ANKAssertDecodeText(T(-33), 36, "-0x")
            ANKAssertDecodeText(T(-24), 36, "-0o")
            ANKAssertDecodeText(T(-11), 36, "-0b")
        }
        
        for type: T in types {
            whereIs(type)
        }
    }
    
    func testDecodingRadixLiteralAsRadixReturnsNil() {
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertDecodeText(T?.none, 10,  "0x10")
            ANKAssertDecodeText(T?.none, 10,  "0o10")
            ANKAssertDecodeText(T?.none, 10,  "0b10")
            
            ANKAssertDecodeText(T?.none, 10, "+0x10")
            ANKAssertDecodeText(T?.none, 10, "+0o10")
            ANKAssertDecodeText(T?.none, 10, "+0b10")
            
            guard type.isSigned else { return }
            
            ANKAssertDecodeText(T?.none, 10, "-0x10")
            ANKAssertDecodeText(T?.none, 10, "-0o10")
            ANKAssertDecodeText(T?.none, 10, "-0b10")
        }
        
        for type: T in types {
            whereIs(type)
        }
    }
    
    func testDecodingStringsWithOrWithoutSign() {
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertDecodeText(T( 123), 10,  "123")
            ANKAssertDecodeText(T( 123), 10, "+123")
            
            guard type.isSigned else { return }
            
            ANKAssertDecodeText(T(-123), 10, "-123")
        }
        
        for type: T in types {
            whereIs(type)
        }
    }
    
    func testDecodingPrefixingZerosHasNoEffect() {
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertDecodeText(T(0), 10, String(repeating: "0", count: 99) + "0")
            ANKAssertDecodeText(T(1), 10, String(repeating: "0", count: 99) + "1")
        }
        
        for type: T in types {
            whereIs(type)
        }
    }
    
    func testDecodingStringsWithoutDigitsReturnsNil() {
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertDecodeText(T?.none, 10,  "")
            ANKAssertDecodeText(T?.none, 10, "+")
            ANKAssertDecodeText(T?.none, 10, "-")
            ANKAssertDecodeText(T?.none, 10, "~")
            
            ANKAssertDecodeText(T?.none, 16,  "")
            ANKAssertDecodeText(T?.none, 16, "+")
            ANKAssertDecodeText(T?.none, 16, "-")
            ANKAssertDecodeText(T?.none, 16, "~")
        }
        
        for type: T in types {
            whereIs(type)
        }
    }
    
    func testDecodingValueOutsideOfRepresentableRangeReturnsNil() {
        let positive = "+" + String(repeating: "1", count: 65)
        let negative = "-" + String(repeating: "1", count: 65)
        
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            for radix in 2 ... 36 {
                ANKAssertDecodeText(T?.none, radix, positive)
                ANKAssertDecodeText(T?.none, radix, negative)
            }
        }
        
        for type: T in types {
            whereIs(type)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Encode
    //=------------------------------------------------------------------------=
    
    func testEncodingRadix10() {
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            let max = T(123)
            let min = T(exactly: -123)
            
            ANKAssertEncodeText(max, 10, false,  "123")
            ANKAssertEncodeText(max, 10, true ,  "123")
            
            guard let min else { return }
            
            ANKAssertEncodeText(min, 10, false, "-123")
            ANKAssertEncodeText(min, 10, true , "-123")
        }
        
        for type: T in types {
            whereIs(type)
        }
    }
    
    func testEncodingRadix16() {
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            let max = T(123)
            let min = T(exactly: -123)
            
            ANKAssertEncodeText(max, 16, false,  "7b")
            ANKAssertEncodeText(max, 16, true ,  "7B")
            
            guard let min else { return }
            
            ANKAssertEncodeText(min, 16, false, "-7b")
            ANKAssertEncodeText(min, 16, true , "-7B")
        }
        
        for type: T in types {
            whereIs(type)
        }
    }
}

#endif
