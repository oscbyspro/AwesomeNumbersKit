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
// MARK: * ANK x Signed x Subtraction
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func -=(lhs: inout Self, rhs: Self) {
        //=--------------------------------------=
        if  lhs.sign != rhs.sign {
            lhs.magnitude += rhs.magnitude
        //=--------------------------------------=
        }   else if lhs.magnitude >= rhs.magnitude {
            lhs.magnitude -= rhs.magnitude
        //=--------------------------------------=
        }   else {
            lhs.sign.toggle()
            lhs.magnitude  = rhs.magnitude - lhs.magnitude
        }
    }
    
    @_transparent public static func -(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs -= rhs; return lhs
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Fixed Width x Subtraction
//*============================================================================*

extension ANKSigned where Magnitude: ANKFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func &-=(lhs: inout Self, rhs: Self) {
        _ = lhs.subtractReportingOverflow(rhs)
    }
    
    @_transparent public static func &-(lhs: Self, rhs: Self) -> Self {
        lhs.subtractingReportingOverflow(rhs).partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        //=--------------------------------------=
        if  self.sign != amount.sign {
            return self.magnitude.addReportingOverflow(amount.magnitude)
        }
        //=--------------------------------------=
        let overflow = self.magnitude.subtractReportingOverflow(amount.magnitude)
        if  overflow {
            self.sign.toggle()
            self.magnitude.formTwosComplement()
        }
        //=--------------------------------------=
        return false
    }
    
    @inlinable public func subtractingReportingOverflow(_ amount: Self) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.subtractReportingOverflow(amount)
        return PVO(partialValue, overflow)
    }
}
