//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKCoreKit
import XCTest

//*============================================================================*
// MARK: * ANK x Core Integer x Numbers
//*============================================================================*

final class ANKCoreIntegerTestsOnNumbers: XCTestCase {
    
    typealias T = any ANKCoreInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = ANKCoreIntegerTests.types
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Sign & Magnitude
    //=------------------------------------------------------------------------=
    
    func testsFromSignedMagnitude() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            typealias M = T.Magnitude
            
            XCTAssertEqual(T.exactly (sign: .plus,  magnitude: M( 1)), T( 1))
            XCTAssertEqual(T.exactly (sign: .minus, magnitude: M( 1)), T(-1))
            
            XCTAssertEqual(T.exactly (sign: .plus,  magnitude: M.max),   nil)
            XCTAssertEqual(T.exactly (sign: .minus, magnitude: M.max),   nil)
            
            XCTAssertEqual(T.exactly (sign: .plus,  magnitude: T.max.magnitude), T.max)
            XCTAssertEqual(T.exactly (sign: .minus, magnitude: T.min.magnitude), T.min)
            
            XCTAssertEqual(T.clamping(sign: .plus,  magnitude: M( 1)), T( 1))
            XCTAssertEqual(T.clamping(sign: .minus, magnitude: M( 1)), T(-1))
            
            XCTAssertEqual(T.clamping(sign: .plus,  magnitude: M.max), T.max)
            XCTAssertEqual(T.clamping(sign: .minus, magnitude: M.max), T.min)
            
            XCTAssertEqual(T.clamping(sign: .plus,  magnitude: T.max.magnitude), T.max)
            XCTAssertEqual(T.clamping(sign: .minus, magnitude: T.min.magnitude), T.min)
        }

        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            typealias M = T.Magnitude
            
            XCTAssertEqual(T.exactly (sign: .plus,  magnitude: M( 1)), T( 1))
            XCTAssertEqual(T.exactly (sign: .minus, magnitude: M( 1)),   nil)
            
            XCTAssertEqual(T.exactly (sign: .plus,  magnitude: M.max), T.max)
            XCTAssertEqual(T.exactly (sign: .minus, magnitude: M.max),   nil)
            
            XCTAssertEqual(T.exactly (sign: .plus,  magnitude: T.max.magnitude), T.max)
            XCTAssertEqual(T.exactly (sign: .minus, magnitude: T.min.magnitude), T.min)
            
            XCTAssertEqual(T.clamping(sign: .plus,  magnitude: M( 1)), T( 1))
            XCTAssertEqual(T.clamping(sign: .minus, magnitude: M( 1)), T.min)
            
            XCTAssertEqual(T.clamping(sign: .plus,  magnitude: M.max), T.max)
            XCTAssertEqual(T.clamping(sign: .minus, magnitude: M.max), T.min)
            
            XCTAssertEqual(T.clamping(sign: .plus,  magnitude: T.max.magnitude), T.max)
            XCTAssertEqual(T.clamping(sign: .minus, magnitude: T.min.magnitude), T.min)
        }

        for type: T in types {
            type.isSigned ? whereIsSigned(type) : whereIsUnsigned(type)
        }
    }

    func testsFromSignedMagnitudePlusMinusZero() {
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            typealias M = T.Magnitude
            
            XCTAssertEqual(T.exactly (sign: .plus,  magnitude: M(  )), T(  ))
            XCTAssertEqual(T.exactly (sign: .minus, magnitude: M(  )), T(  ))
            
            XCTAssertEqual(T.clamping(sign: .plus,  magnitude: M(  )), T(  ))
            XCTAssertEqual(T.clamping(sign: .minus, magnitude: M(  )), T(  ))
        }

        for type: T in types {
            whereIs(type)
        }
    }
}

#endif
