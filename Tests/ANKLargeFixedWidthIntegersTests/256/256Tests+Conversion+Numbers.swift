//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKLargeFixedWidthIntegers
import XCTest

//*============================================================================*
// MARK: * Int256 x Tests x Conversion x Numbers
//*============================================================================*

final class Int256TestsOnConversionAsNumbers: XCTestCase {
    
    typealias T = Int256
    typealias S = Int256
    typealias M = T.Magnitude
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Integers
    //=------------------------------------------------------------------------=
    
    func testToIntegers() {
        XCTAssertEqual(UInt64(T(x64:(1, 0, 0, 0))), 1)
        XCTAssertEqual(UInt64(T(x64:(w, 0, 0, 0))), w)

        XCTAssertEqual(UInt64(clamping: T(x64:(1, 0, 0, 0))), 1)
        XCTAssertEqual(UInt64(clamping: T(x64:(w, 0, 0, 0))), w)
        XCTAssertEqual(UInt64(clamping: T(x64:(1, 1, 1, 1))), w)
        XCTAssertEqual(UInt64(clamping: T(x64:(w, w, w, w))), 0)

        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64:(1, 0, 0, 0))), 1)
        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64:(w, 0, 0, 0))), w)
        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64:(1, 1, 1, 1))), 1)
        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64:(w, w, w, w))), w)
        
        XCTAssertEqual(UInt64(exactly: T(x64:(1, 0, 0, 0))), 1)
        XCTAssertEqual(UInt64(exactly: T(x64:(w, 0, 0, 0))), w)
        XCTAssertEqual(UInt64(exactly: T(x64:(1, 1, 1, 1))), nil)
        XCTAssertEqual(UInt64(exactly: T(x64:(w, w, w, w))), nil)
    }
    
    func testFromIntegers() {
        XCTAssertEqual(T(Int8.min), -128)
        XCTAssertEqual(T(Int8.max),  127)
        
        XCTAssertEqual(T(exactly: Int8.min), -128)
        XCTAssertEqual(T(exactly: Int8.max),  127)
        
        XCTAssertEqual(T(clamping: Int8.min), -128)
        XCTAssertEqual(T(clamping: Int8.max),  127)
        
        XCTAssertEqual(T(truncatingIfNeeded: Int8.min), -128)
        XCTAssertEqual(T(truncatingIfNeeded: Int8.max),  127)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int
    //=------------------------------------------------------------------------=
    
    func testFromInt() {
        XCTAssertEqual(T(Int.min), T(x64:(UInt64(truncatingIfNeeded: Int.min), w, w, w)))
        XCTAssertEqual(T(Int.max), T(x64:(UInt64(truncatingIfNeeded: Int.max), 0, 0, 0)))
        
        XCTAssertEqual(T(exactly:  Int.min), T(x64:(UInt64(truncatingIfNeeded: Int.min), w, w, w)))
        XCTAssertEqual(T(exactly:  Int.max), T(x64:(UInt64(truncatingIfNeeded: Int.max), 0, 0, 0)))
        
        XCTAssertEqual(T(clamping: Int.min), T(x64:(UInt64(truncatingIfNeeded: Int.min), w, w, w)))
        XCTAssertEqual(T(clamping: Int.max), T(x64:(UInt64(truncatingIfNeeded: Int.max), 0, 0, 0)))
        
        XCTAssertEqual(T(truncatingIfNeeded: Int.min), T(x64:(UInt64(truncatingIfNeeded: Int.min), w, w, w)))
        XCTAssertEqual(T(truncatingIfNeeded: Int.max), T(x64:(UInt64(truncatingIfNeeded: Int.max), 0, 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt
    //=------------------------------------------------------------------------=
    
    func testFromUInt() {
        XCTAssertEqual(T(UInt.min), T(x64:(UInt64(truncatingIfNeeded: UInt.min), 0, 0, 0)))
        XCTAssertEqual(T(UInt.max), T(x64:(UInt64(truncatingIfNeeded: UInt.max), 0, 0, 0)))
        
        XCTAssertEqual(T(exactly:  UInt.min), T(x64:(UInt64(truncatingIfNeeded: UInt.min), 0, 0, 0)))
        XCTAssertEqual(T(exactly:  UInt.max), T(x64:(UInt64(truncatingIfNeeded: UInt.max), 0, 0, 0)))
        
        XCTAssertEqual(T(clamping: UInt.min), T(x64:(UInt64(truncatingIfNeeded: UInt.min), 0, 0, 0)))
        XCTAssertEqual(T(clamping: UInt.max), T(x64:(UInt64(truncatingIfNeeded: UInt.max), 0, 0, 0)))
        
        XCTAssertEqual(T(truncatingIfNeeded: UInt.min), T(x64:(UInt64(truncatingIfNeeded: UInt.min), 0, 0, 0)))
        XCTAssertEqual(T(truncatingIfNeeded: UInt.max), T(x64:(UInt64(truncatingIfNeeded: UInt.max), 0, 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Signitude
    //=------------------------------------------------------------------------=
    
    func testFromSignitude() {
        XCTAssertEqual(T(S.min), T.min)
        XCTAssertEqual(T(S.max), T.max)
        
        XCTAssertEqual(T(exactly:  S.min), T.min)
        XCTAssertEqual(T(exactly:  S.max), T.max)

        XCTAssertEqual(T(clamping: S.min), T.min)
        XCTAssertEqual(T(clamping: S.max), T.max)

        XCTAssertEqual(T(truncatingIfNeeded: S.min), T.min)
        XCTAssertEqual(T(truncatingIfNeeded: S.max), T.max)
    }

    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testFromMagnitude() {
        XCTAssertEqual(T(M.min), T(  ))
        /*---------------------------*/
        
        XCTAssertEqual(T(exactly:  M.min), T(  ))
        XCTAssertEqual(T(exactly:  M.max),   nil)

        XCTAssertEqual(T(clamping: M.min), T(  ))
        XCTAssertEqual(T(clamping: M.max), T.max)

        XCTAssertEqual(T(truncatingIfNeeded: M.min), T(x64:(0, 0, 0, 0)))
        XCTAssertEqual(T(truncatingIfNeeded: M.max), T(x64:(w, w, w, w)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Floats
    //=------------------------------------------------------------------------=
    
    func testToFloats() {
        XCTAssertEqual(Float32(T(-1)), -1.0)
        XCTAssertEqual(Float32(T( 0)),  0.0)
        XCTAssertEqual(Float32(T( 1)),  1.0)

        XCTAssertEqual(Float64(T( Int.min)), -9223372036854775808.0)
        XCTAssertEqual(Float64(T( Int.max)),  9223372036854775807.0)

        XCTAssertEqual(Float64(T(UInt.min)),                    0.0)
        XCTAssertEqual(Float64(T(UInt.max)), 18446744073709551615.0)
    }
    
    func testFromFloats() {
        XCTAssertEqual(T( 22.0),  22)
        XCTAssertEqual(T(-22.0), -22)
        XCTAssertEqual(T( 22.5),  22)
        XCTAssertEqual(T(-22.5), -22)
        
        XCTAssertEqual(T(exactly: 3.0 * pow(2, Float64(0 * s - 2))), nil)
        XCTAssertEqual(T(exactly: 3.0 * pow(2, Float64(1 * s - 2))), T(x64:(3 << (s - 2), 0, 0, 0)))
        XCTAssertEqual(T(exactly: 3.0 * pow(2, Float64(2 * s - 2))), T(x64:(0, 3 << (s - 2), 0, 0)))
        XCTAssertEqual(T(exactly: 3.0 * pow(2, Float64(3 * s - 2))), T(x64:(0, 0, 3 << (s - 2), 0)))
    }
    
    func testFromFloatsAsNil() {
        XCTAssertNil(T(exactly:  22.5))
        XCTAssertNil(T(exactly: -22.5))
        XCTAssertNil(T(exactly:  pow(Float64(2), Float64(T.bitWidth))))
        XCTAssertNil(T(exactly: -pow(Float64(2), Float64(T.bitWidth))))
        
        XCTAssertNil(T(exactly: Float64.nan))
        XCTAssertNil(T(exactly: Float64.infinity))
        XCTAssertNil(T(exactly: Float64.signalingNaN))
        XCTAssertNil(T(exactly: Float64.leastNormalMagnitude))
        XCTAssertNil(T(exactly: Float64.leastNonzeroMagnitude))
        XCTAssertNil(T(exactly: Float64.greatestFiniteMagnitude))
    }
}

//*============================================================================*
// MARK: * UInt256 x Tests x Conversion x Numbers
//*============================================================================*

final class UInt256TestsOnConversionAsNumbers: XCTestCase {
    
    typealias T = UInt256
    typealias S =  Int256
    typealias M = T.Magnitude
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Integers
    //=------------------------------------------------------------------------=
    
    func testToIntegers() {
        XCTAssertEqual(UInt64(T(x64:(1, 0, 0, 0))), 1)
        XCTAssertEqual(UInt64(T(x64:(w, 0, 0, 0))), w)
        
        XCTAssertEqual(UInt64(clamping: T(x64:(1, 0, 0, 0))), 1)
        XCTAssertEqual(UInt64(clamping: T(x64:(w, 0, 0, 0))), w)
        XCTAssertEqual(UInt64(clamping: T(x64:(1, 1, 1, 1))), w)
        XCTAssertEqual(UInt64(clamping: T(x64:(w, w, w, w))), w)
        
        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64:(1, 0, 0, 0))), 1)
        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64:(w, 0, 0, 0))), w)
        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64:(1, 1, 1, 1))), 1)
        XCTAssertEqual(UInt64(truncatingIfNeeded: T(x64:(w, w, w, w))), w)
        
        XCTAssertEqual(UInt64(exactly: T(x64:(1, 0, 0, 0))), 1)
        XCTAssertEqual(UInt64(exactly: T(x64:(w, 0, 0, 0))), w)
        XCTAssertEqual(UInt64(exactly: T(x64:(1, 1, 1, 1))), nil)
        XCTAssertEqual(UInt64(exactly: T(x64:(w, w, w, w))), nil)
    }
    
    func testFromIntegers() {
        XCTAssertEqual(T(UInt8.min),   0)
        XCTAssertEqual(T(UInt8.max), 255)
        
        XCTAssertEqual(T(exactly:  Int8.min), nil)
        XCTAssertEqual(T(exactly:  Int8.max), 127)
        
        XCTAssertEqual(T(clamping: Int8.min),   0)
        XCTAssertEqual(T(clamping: Int8.max), 127)
        
        XCTAssertEqual(T(truncatingIfNeeded: Int8.min), T.max - 127)
        XCTAssertEqual(T(truncatingIfNeeded: Int8.max),         127)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int
    //=------------------------------------------------------------------------=
    
    func testFromInt() {
        /*-----------------------------------------------------------------------------*/
        XCTAssertEqual(T(Int.max), T(x64:(UInt64(truncatingIfNeeded: Int.max), 0, 0, 0)))
        
        XCTAssertEqual(T(exactly:  Int.min), nil)
        XCTAssertEqual(T(exactly:  Int.max), T(x64:(UInt64(truncatingIfNeeded: Int.max), 0, 0, 0)))
        
        XCTAssertEqual(T(clamping: Int.min), T(x64:(UInt64(truncatingIfNeeded: Int(  )), 0, 0, 0)))
        XCTAssertEqual(T(clamping: Int.max), T(x64:(UInt64(truncatingIfNeeded: Int.max), 0, 0, 0)))
        
        XCTAssertEqual(T(truncatingIfNeeded: Int.min), T(x64:(UInt64(truncatingIfNeeded: Int.min), w, w, w)))
        XCTAssertEqual(T(truncatingIfNeeded: Int.max), T(x64:(UInt64(truncatingIfNeeded: Int.max), 0, 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt
    //=------------------------------------------------------------------------=
    
    func testFromUInt() {
        XCTAssertEqual(T(UInt.min), T(x64:(UInt64(truncatingIfNeeded: UInt.min), 0, 0, 0)))
        XCTAssertEqual(T(UInt.max), T(x64:(UInt64(truncatingIfNeeded: UInt.max), 0, 0, 0)))
        
        XCTAssertEqual(T(exactly:  UInt.min), T(x64:(UInt64(truncatingIfNeeded: UInt.min), 0, 0, 0)))
        XCTAssertEqual(T(exactly:  UInt.max), T(x64:(UInt64(truncatingIfNeeded: UInt.max), 0, 0, 0)))
        
        XCTAssertEqual(T(clamping: UInt.min), T(x64:(UInt64(truncatingIfNeeded: UInt.min), 0, 0, 0)))
        XCTAssertEqual(T(clamping: UInt.max), T(x64:(UInt64(truncatingIfNeeded: UInt.max), 0, 0, 0)))
        
        XCTAssertEqual(T(truncatingIfNeeded: UInt.min), T(x64:(UInt64(truncatingIfNeeded: UInt.min), 0, 0, 0)))
        XCTAssertEqual(T(truncatingIfNeeded: UInt.max), T(x64:(UInt64(truncatingIfNeeded: UInt.max), 0, 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Signitude
    //=------------------------------------------------------------------------=
    
    func testFromSignitude() {
        /*---------------------------------------------------------------------*/
        XCTAssertEqual(T(S.max), T(x64:(w, w, w, UInt64(bitPattern: Int64.max))))
        
        XCTAssertEqual(T(exactly:  S.min), nil)
        XCTAssertEqual(T(exactly:  S.max), T(x64:(w, w, w, UInt64(bitPattern: Int64.max))))

        XCTAssertEqual(T(clamping: S.min), T(x64:(0, 0, 0, UInt64(bitPattern: Int64(  )))))
        XCTAssertEqual(T(clamping: S.max), T(x64:(w, w, w, UInt64(bitPattern: Int64.max))))

        XCTAssertEqual(T(truncatingIfNeeded: S.min), T(x64:(0, 0, 0, UInt64(bitPattern: Int64.min))))
        XCTAssertEqual(T(truncatingIfNeeded: S.max), T(x64:(w, w, w, UInt64(bitPattern: Int64.max))))
    }

    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testFromMagnitude() {
        XCTAssertEqual(T(M.min), T.min)
        XCTAssertEqual(T(M.max), T.max)
        
        XCTAssertEqual(T(exactly:  M.min), T.min)
        XCTAssertEqual(T(exactly:  M.max), T.max)

        XCTAssertEqual(T(clamping: M.min), T.min)
        XCTAssertEqual(T(clamping: M.max), T.max)

        XCTAssertEqual(T(truncatingIfNeeded: M.min), T.min)
        XCTAssertEqual(T(truncatingIfNeeded: M.max), T.max)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Floats
    //=------------------------------------------------------------------------=
    
    func testToFloats() {
        XCTAssertEqual(Float32(T(x64:(0, 0, 0, 0))), 0.0)
        XCTAssertEqual(Float32(T(x64:(1, 0, 0, 0))), 1.0)

        XCTAssertEqual(Float64(T(x64:(0, 0, 0, 0))), 0.0)
        XCTAssertEqual(Float64(T(x64:(w, 0, 0, 0))), 18446744073709551615.0)
    }
    
    func testFromFloats() {
        XCTAssertEqual(T(22.0), 22)
        XCTAssertEqual(T(22.5), 22)
                
        XCTAssertEqual(T(exactly: 3.0 * pow(2,  -1)), nil)
        XCTAssertEqual(T(exactly: 3.0 * pow(2,  62)), T(x64:(3 << 62, 0, 0, 0)))
        XCTAssertEqual(T(exactly: 3.0 * pow(2, 126)), T(x64:(0, 3 << 62, 0, 0)))
        XCTAssertEqual(T(exactly: 3.0 * pow(2, 190)), T(x64:(0, 0, 3 << 62, 0)))
        XCTAssertEqual(T(exactly: 3.0 * pow(2, 254)), T(x64:(0, 0, 0, 3 << 62)))
        XCTAssertEqual(T(exactly: 3.0 * pow(2, 255)), nil)
    }
    
    func testFromFloatsAsNil() {
        XCTAssertNil(T(exactly:  22.5))
        XCTAssertNil(T(exactly: -22.5))
        XCTAssertNil(T(exactly:  pow(Float64(2), Float64(T.bitWidth))))
        XCTAssertNil(T(exactly: -pow(Float64(2), Float64(T.bitWidth))))

        XCTAssertNil(T(exactly: Float64.nan))
        XCTAssertNil(T(exactly: Float64.infinity))
        XCTAssertNil(T(exactly: Float64.signalingNaN))
        XCTAssertNil(T(exactly: Float64.leastNormalMagnitude))
        XCTAssertNil(T(exactly: Float64.leastNonzeroMagnitude))
        XCTAssertNil(T(exactly: Float64.greatestFiniteMagnitude))
    }
}
#endif