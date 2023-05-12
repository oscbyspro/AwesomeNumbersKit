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
// MARK: * Int256 x Pointers
//*============================================================================*

final class Int256TestsOnPointers: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Words
    //=------------------------------------------------------------------------=
    
    func testWithUnsafeWords() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
        
        x0.withUnsafeWords { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.min }))
        }
        
        x1.withUnsafeWords { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.max }))
        }
    }
    
    func testWithUnsafeMutableWords() {
        var x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
                
        x0.withUnsafeMutableWords { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.min }))
            WORDS.indices.forEach({ WORDS[$0] = UInt.max })
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.max }))
        };  XCTAssertEqual(x0, x1)
    }
    
    func testFromUnsafeMutableWords() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
                
        let y0 = T.fromUnsafeMutableWords { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            WORDS.indices.forEach({ WORDS[$0] = UInt.min })
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.min }))
        };  XCTAssertEqual(x0, y0)
        
        let y1 = T.fromUnsafeMutableWords { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            WORDS.indices.forEach({ WORDS[$0] = UInt.max })
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.max }))
        };  XCTAssertEqual(x1, y1)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Words x Contiguous UInt Sequence
    //=------------------------------------------------------------------------=
    
    func testWithContiguousStorageIfAvailable() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
        
        let s0: Void? = x0.withContiguousStorageIfAvailable { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.min }))
        };  XCTAssertNotNil(s0)
        
        let s1: Void? = x1.withContiguousStorageIfAvailable { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.max }))
        };  XCTAssertNotNil(s1)
    }
    
    func testWithContiguousMutableStorageIfAvailable() {
        var x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
                
        x0.withContiguousMutableStorageIfAvailable { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.min }))
            WORDS.indices.forEach({ WORDS[$0] = UInt.max })
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.max }))
        };  XCTAssertEqual(x0, x1)
    }
}

//*============================================================================*
// MARK: * UInt256 x Pointers
//*============================================================================*

final class UInt256TestsOnPointers: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Words
    //=------------------------------------------------------------------------=
    
    func testWithUnsafeWords() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
        
        x0.withUnsafeWords { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.min }))
        }
        
        x1.withUnsafeWords { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.max }))
        }
    }
    
    func testWithUnsafeMutableWords() {
        var x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
                
        x0.withUnsafeMutableWords { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.min }))
            WORDS.indices.forEach({ WORDS[$0] = UInt.max })
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.max }))
        };  XCTAssertEqual(x0, x1)
    }
    
    func testFromUnsafeMutableWords() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
                
        let y0 = T.fromUnsafeMutableWords { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            WORDS.indices.forEach({ WORDS[$0] = UInt.min })
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.min }))
        };  XCTAssertEqual(x0, y0)
        
        let y1 = T.fromUnsafeMutableWords { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            WORDS.indices.forEach({ WORDS[$0] = UInt.max })
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.max }))
        };  XCTAssertEqual(x1, y1)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Words x Contiguous UInt Sequence
    //=------------------------------------------------------------------------=
    
    func testWithContiguousStorageIfAvailable() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
        
        let s0: Void? = x0.withContiguousStorageIfAvailable { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.min }))
        };  XCTAssertNotNil(s0)
        
        let s1: Void? = x1.withContiguousStorageIfAvailable { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.max }))
        };  XCTAssertNotNil(s1)
    }
    
    func testWithContiguousMutableStorageIfAvailable() {
        var x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
                
        x0.withContiguousMutableStorageIfAvailable { WORDS in
            XCTAssertEqual(WORDS.count, T.count)
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.min }))
            WORDS.indices.forEach({ WORDS[$0] = UInt.max })
            XCTAssert(WORDS.allSatisfy({  $0 == UInt.max }))
        };  XCTAssertEqual(x0, x1)
    }
}

#endif
