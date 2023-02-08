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
// MARK: * Int192 x Words
//*============================================================================*

final class Int192TestsOnWords: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBitWidth() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).bitWidth, 64 * 3)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).bitWidth, 64 * 3)
    }
    
    func testNonzeroBitCount() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).nonzeroBitCount, 0)
        XCTAssertEqual(T(x64: X( 1,  1,  1)).nonzeroBitCount, 3)
    }
    
    func testLeadingZeroBitCount() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).leadingZeroBitCount,  64 * 3)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64: X( 2,  0,  0)).leadingZeroBitCount,  64 * 3 - 2)
        XCTAssertEqual(T(x64: X( 0,  2,  0)).leadingZeroBitCount,  64 * 2 - 2)
        XCTAssertEqual(T(x64: X( 0,  0,  2)).leadingZeroBitCount,  64 * 1 - 2)
    }
    
    func testTrailingZeroBitCount() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).leadingZeroBitCount,  64 * 3)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64: X( 2,  0,  0)).trailingZeroBitCount, 64 * 0 + 1)
        XCTAssertEqual(T(x64: X( 0,  2,  0)).trailingZeroBitCount, 64 * 1 + 1)
        XCTAssertEqual(T(x64: X( 0,  0,  2)).trailingZeroBitCount, 64 * 2 + 1)
    }
    
    func testMostSignificantBit() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).mostSignificantBit,  true )

        XCTAssertEqual(T(x64: X(~0,  0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64: X( 0, ~0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64: X( 0,  0, ~0)).mostSignificantBit,  true )
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).leastSignificantBit, true )

        XCTAssertEqual(T(x64: X(~0,  0,  0)).leastSignificantBit, true )
        XCTAssertEqual(T(x64: X( 0, ~0,  0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64: X( 0,  0, ~0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64: X( 0,  0,  0)).leastSignificantBit, false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Collection
    //=------------------------------------------------------------------------=
    
    func testWordsX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        XCTAssertEqual(T(x64: X(0, 0, 0)).words.map({ $0 }), [0, 0, 0])
        XCTAssertEqual(T(x64: X(1, 0, 0)).words.map({ $0 }), [1, 0, 0])
        XCTAssertEqual(T(x64: X(1, 2, 0)).words.map({ $0 }), [1, 2, 0])
        XCTAssertEqual(T(x64: X(1, 2, 3)).words.map({ $0 }), [1, 2, 3])
    }
    
    func testWordsX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0)).words.map({ $0 }), [0, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0, 0, 0)).words.map({ $0 }), [1, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32: Y(1, 2, 0, 0, 0, 0)).words.map({ $0 }), [1, 2, 0, 0, 0, 0])
        XCTAssertEqual(T(x32: Y(1, 2, 3, 0, 0, 0)).words.map({ $0 }), [1, 2, 3, 0, 0, 0])
        XCTAssertEqual(T(x32: Y(1, 2, 3, 4, 0, 0)).words.map({ $0 }), [1, 2, 3, 4, 0, 0])
        XCTAssertEqual(T(x32: Y(1, 2, 3, 4, 5, 0)).words.map({ $0 }), [1, 2, 3, 4, 5, 0])
        XCTAssertEqual(T(x32: Y(1, 2, 3, 4, 5, 6)).words.map({ $0 }), [1, 2, 3, 4, 5, 6])
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Minimum Two's Complement Form
    //=------------------------------------------------------------------------=
    
    func testMinLastIndexReportingIsZeroOrMinusOneX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        XCTAssert(( T(x64: X(0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (0, true ) as (Int, Bool))
        XCTAssert(( T(x64: X(1, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (0, false) as (Int, Bool))
        XCTAssert(( T(x64: X(0, 1, 0))).minLastIndexReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(( T(x64: X(0, 0, 1))).minLastIndexReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        
        XCTAssert((~T(x64: X(0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (0, true ) as (Int, Bool))
        XCTAssert((~T(x64: X(1, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (0, false) as (Int, Bool))
        XCTAssert((~T(x64: X(0, 1, 0))).minLastIndexReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert((~T(x64: X(0, 0, 1))).minLastIndexReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
    }
    
    func testMinWordCountReportingIsZeroOrMinusOneX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        XCTAssert(( T(x64: X(0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(( T(x64: X(1, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(( T(x64: X(0, 1, 0))).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(( T(x64: X(0, 0, 1))).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        
        XCTAssert((~T(x64: X(0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert((~T(x64: X(1, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert((~T(x64: X(0, 1, 0))).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert((~T(x64: X(0, 0, 1))).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
    }
    
    func testMinLastIndexReportingIsZeroOrMinusOneX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        XCTAssert(( T(x32: Y(0, 0, 0, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (0, true ) as (Int, Bool))
        XCTAssert(( T(x32: Y(1, 0, 0, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (0, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 1, 0, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 1, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 0, 1, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 0, 0, 1, 0))).minLastIndexReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 0, 0, 0, 1))).minLastIndexReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        
        XCTAssert((~T(x32: Y(0, 0, 0, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (0, true ) as (Int, Bool))
        XCTAssert((~T(x32: Y(1, 0, 0, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (0, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 1, 0, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 1, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 0, 1, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 0, 0, 1, 0))).minLastIndexReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 0, 0, 0, 1))).minLastIndexReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
    }
    
    func testMinWordCountReportingIsZeroOrMinusOneX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        XCTAssert(( T(x32: Y(0, 0, 0, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(( T(x32: Y(1, 0, 0, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 1, 0, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 1, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 0, 1, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 0, 0, 1, 0))).minWordCountReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 0, 0, 0, 1))).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        
        XCTAssert((~T(x32: Y(0, 0, 0, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert((~T(x32: Y(1, 0, 0, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 1, 0, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 1, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 0, 1, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 0, 0, 1, 0))).minWordCountReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 0, 0, 0, 1))).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
    }
}

//*============================================================================*
// MARK: * UInt192 x Words
//*============================================================================*

final class UInt192TestsOnWords: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBitWidth() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).bitWidth, 64 * 3)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).bitWidth, 64 * 3)
    }
    
    func testNonzeroBitCount() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).nonzeroBitCount, 0)
        XCTAssertEqual(T(x64: X( 1,  1,  1)).nonzeroBitCount, 3)
    }
    
    func testLeadingZeroBitCount() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).leadingZeroBitCount,  64 * 3)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64: X( 2,  0,  0)).leadingZeroBitCount,  64 * 3 - 2)
        XCTAssertEqual(T(x64: X( 0,  2,  0)).leadingZeroBitCount,  64 * 2 - 2)
        XCTAssertEqual(T(x64: X( 0,  0,  2)).leadingZeroBitCount,  64 * 1 - 2)
    }
    
    func testTrailingZeroBitCount() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).leadingZeroBitCount,  64 * 3)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64: X( 2,  0,  0)).trailingZeroBitCount, 64 * 0 + 1)
        XCTAssertEqual(T(x64: X( 0,  2,  0)).trailingZeroBitCount, 64 * 1 + 1)
        XCTAssertEqual(T(x64: X( 0,  0,  2)).trailingZeroBitCount, 64 * 2 + 1)
    }
    
    func testMostSignificantBit() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).mostSignificantBit,  true )

        XCTAssertEqual(T(x64: X(~0,  0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64: X( 0, ~0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64: X( 0,  0, ~0)).mostSignificantBit,  true )
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).leastSignificantBit, true )
        
        XCTAssertEqual(T(x64: X(~0,  0,  0)).leastSignificantBit, true )
        XCTAssertEqual(T(x64: X( 0, ~0,  0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64: X( 0,  0, ~0)).leastSignificantBit, false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Collection
    //=------------------------------------------------------------------------=
    
    func testWordsX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        XCTAssertEqual(T(x64: X(0, 0, 0)).words.map({ $0 }), [0, 0, 0])
        XCTAssertEqual(T(x64: X(1, 0, 0)).words.map({ $0 }), [1, 0, 0])
        XCTAssertEqual(T(x64: X(1, 2, 0)).words.map({ $0 }), [1, 2, 0])
        XCTAssertEqual(T(x64: X(1, 2, 3)).words.map({ $0 }), [1, 2, 3])
    }
    
    func testWordsX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0)).words.map({ $0 }), [0, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0, 0, 0)).words.map({ $0 }), [1, 0, 0, 0, 0, 0])
        XCTAssertEqual(T(x32: Y(1, 2, 0, 0, 0, 0)).words.map({ $0 }), [1, 2, 0, 0, 0, 0])
        XCTAssertEqual(T(x32: Y(1, 2, 3, 0, 0, 0)).words.map({ $0 }), [1, 2, 3, 0, 0, 0])
        XCTAssertEqual(T(x32: Y(1, 2, 3, 4, 0, 0)).words.map({ $0 }), [1, 2, 3, 4, 0, 0])
        XCTAssertEqual(T(x32: Y(1, 2, 3, 4, 5, 0)).words.map({ $0 }), [1, 2, 3, 4, 5, 0])
        XCTAssertEqual(T(x32: Y(1, 2, 3, 4, 5, 6)).words.map({ $0 }), [1, 2, 3, 4, 5, 6])
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Minimum Two's Complement Form
    //=------------------------------------------------------------------------=
    
    func testMinLastIndexReportingIsZeroOrMinusOneX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        XCTAssert(( T(x64: X(0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (0, true ) as (Int, Bool))
        XCTAssert(( T(x64: X(1, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (0, false) as (Int, Bool))
        XCTAssert(( T(x64: X(0, 1, 0))).minLastIndexReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(( T(x64: X(0, 0, 1))).minLastIndexReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        
        XCTAssert((~T(x64: X(0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert((~T(x64: X(1, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert((~T(x64: X(0, 1, 0))).minLastIndexReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert((~T(x64: X(0, 0, 1))).minLastIndexReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
    }
    
    func testMinWordCountReportingIsZeroOrMinusOneX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        XCTAssert(( T(x64: X(0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(( T(x64: X(1, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(( T(x64: X(0, 1, 0))).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(( T(x64: X(0, 0, 1))).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        
        XCTAssert((~T(x64: X(0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert((~T(x64: X(1, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert((~T(x64: X(0, 1, 0))).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert((~T(x64: X(0, 0, 1))).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
    }
    
    func testMinLastIndexReportingIsZeroOrMinusOneX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        XCTAssert(( T(x32: Y(0, 0, 0, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (0, true ) as (Int, Bool))
        XCTAssert(( T(x32: Y(1, 0, 0, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (0, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 1, 0, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 1, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 0, 1, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 0, 0, 1, 0))).minLastIndexReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 0, 0, 0, 1))).minLastIndexReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        
        XCTAssert((~T(x32: Y(0, 0, 0, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(1, 0, 0, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 1, 0, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 1, 0, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 0, 1, 0, 0))).minLastIndexReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 0, 0, 1, 0))).minLastIndexReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 0, 0, 0, 1))).minLastIndexReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
    }
    
    func testMinWordCountReportingIsZeroOrMinusOneX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        XCTAssert(( T(x32: Y(0, 0, 0, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(( T(x32: Y(1, 0, 0, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 1, 0, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 1, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 0, 1, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (4, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 0, 0, 1, 0))).minWordCountReportingIsZeroOrMinusOne() == (5, false) as (Int, Bool))
        XCTAssert(( T(x32: Y(0, 0, 0, 0, 0, 1))).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        
        XCTAssert((~T(x32: Y(0, 0, 0, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(1, 0, 0, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 1, 0, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 1, 0, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 0, 1, 0, 0))).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 0, 0, 1, 0))).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
        XCTAssert((~T(x32: Y(0, 0, 0, 0, 0, 1))).minWordCountReportingIsZeroOrMinusOne() == (6, false) as (Int, Bool))
    }
}

#endif
