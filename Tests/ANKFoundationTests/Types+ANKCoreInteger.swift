//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKFoundation
import XCTest

//*============================================================================*
// MARK: * Types x ANKCoreInteger
//*============================================================================*

final class TypesTestsOnANKCoreInteger: XCTestCase {
    
    typealias T = any ANKCoreInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = Types.ANKCoreInteger
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testTypesCount() {
        XCTAssertEqual(types.count, 10)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit Pattern
    //=------------------------------------------------------------------------=
    
    func testInitBitPattern() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            XCTAssertEqual(T(bitPattern: T.Magnitude.min), T( 0))
            XCTAssertEqual(T(bitPattern: T.Magnitude.max), T(-1))
            
            XCTAssertEqual(T(bitPattern:  (T.Magnitude(1) << (T.bitWidth - 1))), T.min)
            XCTAssertEqual(T(bitPattern: ~(T.Magnitude(1) << (T.bitWidth - 1))), T.max)
        }
        
        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            XCTAssertEqual(T(bitPattern: T.Magnitude.min), T.min)
            XCTAssertEqual(T(bitPattern: T.Magnitude.max), T.max)
        }
        
        for type: T in types {
            type.isSigned ? whereIsSigned(type) : whereIsUnsigned(type)
        }
    }
    
    func testValueAsBitPattern() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            XCTAssertEqual(T( 0).bitPattern, T.Magnitude.min)
            XCTAssertEqual(T(-1).bitPattern, T.Magnitude.max)
            
            XCTAssertEqual(T.min.bitPattern,  (T.Magnitude(1) << (T.bitWidth - 1)))
            XCTAssertEqual(T.max.bitPattern, ~(T.Magnitude(1) << (T.bitWidth - 1)))
        }
        
        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            XCTAssertEqual(T.min.bitPattern, T.Magnitude.min)
            XCTAssertEqual(T.max.bitPattern, T.Magnitude.max)
        }
        
        for type: T in types {
            type.isSigned ? whereIsSigned(type) : whereIsUnsigned(type)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bytes
    //=------------------------------------------------------------------------=
    
    func testWithUnsafeBytes() {
        for type: T in types {
            let x0 = type.init(truncatingIfNeeded:  0)
            let x1 = type.init(truncatingIfNeeded: -1)
            
            x0.withUnsafeBytes { BYTES in
                XCTAssertEqual(BYTES.count, type.bitWidth/8)
                XCTAssert(BYTES.allSatisfy({  $0 == 0x00 }))
            }
            
            x1.withUnsafeBytes { BYTES in
                XCTAssertEqual(BYTES.count, type.bitWidth/8)
                XCTAssert(BYTES.allSatisfy({  $0 == 0xff }))
            }
        }
    }
    
    func testWithUnsafeMutableBytes() {
        for type: T in types {
            var x0 = type.init(truncatingIfNeeded:  0)
            let x1 = type.init(truncatingIfNeeded: -1)
            
            x0.withUnsafeMutableBytes { BYTES in
                XCTAssertEqual(BYTES.count, type.bitWidth/8)
                XCTAssert(BYTES.allSatisfy({  $0 == 0x00 }))
                BYTES.indices.forEach({ BYTES[$0] = 0xff })
                XCTAssert(BYTES.allSatisfy({  $0 == 0xff }))
            }
            
            XCTAssertEqual(x0.words.map({ $0 as! UInt }), x1.words.map({ $0 as! UInt }))
        }
    }
    
    func testFromUnsafeMutableBytes() {
        for type: T in types {
            let x0 = type.init(truncatingIfNeeded:  0)
            let x1 = type.init(truncatingIfNeeded: -1)
            
            let y0 = type.fromUnsafeMutableBytes { BYTES in
                XCTAssertEqual(BYTES.count, type.bitWidth/8)
                BYTES.indices.forEach({ BYTES[$0] = 0x00 })
                XCTAssert(BYTES.allSatisfy({  $0 == 0x00 }))
            }
            
            let y1 = type.fromUnsafeMutableBytes { BYTES in
                XCTAssertEqual(BYTES.count, type.bitWidth/8)
                BYTES.indices.forEach({ BYTES[$0] = 0xff })
                XCTAssert(BYTES.allSatisfy({  $0 == 0xff }))
            }
            
            XCTAssertEqual(x0.words.map({ $0 as! UInt }), y0.words.map({ $0 as! UInt }))
            XCTAssertEqual(x1.words.map({ $0 as! UInt }), y1.words.map({ $0 as! UInt }))
        }
    }
}

#endif
