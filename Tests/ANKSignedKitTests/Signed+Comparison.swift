//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed x Comparison
//*============================================================================*

final class SignedTestsOnComparison: XCTestCase {
    
    typealias T = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testEquating() {
        XCTAssert(T(0, as: .plus ) == T(0, as: .plus ))
        XCTAssert(T(0, as: .plus ) == T(0, as: .minus))
        XCTAssert(T(0, as: .minus) == T(0, as: .plus ))
        XCTAssert(T(0, as: .minus) == T(0, as: .minus))
        
        XCTAssert(T(0, as: .plus ) != T(1, as: .plus ))
        XCTAssert(T(0, as: .plus ) != T(1, as: .minus))
        XCTAssert(T(0, as: .minus) != T(1, as: .plus ))
        XCTAssert(T(0, as: .minus) != T(1, as: .minus))
        
        XCTAssert(T(1, as: .plus ) == T(1, as: .plus ))
        XCTAssert(T(1, as: .plus ) != T(1, as: .minus))
        XCTAssert(T(1, as: .minus) != T(1, as: .plus ))
        XCTAssert(T(1, as: .minus) == T(1, as: .minus))
        
        XCTAssert(T(1, as: .plus ) != T(0, as: .plus ))
        XCTAssert(T(1, as: .plus ) != T(0, as: .minus))
        XCTAssert(T(1, as: .minus) != T(0, as: .plus ))
        XCTAssert(T(1, as: .minus) != T(0, as: .minus))
    }
    
    func testComparing() {
        XCTAssert(T(0, as: .plus ) < T(1, as: .plus ))
        XCTAssert(T(0, as: .plus ) > T(1, as: .minus))
        XCTAssert(T(0, as: .minus) < T(1, as: .plus ))
        XCTAssert(T(0, as: .minus) > T(1, as: .minus))
        
        XCTAssert(T(1, as: .plus ) > T(1, as: .minus))
        XCTAssert(T(1, as: .minus) < T(1, as: .plus ))
        
        XCTAssert(T(1, as: .plus ) > T(0, as: .plus ))
        XCTAssert(T(1, as: .plus ) > T(0, as: .minus))
        XCTAssert(T(1, as: .minus) < T(0, as: .plus ))
        XCTAssert(T(1, as: .minus) < T(0, as: .minus))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsLessThanZero() {
        XCTAssertEqual(T(0, as: .plus ).isLessThanZero, false)
        XCTAssertEqual(T(0, as: .minus).isLessThanZero, false)
        
        XCTAssertEqual(T(1, as: .plus ).isLessThanZero, false)
        XCTAssertEqual(T(1, as: .minus).isLessThanZero, true )
    }
    
    func testIsMoreThanZero() {
        XCTAssertEqual(T(0, as: .plus ).isMoreThanZero, false)
        XCTAssertEqual(T(0, as: .minus).isMoreThanZero, false)
        
        XCTAssertEqual(T(1, as: .plus ).isMoreThanZero, true )
        XCTAssertEqual(T(1, as: .minus).isMoreThanZero, false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testHashValue()  {
        XCTAssert(T(0, as: .plus ).hashValue == T(0, as: .plus ).hashValue)
        XCTAssert(T(0, as: .plus ).hashValue == T(0, as: .minus).hashValue)
        XCTAssert(T(0, as: .minus).hashValue == T(0, as: .plus ).hashValue)
        XCTAssert(T(0, as: .minus).hashValue == T(0, as: .minus).hashValue)
        
        XCTAssert(T(1, as: .plus ).hashValue == T(1, as: .plus ).hashValue)
        XCTAssert(T(1, as: .plus ).hashValue != T(1, as: .minus).hashValue)
        XCTAssert(T(1, as: .minus).hashValue != T(1, as: .plus ).hashValue)
        XCTAssert(T(1, as: .minus).hashValue == T(1, as: .minus).hashValue)
    }
}

#endif
