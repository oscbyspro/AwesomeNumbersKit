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
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed x Numbers
//*============================================================================*

final class ANKSignedTestsOnNumbers: XCTestCase {
    
    typealias S =  Int256
    typealias M = UInt256
    
    typealias T = ANKSigned<UInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Signitude
    //=------------------------------------------------------------------------=
    
    func testsToSignitude() {
        XCTAssertEqual(S(          T(M( 1), as: .plus )), S( 1))
        XCTAssertEqual(S(exactly:  T(M( 1), as: .plus )), S( 1))
        XCTAssertEqual(S(clamping: T(M( 1), as: .plus )), S( 1))
        
        XCTAssertEqual(S(          T(M( 1), as: .minus)), S(-1))
        XCTAssertEqual(S(exactly:  T(M( 1), as: .minus)), S(-1))
        XCTAssertEqual(S(clamping: T(M( 1), as: .minus)), S(-1))
        
        XCTAssertEqual(S(exactly:  T(M.max, as: .plus )),   nil)
        XCTAssertEqual(S(clamping: T(M.max, as: .plus )), S.max)
        
        XCTAssertEqual(S(exactly:  T(M.max, as: .minus)),   nil)
        XCTAssertEqual(S(clamping: T(M.max, as: .minus)), S.min)
        
        XCTAssertEqual(S(          T(S.max.magnitude, as: .plus )), S.max)
        XCTAssertEqual(S(exactly:  T(S.max.magnitude, as: .plus )), S.max)
        XCTAssertEqual(S(clamping: T(S.max.magnitude, as: .plus )), S.max)
        
        XCTAssertEqual(S(          T(S.min.magnitude, as: .minus)), S.min)
        XCTAssertEqual(S(exactly:  T(S.min.magnitude, as: .minus)), S.min)
        XCTAssertEqual(S(clamping: T(S.min.magnitude, as: .minus)), S.min)
    }

    func testToSignitudeAsPlusMinusZero() {
        XCTAssertEqual(S(          T(M(  ), as: .plus )), S(  ))
        XCTAssertEqual(S(exactly:  T(M(  ), as: .plus )), S(  ))
        XCTAssertEqual(S(clamping: T(M(  ), as: .plus )), S(  ))
        
        XCTAssertEqual(S(          T(M(  ), as: .minus)), S(  ))
        XCTAssertEqual(S(exactly:  T(M(  ), as: .minus)), S(  ))
        XCTAssertEqual(S(clamping: T(M(  ), as: .minus)), S(  ))
    }
    
    func testFromSignitude() {
        ANKAssertIdentical(T(          S( 1)),  T(1))
        ANKAssertIdentical(T(exactly:  S( 1)),  T(1))
        ANKAssertIdentical(T(clamping: S( 1)),  T(1))

        ANKAssertIdentical(T(          S(  )),  T( ))
        ANKAssertIdentical(T(exactly:  S(  )),  T( ))
        ANKAssertIdentical(T(clamping: S(  )),  T( ))
        
        ANKAssertIdentical(T(          S(-1)), -T(1))
        ANKAssertIdentical(T(exactly:  S(-1)), -T(1))
        ANKAssertIdentical(T(clamping: S(-1)), -T(1))
        
        ANKAssertIdentical(T(          S.max),  T(M(S.max) + 0, as: .plus ))
        ANKAssertIdentical(T(exactly:  S.max),  T(M(S.max) + 0, as: .plus ))
        ANKAssertIdentical(T(clamping: S.max),  T(M(S.max) + 0, as: .plus ))
        
        ANKAssertIdentical(T(          S.min),  T(M(S.max) + 1, as: .minus))
        ANKAssertIdentical(T(exactly:  S.min),  T(M(S.max) + 1, as: .minus))
        ANKAssertIdentical(T(clamping: S.min),  T(M(S.max) + 1, as: .minus))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testsToMagnitude() {
        XCTAssertEqual(M(          T(M( 1), as: .plus )), M( 1))
        XCTAssertEqual(M(exactly:  T(M( 1), as: .plus )), M( 1))
        XCTAssertEqual(M(clamping: T(M( 1), as: .plus )), M( 1))

        XCTAssertEqual(M(exactly:  T(M( 1), as: .minus)),   nil)
        XCTAssertEqual(M(clamping: T(M( 1), as: .minus)), M.min)
        
        XCTAssertEqual(M(          T(M.max, as: .plus )), M.max)
        XCTAssertEqual(M(exactly:  T(M.max, as: .plus )), M.max)
        XCTAssertEqual(M(clamping: T(M.max, as: .plus )), M.max)

        XCTAssertEqual(M(exactly:  T(M.max, as: .minus)),   nil)
        XCTAssertEqual(M(clamping: T(M.max, as: .minus)), M.min)
        
        XCTAssertEqual(M(          T(M.max.magnitude, as: .plus )), M.max)
        XCTAssertEqual(M(exactly:  T(M.max.magnitude, as: .plus )), M.max)
        XCTAssertEqual(M(clamping: T(M.max.magnitude, as: .plus )), M.max)
        
        XCTAssertEqual(M(          T(M.min.magnitude, as: .minus)), M.min)
        XCTAssertEqual(M(exactly:  T(M.min.magnitude, as: .minus)), M.min)
        XCTAssertEqual(M(clamping: T(M.min.magnitude, as: .minus)), M.min)
    }

    func testToMagnitudeAsPlusMinusZero() {
        XCTAssertEqual(M(          T(M(  ), as: .plus )), M(  ))
        XCTAssertEqual(M(exactly:  T(M(  ), as: .plus )), M(  ))
        XCTAssertEqual(M(clamping: T(M(  ), as: .plus )), M(  ))
        
        XCTAssertEqual(M(          T(M(  ), as: .minus)), M(  ))
        XCTAssertEqual(M(exactly:  T(M(  ), as: .minus)), M(  ))
        XCTAssertEqual(M(clamping: T(M(  ), as: .minus)), M(  ))
    }
    
    func testFromMagnitude() {
        ANKAssertIdentical(T(          M(  )), T(  ))
        ANKAssertIdentical(T(exactly:  M(  )), T(  ))
        ANKAssertIdentical(T(clamping: M(  )), T(  ))
        
        ANKAssertIdentical(T(          M( 1)), T( 1))
        ANKAssertIdentical(T(exactly:  M( 1)), T( 1))
        ANKAssertIdentical(T(clamping: M( 1)), T( 1))
        
        ANKAssertIdentical(T(          M.max), T.max)
        ANKAssertIdentical(T(exactly:  M.max), T.max)
        ANKAssertIdentical(T(clamping: M.max), T.max)
    }
}

#endif
