//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit

//*============================================================================*
// MARK: * ANK x Signed x Subtraction x Digit
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public static func -=(lhs: inout Self, rhs: Digit) {
        //=--------------------------------------=
        if  lhs.sign != rhs.sign {
            lhs.magnitude += rhs.magnitude
            return
        }
        //=--------------------------------------=
        let extended = Magnitude(digit: rhs.magnitude)
        if  lhs.magnitude >= extended {
            lhs.magnitude -= rhs.magnitude
        //=--------------------------------------=
        }   else {
            lhs.sign.toggle()
            lhs.magnitude  = extended - lhs.magnitude
        }
    }
    
    @_disfavoredOverload @_transparent public static func -(lhs: Self, rhs: Digit) -> Self {
        var lhs = lhs; lhs -= rhs; return lhs
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Fixed Width x Subtraction x Digit
//*============================================================================*

extension ANKSigned where Magnitude: ANKFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @_transparent public static func &-=(lhs: inout Self, rhs: Digit) {
        _ = lhs.subtractReportingOverflow(rhs)
    }
    
    @_disfavoredOverload @_transparent public static func &-(lhs: Self, rhs: Digit) -> Self {
        lhs.subtractingReportingOverflow(rhs).partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public mutating func subtractReportingOverflow(_ other: Digit) -> Bool {
        //=--------------------------------------=
        if  self.sign != other.sign {
            return self.magnitude.addReportingOverflow(other.magnitude)
        }
        //=--------------------------------------=
        let magnitudeSubtractionOverflow = self.magnitude.subtractReportingOverflow(other.magnitude)
        if  magnitudeSubtractionOverflow {
            self.sign.toggle()
            self.magnitude.formTwosComplement()
        }
        
        return false
    }
    
    @_disfavoredOverload @inlinable public func subtractingReportingOverflow(_ other: Digit) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.subtractReportingOverflow(other)
        return PVO(partialValue, overflow)
    }
}
