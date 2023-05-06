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
// MARK: * ANK x Core Integer x Comparisons
//*============================================================================*

final class ANKCoreIntegerTestsOnComparisons: XCTestCase {
    
    typealias T = any ANKCoreInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = ANKCoreIntegerTests.types
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsFull() {
        for type: T in types {
            XCTAssertEqual(type.init(truncatingIfNeeded:  0).isFull, false)
            XCTAssertEqual(type.init(truncatingIfNeeded:  1).isFull, false)
            XCTAssertEqual(type.init(truncatingIfNeeded:  2).isFull, false)
            
            XCTAssertEqual(type.init(truncatingIfNeeded: ~0).isFull, true )
            XCTAssertEqual(type.init(truncatingIfNeeded: ~1).isFull, false)
            XCTAssertEqual(type.init(truncatingIfNeeded: ~2).isFull, false)
        }
    }
    
    func testIsZero() {
        for type: T in types {
            XCTAssertEqual(type.init(truncatingIfNeeded:  0).isZero, true )
            XCTAssertEqual(type.init(truncatingIfNeeded:  1).isZero, false)
            XCTAssertEqual(type.init(truncatingIfNeeded:  2).isZero, false)
            
            XCTAssertEqual(type.init(truncatingIfNeeded: ~0).isZero, false)
            XCTAssertEqual(type.init(truncatingIfNeeded: ~1).isZero, false)
            XCTAssertEqual(type.init(truncatingIfNeeded: ~2).isZero, false)
        }
    }
    
    func testIsLessThanZero() {
        for type: T in types {
            XCTAssertEqual(type.init(truncatingIfNeeded:  0).isLessThanZero, false)
            XCTAssertEqual(type.init(truncatingIfNeeded:  1).isLessThanZero, false)
            XCTAssertEqual(type.init(truncatingIfNeeded:  2).isLessThanZero, false)
            
            XCTAssertEqual(type.init(truncatingIfNeeded: ~0).isLessThanZero, type.isSigned)
            XCTAssertEqual(type.init(truncatingIfNeeded: ~1).isLessThanZero, type.isSigned)
            XCTAssertEqual(type.init(truncatingIfNeeded: ~2).isLessThanZero, type.isSigned)
        }
    }
    
    func testIsMoreThanZero() {
        for type: T in types {
            XCTAssertEqual(type.init(truncatingIfNeeded:  0).isMoreThanZero, false)
            XCTAssertEqual(type.init(truncatingIfNeeded:  1).isMoreThanZero, true )
            XCTAssertEqual(type.init(truncatingIfNeeded:  2).isMoreThanZero, true )
            
            XCTAssertEqual(type.init(truncatingIfNeeded: ~0).isMoreThanZero, !type.isSigned)
            XCTAssertEqual(type.init(truncatingIfNeeded: ~1).isMoreThanZero, !type.isSigned)
            XCTAssertEqual(type.init(truncatingIfNeeded: ~2).isMoreThanZero, !type.isSigned)
        }
    }
    
    func testIsOdd() {
        for type: T in types {
            XCTAssertEqual(type.init(truncatingIfNeeded:  0).isOdd, false)
            XCTAssertEqual(type.init(truncatingIfNeeded:  1).isOdd, true )
            XCTAssertEqual(type.init(truncatingIfNeeded:  2).isOdd, false)
            
            XCTAssertEqual(type.init(truncatingIfNeeded: ~0).isOdd, true )
            XCTAssertEqual(type.init(truncatingIfNeeded: ~1).isOdd, false)
            XCTAssertEqual(type.init(truncatingIfNeeded: ~2).isOdd, true )
        }
    }
    
    func testIsEven() {
        for type: T in types {
            XCTAssertEqual(type.init(truncatingIfNeeded:  0).isEven, true )
            XCTAssertEqual(type.init(truncatingIfNeeded:  1).isEven, false)
            XCTAssertEqual(type.init(truncatingIfNeeded:  2).isEven, true )
            
            XCTAssertEqual(type.init(truncatingIfNeeded: ~0).isEven, false)
            XCTAssertEqual(type.init(truncatingIfNeeded: ~1).isEven, true )
            XCTAssertEqual(type.init(truncatingIfNeeded: ~2).isEven, false)
        }
    }
    
    func testMatchesRepeatingBit() {
        for type: T in types {
            XCTAssertEqual((type.init(truncatingIfNeeded:  0)).matches(repeating: true ), false)
            XCTAssertEqual((type.init(truncatingIfNeeded:  0)).matches(repeating: false), true )
            XCTAssertEqual((type.init(truncatingIfNeeded: ~0)).matches(repeating: true ), true )
            XCTAssertEqual((type.init(truncatingIfNeeded: ~0)).matches(repeating: false), false)
        }
    }
}

#endif
