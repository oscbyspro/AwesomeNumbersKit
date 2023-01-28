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
    
    let u = UInt.max
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testWords() throws {
        guard MemoryLayout<UInt>.size == 8 else { throw XCTSkip() }
        
        XCTAssertEqual(T(x64:(0, 0, 0)).words.map({ $0 }), [0, 0, 0])
        XCTAssertEqual(T(x64:(1, 0, 0)).words.map({ $0 }), [1, 0, 0])
        XCTAssertEqual(T(x64:(1, 2, 0)).words.map({ $0 }), [1, 2, 0])
        XCTAssertEqual(T(x64:(1, 2, 3)).words.map({ $0 }), [1, 2, 3])
        
        XCTAssertEqual(T(x64:(w, w, w)).words.map({ $0 }), [u, u, u])
        XCTAssertEqual(T(x64:(1, w, w)).words.map({ $0 }), [1, u, u])
        XCTAssertEqual(T(x64:(1, 2, w)).words.map({ $0 }), [1, 2, u])
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBitWidth() {
        XCTAssertEqual(T(x64:(0, 0, 0)).bitWidth, s * 3)
        XCTAssertEqual(T(x64:(w, w, w)).bitWidth, s * 3)
    }
    
    func testNonzeroBitCount() {
        XCTAssertEqual(T(x64:(0, 0, 0)).nonzeroBitCount, 0)
        XCTAssertEqual(T(x64:(1, 1, 1)).nonzeroBitCount, 3)
    }
    
    func testLeadingZeroBitCount() {
        XCTAssertEqual(T(x64:(0, 0, 0)).leadingZeroBitCount,  s * 3)
        XCTAssertEqual(T(x64:(w, w, w)).leadingZeroBitCount,  s * 0)
        
        XCTAssertEqual(T(x64:(2, 0, 0)).leadingZeroBitCount,  s * 3 - 2)
        XCTAssertEqual(T(x64:(0, 2, 0)).leadingZeroBitCount,  s * 2 - 2)
        XCTAssertEqual(T(x64:(0, 0, 2)).leadingZeroBitCount,  s * 1 - 2)
    }
    
    func testTrailingZeroBitCount() {
        XCTAssertEqual(T(x64:(0, 0, 0)).leadingZeroBitCount,  s * 3)
        XCTAssertEqual(T(x64:(w, w, w)).leadingZeroBitCount,  s * 0)
        
        XCTAssertEqual(T(x64:(2, 0, 0)).trailingZeroBitCount, s * 0 + 1)
        XCTAssertEqual(T(x64:(0, 2, 0)).trailingZeroBitCount, s * 1 + 1)
        XCTAssertEqual(T(x64:(0, 0, 2)).trailingZeroBitCount, s * 2 + 1)
    }
    
    func testMostSignificantBit() {
        XCTAssertEqual(T(x64:(0, 0, 0)).mostSignificantBit, false)
        XCTAssertEqual(T(x64:(w, w, w)).mostSignificantBit, true )

        XCTAssertEqual(T(x64:(w, 0, 0)).mostSignificantBit, false)
        XCTAssertEqual(T(x64:(0, w, 0)).mostSignificantBit, false)
        XCTAssertEqual(T(x64:(0, 0, w)).mostSignificantBit, true )
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual(T(x64:(0, 0, 0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:(w, w, w)).leastSignificantBit, true )

        XCTAssertEqual(T(x64:(w, 0, 0)).leastSignificantBit, true )
        XCTAssertEqual(T(x64:(0, w, 0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:(0, 0, w)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:(0, 0, 0)).leastSignificantBit, false)
    }
    
    func testMinWordCountReportingIsZeroOrMinusOne() throws {
        guard MemoryLayout<UInt>.size == 8 else { throw XCTSkip() }
        
        XCTAssert(T(x64:(0, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(T(x64:(w, w, w)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        
        XCTAssert(T(x64:(1, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(T(x64:(1, w, w)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        
        XCTAssert(T(x64:(0, 1, 0)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(T(x64:(w, 1, w)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        
        XCTAssert(T(x64:(0, 0, 1)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(T(x64:(w, w, 1)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
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
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testWords() throws {
        guard MemoryLayout<UInt>.size == 8 else { throw XCTSkip() }
        
        XCTAssertEqual(T(x64:(0, 0, 0)).words.map({ $0 }), [0, 0, 0])
        XCTAssertEqual(T(x64:(1, 0, 0)).words.map({ $0 }), [1, 0, 0])
        XCTAssertEqual(T(x64:(1, 2, 0)).words.map({ $0 }), [1, 2, 0])
        XCTAssertEqual(T(x64:(1, 2, 3)).words.map({ $0 }), [1, 2, 3])
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBitWidth() {
        XCTAssertEqual(T(x64:(0, 0, 0)).bitWidth, s * 3)
        XCTAssertEqual(T(x64:(w, w, w)).bitWidth, s * 3)
    }
    
    func testNonzeroBitCount() {
        XCTAssertEqual(T(x64:(0, 0, 0)).nonzeroBitCount, 0)
        XCTAssertEqual(T(x64:(1, 1, 1)).nonzeroBitCount, 3)
    }
    
    func testLeadingZeroBitCount() {
        XCTAssertEqual(T(x64:(0, 0, 0)).leadingZeroBitCount,  s * 3)
        XCTAssertEqual(T(x64:(w, w, w)).leadingZeroBitCount,  s * 0)
        
        XCTAssertEqual(T(x64:(2, 0, 0)).leadingZeroBitCount,  s * 3 - 2)
        XCTAssertEqual(T(x64:(0, 2, 0)).leadingZeroBitCount,  s * 2 - 2)
        XCTAssertEqual(T(x64:(0, 0, 2)).leadingZeroBitCount,  s * 1 - 2)
    }
    
    func testTrailingZeroBitCount() {
        XCTAssertEqual(T(x64:(0, 0, 0)).leadingZeroBitCount,  s * 3)
        XCTAssertEqual(T(x64:(w, w, w)).leadingZeroBitCount,  s * 0)
        
        XCTAssertEqual(T(x64:(2, 0, 0)).trailingZeroBitCount, s * 0 + 1)
        XCTAssertEqual(T(x64:(0, 2, 0)).trailingZeroBitCount, s * 1 + 1)
        XCTAssertEqual(T(x64:(0, 0, 2)).trailingZeroBitCount, s * 2 + 1)
    }
    
    func testMostSignificantBit() {
        XCTAssertEqual(T(x64:(0, 0, 0)).mostSignificantBit, false)
        XCTAssertEqual(T(x64:(w, w, w)).mostSignificantBit, true )

        XCTAssertEqual(T(x64:(w, 0, 0)).mostSignificantBit, false)
        XCTAssertEqual(T(x64:(0, w, 0)).mostSignificantBit, false)
        XCTAssertEqual(T(x64:(0, 0, w)).mostSignificantBit, true )
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual(T(x64:(0, 0, 0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:(w, w, w)).leastSignificantBit, true )

        XCTAssertEqual(T(x64:(w, 0, 0)).leastSignificantBit, true )
        XCTAssertEqual(T(x64:(0, w, 0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64:(0, 0, w)).leastSignificantBit, false)
    }
    
    func testMinWordCountReportingIsZeroOrMinusOne() throws {
        guard MemoryLayout<UInt>.size == 8 else { throw XCTSkip() }

        XCTAssert(T(x64:(0, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (1, true ) as (Int, Bool))
        XCTAssert(T(x64:(w, w, w)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))

        XCTAssert(T(x64:(1, 0, 0)).minWordCountReportingIsZeroOrMinusOne() == (1, false) as (Int, Bool))
        XCTAssert(T(x64:(1, w, w)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))

        XCTAssert(T(x64:(0, 1, 0)).minWordCountReportingIsZeroOrMinusOne() == (2, false) as (Int, Bool))
        XCTAssert(T(x64:(w, 1, w)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))

        XCTAssert(T(x64:(0, 0, 1)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
        XCTAssert(T(x64:(w, w, 1)).minWordCountReportingIsZeroOrMinusOne() == (3, false) as (Int, Bool))
    }
}

#endif
