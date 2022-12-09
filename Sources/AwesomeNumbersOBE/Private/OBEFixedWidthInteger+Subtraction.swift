//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import AwesomeNumbersKit

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Subtraction
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func -=(lhs: inout Self, rhs: Self) {
        let o = lhs.subtractReportingOverflow(rhs); precondition(!o)
    }
    
    @inlinable public static func -(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs -= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        let o: (Bool, Bool, Bool)
        o.0 = self.low .subtractReportingOverflow(amount.low )
        o.1 = self.high.subtractReportingOverflow(amount.high)
        o.2 = self.high.subtractReportingOverflow(o.0 ? 1 : 0 as High) // TODO: as Small or Pointer
        return o.1 || o.2
    }
    
    @inlinable public func subtractingReportingOverflow(_ amount: Self) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount); return (pv, o)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Subtraction x Signed
//*============================================================================*

extension OBESignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static prefix func -(x: Self) -> Self {
        x.negated()
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    // TODO: consider adding to awesome protocol
    @inlinable public func negated() -> Self {
        let (pv, o) = self.negatedReportingOverflow(); precondition(!o); return pv
    }
    
    // TODO: consider adding to awesome protocol
    @inlinable public mutating func negateReportingOverflow() -> Bool {
        let wasLessThanZero = isLessThanZero
        self.formTwosComplement()
        return wasLessThanZero && isLessThanZero
    }
    
    // TODO: consider adding to awesome protocol
    @inlinable public func negatedReportingOverflow() -> PVO<Self> {
        var pv = self; let o = pv.negateReportingOverflow(); return (pv, o)
    }
}
