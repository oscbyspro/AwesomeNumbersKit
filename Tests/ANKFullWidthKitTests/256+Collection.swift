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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Collection
//*============================================================================*

final class Int256TestsOnCollection: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bytes
    //=------------------------------------------------------------------------=

    func testWithUnsafeBytes() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
        
        x0.withUnsafeBytes { BYTES in
            XCTAssertEqual(BYTES.count, T.bitWidth/8)
            XCTAssert(BYTES.allSatisfy({  $0 == 0x00 }))
        }
        
        x1.withUnsafeBytes { BYTES in
            XCTAssertEqual(BYTES.count, T.bitWidth/8)
            XCTAssert(BYTES.allSatisfy({  $0 == 0xff }))
        }
    }
    
    func testWithUnsafeMutableBytes() {
        var x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
        
        x0.withUnsafeMutableBytes { BYTES in
            XCTAssertEqual(BYTES.count, T.bitWidth/8)
            XCTAssert(BYTES.allSatisfy({  $0  == 0x00 }))
            BYTES.indices.forEach({ BYTES[$0]  = 0xff })
            XCTAssert(BYTES.allSatisfy({  $0  == 0xff }))
        };  XCTAssertEqual(x0, x1)
    }
    
    func testFromUnsafeMutableBytes() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
                
        let y0 = T.fromUnsafeMutableBytes { BYTES in
            XCTAssertEqual(BYTES.count, T.bitWidth/8)
            BYTES.indices.forEach({ BYTES[$0]  = 0x00 })
            XCTAssert(BYTES.allSatisfy({  $0  == 0x00 }))
        };  XCTAssertEqual(x0, y0)
        
        let y1 = T.fromUnsafeMutableBytes { BYTES in
            XCTAssertEqual(BYTES.count, T.bitWidth/8)
            BYTES.indices.forEach({ BYTES[$0]  = 0xff })
            XCTAssert(BYTES.allSatisfy({  $0  == 0xff }))
        };  XCTAssertEqual(x1, y1)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Words
    //=------------------------------------------------------------------------=
    
    func testWithUnsafeWordsPointer() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
        
        x0.withUnsafeWordsPointer { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.min }))
        }
        
        x1.withUnsafeWordsPointer { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.max }))
        }
    }
    
    func testWithUnsafeMutableWordsPointer() {
        var x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
                
        x0.withUnsafeMutableWordsPointer { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0  == UInt.min }))
            WORDS.indices.forEach({ WORDS[$0]  = UInt.max })
            XCTAssert(WORDS.allSatisfy({  $0  == UInt.max }))
        };  XCTAssertEqual(x0, x1)
    }
    
    func testFromUnsafeMutableWordsAllocation() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
                
        let y0 = T.fromUnsafeMutableWordsAllocation { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            WORDS.indices.forEach({ WORDS[$0] = UInt.min })
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.min }))
        };  XCTAssertEqual(x0, y0)
        
        let y1 = T.fromUnsafeMutableWordsAllocation { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            WORDS.indices.forEach({ WORDS[$0] = UInt.max })
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.max }))
        };  XCTAssertEqual(x1, y1)
    }
}

//*============================================================================*
// MARK: * UInt256 x Collection
//*============================================================================*

final class UInt256TestsOnCollection: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bytes
    //=------------------------------------------------------------------------=

    func testWithUnsafeBytes() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
        
        x0.withUnsafeBytes { BYTES in
            XCTAssertEqual(BYTES.count, T.bitWidth/8)
            XCTAssert(BYTES.allSatisfy({  $0 == 0x00 }))
        }
        
        x1.withUnsafeBytes { BYTES in
            XCTAssertEqual(BYTES.count, T.bitWidth/8)
            XCTAssert(BYTES.allSatisfy({  $0 == 0xff }))
        }
    }
        
    func testWithUnsafeMutableBytes() {
        var x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
                
        x0.withUnsafeMutableBytes { BYTES in
            XCTAssertEqual(BYTES.count, T.bitWidth/8)
            XCTAssert(BYTES.allSatisfy({  $0  == 0x00 }))
            BYTES.indices.forEach({ BYTES[$0]  = 0xff })
            XCTAssert(BYTES.allSatisfy({  $0  == 0xff }))
        };  XCTAssertEqual(x0, x1)
    }
    
    func testFromUnsafeMutableBytes() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
                
        let y0 = T.fromUnsafeMutableBytes { BYTES in
            XCTAssertEqual(BYTES.count, T.bitWidth/8)
            BYTES.indices.forEach({ BYTES[$0]  = 0x00 })
            XCTAssert(BYTES.allSatisfy({  $0  == 0x00 }))
        };  XCTAssertEqual(x0, y0)
        
        let y1 = T.fromUnsafeMutableBytes { BYTES in
            XCTAssertEqual(BYTES.count, T.bitWidth/8)
            BYTES.indices.forEach({ BYTES[$0]  = 0xff })
            XCTAssert(BYTES.allSatisfy({  $0  == 0xff }))
        };  XCTAssertEqual(x1, y1)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Words
    //=------------------------------------------------------------------------=
    
    func testWithUnsafeWordsPointer() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
        
        x0.withUnsafeWordsPointer { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.min }))
        }
        
        x1.withUnsafeWordsPointer { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.max }))
        }
    }
    
    func testWithUnsafeMutableWordsPointer() {
        var x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
                
        x0.withUnsafeMutableWordsPointer { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0  == UInt.min }))
            WORDS.indices.forEach({ WORDS[$0]  = UInt.max })
            XCTAssert(WORDS.allSatisfy({  $0  == UInt.max }))
        };  XCTAssertEqual(x0, x1)
    }
    
    func testFromUnsafeMutableWordsAllocation() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
                
        let y0 = T.fromUnsafeMutableWordsAllocation { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            WORDS.indices.forEach({ WORDS[$0] = UInt.min })
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.min }))
        };  XCTAssertEqual(x0, y0)
        
        let y1 = T.fromUnsafeMutableWordsAllocation { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            WORDS.indices.forEach({ WORDS[$0] = UInt.max })
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.max }))
        };  XCTAssertEqual(x1, y1)
    }
}

#endif
