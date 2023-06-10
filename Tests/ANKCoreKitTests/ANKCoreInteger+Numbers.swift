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
            XCTAssertEqual(T(ANKSigned(T.Magnitude(44), as: .minus)), T(-44))
            XCTAssertEqual(T(ANKSigned(T.Magnitude(44), as: .plus )), T( 44))
            
            XCTAssertEqual(T(exactly:  ANKSigned(T.Magnitude.max, as: .minus)), nil)
            XCTAssertEqual(T(exactly:  ANKSigned(T.Magnitude.max, as: .plus )), nil)
            
            XCTAssertEqual(T(clamping: ANKSigned(T.Magnitude.max, as: .minus)), T.min)
            XCTAssertEqual(T(clamping: ANKSigned(T.Magnitude.max, as: .plus )), T.max)
            
            XCTAssertEqual(T(truncatingIfNeeded: ANKSigned(T.Magnitude.max, as: .minus)),  T( 1))
            XCTAssertEqual(T(truncatingIfNeeded: ANKSigned(T.Magnitude.max, as: .plus )), ~T(  ))
        }
        
        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            XCTAssertEqual(T(ANKSigned(T.Magnitude(  ), as: .minus)),  T(  ))
            XCTAssertEqual(T(ANKSigned(T.Magnitude.max, as: .plus )),  T.max)
            
            XCTAssertEqual(T(exactly:  ANKSigned(T.Magnitude.max, as: .minus)),   nil)
            XCTAssertEqual(T(exactly:  ANKSigned(T.Magnitude.max, as: .plus )), T.max)
            
            XCTAssertEqual(T(clamping: ANKSigned(T.Magnitude.max, as: .minus)), T.min)
            XCTAssertEqual(T(clamping: ANKSigned(T.Magnitude.max, as: .plus )), T.max)
            
            XCTAssertEqual(T(truncatingIfNeeded: ANKSigned(T.Magnitude.max, as: .minus)),  T( 1))
            XCTAssertEqual(T(truncatingIfNeeded: ANKSigned(T.Magnitude.max, as: .plus )), ~T(  ))
        }
        
        for type: T in types {
            type.isSigned ? whereIsSigned(type) : whereIsUnsigned(type)
        }
    }
    
    func testsFromSignedMagnitudePlusMinusZero() {
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            XCTAssertEqual(T(ANKSigned(T.Magnitude(), as: .minus)), T())
            XCTAssertEqual(T(ANKSigned(T.Magnitude(), as: .plus )), T())

            XCTAssertEqual(T(exactly:  ANKSigned(T.Magnitude(), as: .minus)), T())
            XCTAssertEqual(T(exactly:  ANKSigned(T.Magnitude(), as: .plus )), T())
            
            XCTAssertEqual(T(clamping: ANKSigned(T.Magnitude(), as: .minus)), T())
            XCTAssertEqual(T(clamping: ANKSigned(T.Magnitude(), as: .plus )), T())
            
            XCTAssertEqual(T(truncatingIfNeeded: ANKSigned(T.Magnitude(), as: .minus)), T())
            XCTAssertEqual(T(truncatingIfNeeded: ANKSigned(T.Magnitude(), as: .plus )), T())
        }
        
        for type: T in types {
            whereIs(type)
        }
    }
}

#endif
