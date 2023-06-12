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
import ANKFullWidthKit
import XCTest

private typealias X = ANK.U192X64
private typealias Y = ANK.U192X32

//*============================================================================*
// MARK: * ANK x Int192 x Complements
//*============================================================================*

final class Int192TestsOnComplements: XCTestCase {
    
    typealias T =  Int192
    typealias M = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit Pattern
    //=------------------------------------------------------------------------=
    
    func testInitBitPattern() {
        XCTAssertEqual(T(bitPattern: M.min), T( 0))
        XCTAssertEqual(T(bitPattern: M.max), T(-1))
        
        XCTAssertEqual(T(bitPattern:  (M(1) << (M.bitWidth - 1))), T.min)
        XCTAssertEqual(T(bitPattern: ~(M(1) << (M.bitWidth - 1))), T.max)
    }
    
    func testValueAsBitPattern() {
        XCTAssertEqual(T( 0).bitPattern, M.min)
        XCTAssertEqual(T(-1).bitPattern, M.max)
        
        XCTAssertEqual(T.min.bitPattern,  (M(1) << (M.bitWidth - 1)))
        XCTAssertEqual(T.max.bitPattern, ~(M(1) << (M.bitWidth - 1)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        XCTAssertEqual(T(-1).magnitude, M(1))
        XCTAssertEqual(T( 0).magnitude, M(0))
        XCTAssertEqual(T( 1).magnitude, M(1))
        
        XCTAssertEqual(T.min.magnitude,  (M(1) << (M.bitWidth - 1)))
        XCTAssertEqual(T.max.magnitude, ~(M(1) << (M.bitWidth - 1)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Two's Complement
    //=------------------------------------------------------------------------=
    
    func testTwosComplement() {
        ANKAssertTwosComplement(T(-1), T( 1))
        ANKAssertTwosComplement(T( 0), T( 0))
        ANKAssertTwosComplement(T( 1), T(-1))
        
        ANKAssertTwosComplement(T.min, T.min + 0, true)
        ANKAssertTwosComplement(T.max, T.min + 1)
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Complements
//*============================================================================*

final class UInt192TestsOnComplements: XCTestCase {
    
    typealias T = UInt192
    typealias M = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit Pattern
    //=------------------------------------------------------------------------=
    
    func testInitBitPattern() {
        XCTAssertEqual(T(bitPattern: M.min), T.min)
        XCTAssertEqual(T(bitPattern: M.max), T.max)
    }
    
    func testValueAsBitPattern() {
        XCTAssertEqual(T.min.bitPattern, M.min)
        XCTAssertEqual(T.max.bitPattern, M.max)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        XCTAssertEqual(T( 0).magnitude, M( 0))
        XCTAssertEqual(T( 1).magnitude, M( 1))
        
        XCTAssertEqual(T.min.magnitude, M.min)
        XCTAssertEqual(T.max.magnitude, M.max)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Two's Complement
    //=------------------------------------------------------------------------=
    
    func testTwosComplement() {
        ANKAssertTwosComplement(T( 1), T.max - 0)
        ANKAssertTwosComplement(T( 2), T.max - 1)
        ANKAssertTwosComplement(T( 3), T.max - 2)
        
        ANKAssertTwosComplement(T.min, T.min + 0,  true)
        ANKAssertTwosComplement(T.max, T.min + 1)
    }
}

#endif
