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
// MARK: * Int256 x Words
//*============================================================================*

final class Int256TestsOnWords: XCTestCase {
    
    typealias T = ANKInt256
        
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBitWidth() {
        XCTAssertEqual(T(x64:( 0,  0,  0,  0)).bitWidth, 64 * 4)
        XCTAssertEqual(T(x64:(~0, ~0, ~0, ~0)).bitWidth, 64 * 4)
    }
    
    func testNonzeroBitCount() {
        XCTAssertEqual(T(x64:( 0,  0,  0,  0)).nonzeroBitCount, 0)
        XCTAssertEqual(T(x64:( 1,  1,  1,  1)).nonzeroBitCount, 4)
    }
    
    func testLeadingZeroBitCount() {
        XCTAssertEqual(T(x64:( 0,  0,  0,  0)).leadingZeroBitCount,  64 * 4)
        XCTAssertEqual(T(x64:(~0, ~0, ~0, ~0)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64:( 2,  0,  0,  0)).leadingZeroBitCount,  64 * 4 - 2)
        XCTAssertEqual(T(x64:( 0,  2,  0,  0)).leadingZeroBitCount,  64 * 3 - 2)
        XCTAssertEqual(T(x64:( 0,  0,  2,  0)).leadingZeroBitCount,  64 * 2 - 2)
        XCTAssertEqual(T(x64:( 0,  0,  0,  2)).leadingZeroBitCount,  64 * 1 - 2)
    }
    
    func testTrailingZeroBitCount() {
        XCTAssertEqual(T(x64:( 0,  0,  0,  0)).leadingZeroBitCount,  64 * 4)
        XCTAssertEqual(T(x64:(~0, ~0, ~0, ~0)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64:( 2,  0,  0,  0)).trailingZeroBitCount, 64 * 0 + 1)
        XCTAssertEqual(T(x64:( 0,  2,  0,  0)).trailingZeroBitCount, 64 * 1 + 1)
        XCTAssertEqual(T(x64:( 0,  0,  2,  0)).trailingZeroBitCount, 64 * 2 + 1)
        XCTAssertEqual(T(x64:( 0,  0,  0,  2)).trailingZeroBitCount, 64 * 3 + 1)
    }
    
    func testMostSignificantBit() {
        XCTAssertEqual(T(x64:( 0,  0,  0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64:(~0, ~0, ~0, ~0)).mostSignificantBit,  true )

        XCTAssertEqual(T(x64:(~0,  0,  0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64:( 0, ~0,  0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64:( 0,  0, ~0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64:( 0,  0,  0, ~0)).mostSignificantBit,  true )
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual(T(x64:( 0,  0,  0,  0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:(~0, ~0, ~0, ~0)).leastSignificantBit, true )

        XCTAssertEqual(T(x64:(~0,  0,  0,  0)).leastSignificantBit, true )
        XCTAssertEqual(T(x64:( 0, ~0,  0,  0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:( 0,  0, ~0,  0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:( 0,  0,  0, ~0)).leastSignificantBit, false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Collection
    //=------------------------------------------------------------------------=
    
    func testWordsX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        XCTAssertEqual(T(x64:(0, 0, 0, 0)).words.map({ $0 }), [0, 0, 0, 0])
        XCTAssertEqual(T(x64:(1, 0, 0, 0)).words.map({ $0 }), [1, 0, 0, 0])
        XCTAssertEqual(T(x64:(1, 2, 0, 0)).words.map({ $0 }), [1, 2, 0, 0])
        XCTAssertEqual(T(x64:(1, 2, 3, 0)).words.map({ $0 }), [1, 2, 3, 0])
        XCTAssertEqual(T(x64:(1, 2, 3, 4)).words.map({ $0 }), [1, 2, 3, 4])
    }
    
    func testWordsX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        XCTAssertEqual(T(x32:(0, 0, 0, 0, 0, 0, 0, 0)).words.map({ $0 }), [0, 0, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 0, 0, 0, 0, 0, 0, 0)).words.map({ $0 }), [1, 0, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 0, 0, 0, 0, 0, 0)).words.map({ $0 }), [1, 2, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 0, 0, 0, 0, 0)).words.map({ $0 }), [1, 2, 3, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 0, 0, 0, 0)).words.map({ $0 }), [1, 2, 3, 4, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 5, 0, 0, 0)).words.map({ $0 }), [1, 2, 3, 4, 5, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 5, 6, 0, 0)).words.map({ $0 }), [1, 2, 3, 4, 5, 6, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 5, 6, 7, 0)).words.map({ $0 }), [1, 2, 3, 4, 5, 6, 7, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 5, 6, 7, 8)).words.map({ $0 }), [1, 2, 3, 4, 5, 6, 7, 8])
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Minimum Two's Complement Form
    //=------------------------------------------------------------------------=
    
