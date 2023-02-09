//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKFoundation

//*============================================================================*
// MARK: * ANK x Signed x Large x Addition
//*============================================================================*

extension ANKSigned where Magnitude: ANKLargeBinaryInteger {

    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public static func +=(lhs: inout Self, rhs: Digit) {
        //=--------------------------------------=
        if  lhs.sign == rhs.sign {
            lhs.magnitude += rhs.magnitude
            return
        }
        //=--------------------------------------=
        let extended = Magnitude(digit: rhs.magnitude)
        if  lhs.magnitude >= extended {
            lhs.magnitude -= rhs.magnitude
        //=--------------------------------------=
        }   else {
            lhs.sign  = rhs.sign
            lhs.magnitude  = extended - lhs.magnitude
        }
    }
    
    @_disfavoredOverload @_transparent public static func +(lhs: Self, rhs: Digit) -> Self {
        var lhs = lhs; lhs += rhs; return lhs
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Fixed Width x Large x Addition
//*============================================================================*

extension ANKSigned where Magnitude: ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @_transparent public static func &+=(lhs: inout Self, rhs: Digit) {
        _ = lhs.addReportingOverflow(rhs)
    }
    
    @_disfavoredOverload @_transparent public static func &+(lhs: Self, rhs: Digit) -> Self {
        lhs.addingReportingOverflow(rhs).partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public mutating func addReportingOverflow(_ amount: Digit) -> Bool {
        //=--------------------------------------=
        if  self.sign == amount.sign {
            return self.magnitude.addReportingOverflow(amount.magnitude)
        }
        //=--------------------------------------=
        let overflow = self.magnitude.subtractReportingOverflow(amount.magnitude)
        if  overflow { self.sign = amount.sign; self.magnitude.formTwosComplement() }
        return false
    }
    
    @_disfavoredOverload @inlinable public func addingReportingOverflow(_ amount: Digit) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.addReportingOverflow(amount)
        return PVO(partialValue, overflow)
    }
}
