//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

@testable import ANKFullWidthKit
import XCTest

//*============================================================================*
// MARK: * Int192 x Words
//*============================================================================*

final class Int192TestsOnWords: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
        
    let a = UInt  .max
    let b = UInt64.max
    let c = UInt32.max
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBitWidth() {
        XCTAssertEqual(T(x64:(0, 0, 0)).bitWidth, 64 * 3)
        XCTAssertEqual(T(x64:(b, b, b)).bitWidth, 64 * 3)
    }
    
    func testNonzeroBitCount() {
        XCTAssertEqual(T(x64:(0, 0, 0)).nonzeroBitCount, 0)
        XCTAssertEqual(T(x64:(1, 1, 1)).nonzeroBitCount, 3)
    }
    
    func testLeadingZeroBitCount() {
        XCTAssertEqual(T(x64:(0, 0, 0)).leadingZeroBitCount,  64 * 3)
        XCTAssertEqual(T(x64:(b, b, b)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64:(2, 0, 0)).leadingZeroBitCount,  64 * 3 - 2)
        XCTAssertEqual(T(x64:(0, 2, 0)).leadingZeroBitCount,  64 * 2 - 2)
        XCTAssertEqual(T(x64:(0, 0, 2)).leadingZeroBitCount,  64 * 1 - 2)
    }
    
    func testTrailingZeroBitCount() {
        XCTAssertEqual(T(x64:(0, 0, 0)).leadingZeroBitCount,  64 * 3)
        XCTAssertEqual(T(x64:(b, b, b)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64:(2, 0, 0)).trailingZeroBitCount, 64 * 0 + 1)
        XCTAssertEqual(T(x64:(0, 2, 0)).trailingZeroBitCount, 64 * 1 + 1)
        XCTAssertEqual(T(x64:(0, 0, 2)).trailingZeroBitCount, 64 * 2 + 1)
    }
    
    func testMostSignificantBit() {
        XCTAssertEqual(T(x64:(0, 0, 0)).mostSignificantBit, false)
        XCTAssertEqual(T(x64:(b, b, b)).mostSignificantBit, true )

        XCTAssertEqual(T(x64:(b, 0, 0)).mostSignificantBit, false)
        XCTAssertEqual(T(x64:(0, b, 0)).mostSignificantBit, false)
        XCTAssertEqual(T(x64:(0, 0, b)).mostSignificantBit, true )
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual(T(x64:(0, 0, 0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:(b, b, b)).leastSignificantBit, true )

        XCTAssertEqual(T(x64:(b, 0, 0)).leastSignificantBit, true )
        XCTAssertEqual(T(x64:(0, b, 0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:(0, 0, b)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:(0, 0, 0)).leastSignificantBit, false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Collection
    //=------------------------------------------------------------------------=
    
    func testWordsX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        XCTAssertEqual(T(x64:(0, 0, 0)).words.map({ $0 }), [0, 0, 0])
        XCTAssertEqual(T(x64:(1, 0, 0)).words.map({ $0 }), [1, 0, 0])
        XCTAssertEqual(T(x64:(1, 2, 0)).words.map({ $0 }), [1, 2, 0])
        XCTAssertEqual(T(x64:(1, 2, 3)).words.map({ $0 }), [1, 2, 3])
    }
    
    func testWordsX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        XCTAssertEqual(T(x32:(0, 0, 0, 0, 0, 0)).words.map({ $0 }), [0, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 0, 0, 0, 0, 0)).words.map({ $0 }), [1, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 0, 0, 0, 0)).words.map({ $0 }), [1, 2, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 0, 0, 0)).words.map({ $0 }), [1, 2, 3, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 0, 0)).words.map({ $0 }), [1, 2, 3, 4, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 5, 0)).words.map({ $0 }), [1, 2, 3, 4, 5, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 5, 6)).words.map({ $0 }), [1, 2, 3, 4, 5, 6])
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Minimum Two's Complement Form
    //=------------------------------------------------------------------------=
    
    func testMinWordCountReportingIsZeroOrMinusOneX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        XCTAssert(T(x64:(0, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(T(x64:(1, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(T(x64:(0, 1, 0)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(T(x64:(0, 0, 1)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        
        XCTAssert(T(x64:(b, b, b)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(T(x64:(1, b, b)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(T(x64:(b, 1, b)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(T(x64:(b, b, 1)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
    }
    
    func testMinWordCountReportingIsZeroOrMinusOneX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        XCTAssert(T(x32:(0, 0, 0, 0, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(T(x32:(1, 0, 0, 0, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(T(x32:(0, 1, 0, 0, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(T(x32:(0, 0, 1, 0, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(T(x32:(0, 0, 0, 1, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x32:(0, 0, 0, 0, 1, 0)).minWordCountReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert(T(x32:(0, 0, 0, 0, 0, 1)).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        
        XCTAssert(T(x32:(c, c, c, c, c, c)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(T(x32:(1, c, c, c, c, c)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(T(x32:(c, 1, c, c, c, c)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(T(x32:(c, c, 1, c, c, c)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(T(x32:(c, c, c, 1, c, c)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x32:(c, c, c, 1, 1, c)).minWordCountReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert(T(x32:(c, c, c, c, c, 1)).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
    }
}

//*============================================================================*
// MARK: * UInt192 x Words
//*============================================================================*

final class UInt192TestsOnWords: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
        
    let a = UInt  .max
    let b = UInt64.max
    let c = UInt32.max
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBitWidth() {
        XCTAssertEqual(T(x64:(0, 0, 0)).bitWidth, 64 * 3)
        XCTAssertEqual(T(x64:(b, b, b)).bitWidth, 64 * 3)
    }
    
    func testNonzeroBitCount() {
        XCTAssertEqual(T(x64:(0, 0, 0)).nonzeroBitCount, 0)
        XCTAssertEqual(T(x64:(1, 1, 1)).nonzeroBitCount, 3)
    }
    
    func testLeadingZeroBitCount() {
        XCTAssertEqual(T(x64:(0, 0, 0)).leadingZeroBitCount,  64 * 3)
        XCTAssertEqual(T(x64:(b, b, b)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64:(2, 0, 0)).leadingZeroBitCount,  64 * 3 - 2)
        XCTAssertEqual(T(x64:(0, 2, 0)).leadingZeroBitCount,  64 * 2 - 2)
        XCTAssertEqual(T(x64:(0, 0, 2)).leadingZeroBitCount,  64 * 1 - 2)
    }
    
    func testTrailingZeroBitCount() {
        XCTAssertEqual(T(x64:(0, 0, 0)).leadingZeroBitCount,  64 * 3)
        XCTAssertEqual(T(x64:(b, b, b)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64:(2, 0, 0)).trailingZeroBitCount, 64 * 0 + 1)
        XCTAssertEqual(T(x64:(0, 2, 0)).trailingZeroBitCount, 64 * 1 + 1)
        XCTAssertEqual(T(x64:(0, 0, 2)).trailingZeroBitCount, 64 * 2 + 1)
    }
    
    func testMostSignificantBit() {
        XCTAssertEqual(T(x64:(0, 0, 0)).mostSignificantBit, false)
        XCTAssertEqual(T(x64:(b, b, b)).mostSignificantBit, true )

        XCTAssertEqual(T(x64:(b, 0, 0)).mostSignificantBit, false)
        XCTAssertEqual(T(x64:(0, b, 0)).mostSignificantBit, false)
        XCTAssertEqual(T(x64:(0, 0, b)).mostSignificantBit, true )
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual(T(x64:(0, 0, 0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:(b, b, b)).leastSignificantBit, true )
        
        XCTAssertEqual(T(x64:(b, 0, 0)).leastSignificantBit, true )
        XCTAssertEqual(T(x64:(0, b, 0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:(0, 0, b)).leastSignificantBit, false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Collection
    //=------------------------------------------------------------------------=
    
    func testWordsX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        XCTAssertEqual(T(x64:(0, 0, 0)).words.map({ $0 }), [0, 0, 0])
        XCTAssertEqual(T(x64:(1, 0, 0)).words.map({ $0 }), [1, 0, 0])
        XCTAssertEqual(T(x64:(1, 2, 0)).words.map({ $0 }), [1, 2, 0])
        XCTAssertEqual(T(x64:(1, 2, 3)).words.map({ $0 }), [1, 2, 3])
    }
    
    func testWordsX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        XCTAssertEqual(T(x32:(0, 0, 0, 0, 0, 0)).words.map({ $0 }), [0, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 0, 0, 0, 0, 0)).words.map({ $0 }), [1, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 0, 0, 0, 0)).words.map({ $0 }), [1, 2, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 0, 0, 0)).words.map({ $0 }), [1, 2, 3, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 0, 0)).words.map({ $0 }), [1, 2, 3, 4, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 5, 0)).words.map({ $0 }), [1, 2, 3, 4, 5, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 5, 6)).words.map({ $0 }), [1, 2, 3, 4, 5, 6])
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Minimum Two's Complement Form
    //=------------------------------------------------------------------------=
    
    func testMinWordCountReportingIsZeroOrMinusOneX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        XCTAssert(T(x64:(0, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(T(x64:(1, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(T(x64:(0, 1, 0)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(T(x64:(0, 0, 1)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        
        XCTAssert(T(x64:(b, b, b)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(T(x64:(1, b, b)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(T(x64:(b, 1, b)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(T(x64:(b, b, 1)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
    }
    
    func testMinWordCountReportingIsZeroOrMinusOneX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        XCTAssert(T(x32:(0, 0, 0, 0, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(T(x32:(1, 0, 0, 0, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(T(x32:(0, 1, 0, 0, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(T(x32:(0, 0, 1, 0, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(T(x32:(0, 0, 0, 1, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x32:(0, 0, 0, 0, 1, 0)).minWordCountReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert(T(x32:(0, 0, 0, 0, 0, 1)).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        
        XCTAssert(T(x32:(c, c, c, c, c, c)).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert(T(x32:(1, c, c, c, c, c)).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert(T(x32:(c, 1, c, c, c, c)).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert(T(x32:(c, c, 1, c, c, c)).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert(T(x32:(c, c, c, 1, c, c)).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert(T(x32:(c, c, c, 1, 1, c)).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert(T(x32:(c, c, c, c, c, 1)).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
    }
}

#endif
