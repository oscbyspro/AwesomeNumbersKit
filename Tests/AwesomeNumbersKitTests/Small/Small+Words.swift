//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import AwesomeNumbersKit
import XCTest

//*============================================================================*
// MARK: * Int x Tests x Words
//*============================================================================*

final class IntTestsOnWords: XCTestCase {
    
    typealias T = Int
    typealias M = T.Magnitude
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt.max
    let s = UInt.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMostSignificantBit() {
        XCTAssertEqual(T.min.mostSignificantBit, true )
        XCTAssertEqual(T(  ).mostSignificantBit, false)
        XCTAssertEqual(T.max.mostSignificantBit, false)
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual(T.min.leastSignificantBit, false)
        XCTAssertEqual(T(  ).leastSignificantBit, false)
        XCTAssertEqual(T.max.leastSignificantBit, true )
    }
    
    func testMostSignificantWord() {
        XCTAssertEqual(T.min.leastSignificantWord, UInt.max << (s - 1))
        XCTAssertEqual(T(  ).leastSignificantWord, UInt(  ))
        XCTAssertEqual(T.max.leastSignificantWord, UInt.max >> (0 + 1))
    }
    
    func testLeastSignificantWord() {
        XCTAssertEqual(T.min.leastSignificantWord, UInt.max << (s - 1))
        XCTAssertEqual(T(  ).leastSignificantWord, UInt(  ))
        XCTAssertEqual(T.max.leastSignificantWord, UInt.max >> (0 + 1))
    }
}

//*============================================================================*
// MARK: * Int64 x Tests x Words
//*============================================================================*

final class Int64TestsOnWords: XCTestCase {
    
    typealias T = Int64
    typealias M = T.Magnitude
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt.max
    let s = UInt.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMostSignificantBit() {
        XCTAssertEqual(T.min.mostSignificantBit, true )
        XCTAssertEqual(T(  ).mostSignificantBit, false)
        XCTAssertEqual(T.max.mostSignificantBit, false)
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual(T.min.leastSignificantBit, false)
        XCTAssertEqual(T(  ).leastSignificantBit, false)
        XCTAssertEqual(T.max.leastSignificantBit, true )
    }
    
    func testMostSignificantWord() {
        XCTAssertEqual(T.min.leastSignificantWord, UInt.max << (s - 1))
        XCTAssertEqual(T(  ).leastSignificantWord, UInt(  ))
        XCTAssertEqual(T.max.leastSignificantWord, UInt.max >> (0 + 1))
    }
    
    func testLeastSignificantWord() {
        let k = (T.bitWidth / UInt.bitWidth)
        XCTAssertEqual(T.min.leastSignificantWord, UInt.max << (s - k))
        XCTAssertEqual(T(  ).leastSignificantWord, UInt(  ))
        XCTAssertEqual(T.max.leastSignificantWord, UInt.max >> (0 + k))
    }
}

//*============================================================================*
// MARK: * UInt x Tests x Words
//*============================================================================*

final class UIntTestsOnWords: XCTestCase {
    
    typealias T = UInt
    typealias M = T.Magnitude
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt.max
    let s = UInt.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMostSignificantBit() {
        XCTAssertEqual(T.min.mostSignificantBit, false)
        XCTAssertEqual(T(  ).mostSignificantBit, false)
        XCTAssertEqual(T.max.mostSignificantBit, true )
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual(T.min.leastSignificantBit, false)
        XCTAssertEqual(T(  ).leastSignificantBit, false)
        XCTAssertEqual(T.max.leastSignificantBit, true )
    }
    
    func testMostSignificantWord() {
        XCTAssertEqual(T.min.leastSignificantWord, UInt.min)
        XCTAssertEqual(T(  ).leastSignificantWord, UInt(  ))
        XCTAssertEqual(T.max.leastSignificantWord, UInt.max)
    }
    
    func testLeastSignificantWord() {
        XCTAssertEqual(T.min.leastSignificantWord, UInt.min)
        XCTAssertEqual(T(  ).leastSignificantWord, UInt(  ))
        XCTAssertEqual(T.max.leastSignificantWord, UInt.max)
    }
}

//*============================================================================*
// MARK: * Int64 x Tests x Words
//*============================================================================*

final class UInt64TestsOnWords: XCTestCase {
    
    typealias T = UInt64
    typealias M = T.Magnitude
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt.max
    let s = UInt.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMostSignificantBit() {
        XCTAssertEqual(T.min.mostSignificantBit, false)
        XCTAssertEqual(T(  ).mostSignificantBit, false)
        XCTAssertEqual(T.max.mostSignificantBit, true )
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual(T.min.leastSignificantBit, false)
        XCTAssertEqual(T(  ).leastSignificantBit, false)
        XCTAssertEqual(T.max.leastSignificantBit, true )
    }
    
    func testMostSignificantWord() {
        XCTAssertEqual(T.min.leastSignificantWord, UInt.min)
        XCTAssertEqual(T(  ).leastSignificantWord, UInt(  ))
        XCTAssertEqual(T.max.leastSignificantWord, UInt.max)
    }
    
    func testLeastSignificantWord() {
        XCTAssertEqual(T.min.leastSignificantWord, UInt.min)
        XCTAssertEqual(T(  ).leastSignificantWord, UInt(  ))
        XCTAssertEqual(T.max.leastSignificantWord, UInt.max)
    }
}

#endif
