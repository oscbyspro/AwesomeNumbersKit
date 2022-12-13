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
}

#endif
