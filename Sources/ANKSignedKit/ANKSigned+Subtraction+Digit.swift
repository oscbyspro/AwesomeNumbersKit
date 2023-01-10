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
// MARK: * ANK x Signed x Large x Subtraction
//*============================================================================*

extension ANKLargeSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func -=(lhs: inout Self, rhs: Digit) {
        //=--------------------------------------=
        if  lhs.sign != rhs.sign {
            lhs.magnitude += rhs.magnitude
        //=--------------------------------------=
        }   else if lhs.magnitude >= rhs.magnitude {
            lhs.magnitude -= rhs.magnitude
        //=--------------------------------------=
        }   else {
            lhs.sign.toggle()
            lhs.magnitude  = Magnitude(digit: rhs.magnitude) - lhs.magnitude
        }
    }
    
    @_transparent public static func -(lhs: Self, rhs: Digit) -> Self {
        var lhs = lhs; lhs -= rhs; return lhs
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Large x Fixed Width x Subtraction
//*============================================================================*

extension ANKLargeSigned where Magnitude: ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func &-=(lhs: inout Self, rhs: Digit) {
        _ = lhs.subtractReportingOverflow(rhs)
    }
    
    @_transparent public static func &-(lhs: Self, rhs: Digit) -> Self {
        lhs.subtractingReportingOverflow(rhs).partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: Digit) -> Bool {
        //=--------------------------------------=
        if  self.sign != amount.sign {
            return self.magnitude.addReportingOverflow(amount.magnitude)
        }
        //=--------------------------------------=
        let overflow = self.magnitude.subtractReportingOverflow(amount.magnitude)
        if  overflow { self.sign.toggle();  self.magnitude.formTwosComplement() }
        return false
    }
    
    @inlinable public func subtractingReportingOverflow(_ amount: Digit) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.subtractReportingOverflow(amount)
        return PVO(partialValue, overflow)
    }
}