    func testMinWordCountReportingIsZeroOrMinusOneX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        XCTAssert(T(x64:( 0,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(T(x64:( 1,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(T(x64:( 0,  1,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(T(x64:( 0,  0,  1,  0)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(T(x64:( 0,  0,  0,  1)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        
        XCTAssert(T(x64:(~0, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(T(x64:( 1, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(T(x64:(~0,  1, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(T(x64:(~0, ~0,  1, ~0)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(T(x64:(~0, ~0, ~0,  1)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
    }
    
    func testMinWordCountReportingIsZeroOrMinusOneX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        XCTAssert(T(x32:( 0,  0,  0,  0,  0,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(T(x32:( 1,  0,  0,  0,  0,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(T(x32:( 0,  1,  0,  0,  0,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(T(x32:( 0,  0,  1,  0,  0,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(T(x32:( 0,  0,  0,  1,  0,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x32:( 0,  0,  0,  0,  1,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert(T(x32:( 0,  0,  0,  0,  0,  1,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert(T(x32:( 0,  0,  0,  0,  0,  0,  1,  0)).minWordCountReportingIsZeroOrMinusOne() == (7, false) as (Int, Bool))
        XCTAssert(T(x32:( 0,  0,  0,  0,  0,  0,  0,  1)).minWordCountReportingIsZeroOrMinusOne() == (8, false) as (Int, Bool))

        XCTAssert(T(x32:(~0, ~0, ~0, ~0, ~0, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(T(x32:( 1, ~0, ~0, ~0, ~0, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(T(x32:(~0,  1, ~0, ~0, ~0, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(T(x32:(~0, ~0,  1, ~0, ~0, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(T(x32:(~0, ~0, ~0,  1, ~0, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x32:(~0, ~0, ~0, ~0,  1, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert(T(x32:(~0, ~0, ~0, ~0, ~0,  1, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert(T(x32:(~0, ~0, ~0, ~0, ~0, ~0,  1, ~0)).minWordCountReportingIsZeroOrMinusOne() == (7, false) as (Int, Bool))
        XCTAssert(T(x32:(~0, ~0, ~0, ~0, ~0, ~0, ~0,  1)).minWordCountReportingIsZeroOrMinusOne() == (8, false) as (Int, Bool))
    }
}

//*============================================================================*
// MARK: * UInt256 x Words
//*============================================================================*

final class UInt256TestsOnWords: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBitWidth() {
        XCTAssertEqual(T(x64:( 0,  0,  0,  0)).bitWidth, 64 * 4)
        XCTAssertEqual(T(x64:(~0, ~0, ~0, ~0)).bitWidth, 64 * 4)
    }
    
    func testNonzeroBitCount() {
        XCTAssertEqual(T(x64:( 0,  0,  0,  0)).nonzeroBitCount, 0)
        XCTAssertEqual(T(x64:( 1,  1,  1,  1)).nonzeroBitCount, 4)
    }
    
    func testLeadingZeroBitCount() {
        XCTAssertEqual(T(x64:( 0,  0,  0,  0)).leadingZeroBitCount,  64 * 4)
        XCTAssertEqual(T(x64:(~0, ~0, ~0, ~0)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64:( 2,  0,  0,  0)).leadingZeroBitCount,  64 * 4 - 2)
        XCTAssertEqual(T(x64:( 0,  2,  0,  0)).leadingZeroBitCount,  64 * 3 - 2)
        XCTAssertEqual(T(x64:( 0,  0,  2,  0)).leadingZeroBitCount,  64 * 2 - 2)
        XCTAssertEqual(T(x64:( 0,  0,  0,  2)).leadingZeroBitCount,  64 * 1 - 2)
    }
    
    func testTrailingZeroBitCount() {
        XCTAssertEqual(T(x64:( 0,  0,  0,  0)).leadingZeroBitCount,  64 * 4)
        XCTAssertEqual(T(x64:(~0, ~0, ~0, ~0)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64:( 2,  0,  0,  0)).trailingZeroBitCount, 64 * 0 + 1)
        XCTAssertEqual(T(x64:( 0,  2,  0,  0)).trailingZeroBitCount, 64 * 1 + 1)
        XCTAssertEqual(T(x64:( 0,  0,  2,  0)).trailingZeroBitCount, 64 * 2 + 1)
        XCTAssertEqual(T(x64:( 0,  0,  0,  2)).trailingZeroBitCount, 64 * 3 + 1)
    }
    
    func testMostSignificantBit() {
        XCTAssertEqual(T(x64:( 0,  0,  0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64:(~0, ~0, ~0, ~0)).mostSignificantBit,  true )

        XCTAssertEqual(T(x64:(~0,  0,  0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64:( 0, ~0,  0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64:( 0,  0, ~0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64:( 0,  0,  0, ~0)).mostSignificantBit,  true )
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual(T(x64:( 0,  0,  0,  0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:(~0, ~0, ~0, ~0)).leastSignificantBit, true )

        XCTAssertEqual(T(x64:(~0,  0,  0,  0)).leastSignificantBit, true )
        XCTAssertEqual(T(x64:( 0, ~0,  0,  0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:( 0,  0, ~0,  0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:( 0,  0,  0, ~0)).leastSignificantBit, false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Collection
    //=------------------------------------------------------------------------=
    
    func testWordsX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        XCTAssertEqual(T(x64:(0, 0, 0, 0)).words.map({ $0 }), [0, 0, 0, 0])
        XCTAssertEqual(T(x64:(1, 0, 0, 0)).words.map({ $0 }), [1, 0, 0, 0])
        XCTAssertEqual(T(x64:(1, 2, 0, 0)).words.map({ $0 }), [1, 2, 0, 0])
        XCTAssertEqual(T(x64:(1, 2, 3, 0)).words.map({ $0 }), [1, 2, 3, 0])
        XCTAssertEqual(T(x64:(1, 2, 3, 4)).words.map({ $0 }), [1, 2, 3, 4])
    }
    
    func testWordsX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        XCTAssertEqual(T(x32:(0, 0, 0, 0, 0, 0, 0, 0)).words.map({ $0 }), [0, 0, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 0, 0, 0, 0, 0, 0, 0)).words.map({ $0 }), [1, 0, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 0, 0, 0, 0, 0, 0)).words.map({ $0 }), [1, 2, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 0, 0, 0, 0, 0)).words.map({ $0 }), [1, 2, 3, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 0, 0, 0, 0)).words.map({ $0 }), [1, 2, 3, 4, 0, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 5, 0, 0, 0)).words.map({ $0 }), [1, 2, 3, 4, 5, 0, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 5, 6, 0, 0)).words.map({ $0 }), [1, 2, 3, 4, 5, 6, 0, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 5, 6, 7, 0)).words.map({ $0 }), [1, 2, 3, 4, 5, 6, 7, 0])
        XCTAssertEqual(T(x32:(1, 2, 3, 4, 5, 6, 7, 8)).words.map({ $0 }), [1, 2, 3, 4, 5, 6, 7, 8])
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Minimum Two's Complement Form
    //=------------------------------------------------------------------------=
    
    func testMinWordCountReportingIsZeroOrMinusOneX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        XCTAssert(T(x64:( 0,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(T(x64:( 1,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(T(x64:( 0,  1,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(T(x64:( 0,  0,  1,  0)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(T(x64:( 0,  0,  0,  1)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        
        XCTAssert(T(x64:(~0, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x64:( 1, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x64:(~0,  1, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x64:(~0, ~0,  1, ~0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x64:(~0, ~0, ~0,  1)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
    }
    
    func testMinWordCountReportingIsZeroOrMinusOneX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        XCTAssert(T(x32:( 0,  0,  0,  0,  0,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(T(x32:( 1,  0,  0,  0,  0,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(T(x32:( 0,  1,  0,  0,  0,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(T(x32:( 0,  0,  1,  0,  0,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(T(x32:( 0,  0,  0,  1,  0,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x32:( 0,  0,  0,  0,  1,  0,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert(T(x32:( 0,  0,  0,  0,  0,  1,  0,  0)).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert(T(x32:( 0,  0,  0,  0,  0,  0,  1,  0)).minWordCountReportingIsZeroOrMinusOne() == (7, false) as (Int, Bool))
        XCTAssert(T(x32:( 0,  0,  0,  0,  0,  0,  0,  1)).minWordCountReportingIsZeroOrMinusOne() == (8, false) as (Int, Bool))

        XCTAssert(T(x32:(~0, ~0, ~0, ~0, ~0, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x32:( 1, ~0, ~0, ~0, ~0, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x32:(~0,  1, ~0, ~0, ~0, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x32:(~0, ~0,  1, ~0, ~0, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x32:(~0, ~0, ~0,  1, ~0, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x32:(~0, ~0, ~0, ~0,  1, ~0, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x32:(~0, ~0, ~0, ~0, ~0,  1, ~0, ~0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x32:(~0, ~0, ~0, ~0, ~0, ~0,  1, ~0)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(T(x32:(~0, ~0, ~0, ~0, ~0, ~0, ~0,  1)).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
    }
}

#endif
