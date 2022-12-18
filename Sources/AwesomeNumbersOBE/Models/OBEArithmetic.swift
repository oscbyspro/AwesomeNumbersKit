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
// MARK: * OBE x UInt x Arithmetic
//*============================================================================*

extension UInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addReportingOverflow(_ amount: Self, _ carry: Bool) -> Bool {
        let a = self.addReportingOverflow(amount)
        let b = self.addReportingOverflow(carry ? 1 : 0)
        return  a || b
    }
    
    @inlinable func addingReportingOverflow(_ amount: Self, _ carry: Bool) -> PVO<Self> {
        var pv = self; let o = pv.addReportingOverflow(amount, carry); return PVO(pv,o)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
        
    @inlinable mutating func subtractReportingOverflow(_ amount: Self, _ borrow: Bool) -> Bool {
        let a = self.subtractReportingOverflow(amount)
        let b = self.subtractReportingOverflow(borrow ? 1 : 0)
        return  a || b
    }
    
    @inlinable func subtractingReportingOverflow(_ amount: Self, _ borrow: Bool) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount, borrow); return PVO(pv,o)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addFullWidth(multiplicands: (Self, Self)) -> Self {
        // it cannot crash for the same reason that 9 + 9 * 9 == 90
        let (upper, lower) = multiplicands.0.multipliedFullWidth(by: multiplicands.1)
        return self.addReportingOverflow(lower) ? upper &+ 1 : upper
    }
    
    @inlinable func addingFullWidth(multiplicands: (Self, Self)) -> HL<Self, Self> {
        var low = self; let high = low.addFullWidth(multiplicands: multiplicands); return (high, low)
    }
    
    @inlinable mutating func addFullWidth(_ carry: Self, multiplicands: (Self, Self)) -> Self {
        // it cannot crash for the same reason that 9 + 9 + 9 * 9 == 99
        let upper = self.addFullWidth(multiplicands: multiplicands)
        return self.addReportingOverflow(carry) ? upper &+ 1 : upper
    }
    
    @inlinable func addingFullWidth(_ carry: Self,  multiplicands: (Self, Self)) -> HL<Self, Self> {
        var low = self; let high = low.addFullWidth(carry, multiplicands: multiplicands); return (high, low)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Division
    //=------------------------------------------------------------------------=
    
    /// - The quotient is overapproximated by at most one.
    /// - The divisor's most significant bit must be set (clamping the error range).
    @inlinable static func approximateQuotientAsKnuth(dividing x: (Self, Self, Self), by y: (Self, Self)) -> Self {
        precondition(y.0.mostSignificantBit, "divisor < max / 2")
        //=--------------------------------------=
        //
        //=--------------------------------------=
        var q: Self
        var r: Self
        var o: Bool
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  x.0 == y.0 {
            q = max
            (r, o) = x.0.addingReportingOverflow(x.1)
            if (o) { return q }
        
        } else {
            
            (q, r) = y.0.dividingFullWidth((x.0, x.1))
        }
        //=--------------------------------------=
        // q * y - x <= 2
        //=--------------------------------------=
        var (a,  b) = q.multipliedFullWidth(by: y.1)
        if  (a < r) || (a == r && b  <= x.2) { return q }
        
        (r,  o) = r.addingReportingOverflow(y.0)
        if  (o) { return q - 1 }
        
        (b,  o) = b.subtractingReportingOverflow(y.1)
        (a,  o) = a.subtractingReportingOverflow(o  ? 1 : 0 )
        if  (a  < r) || (a == r && b <= x.2) { return q - 1 }
        
        return q - 2
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width x Unsigned x Arithmetic
//*============================================================================*

extension FixedWidthInteger where Self: UnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func sum(_ x0: Self, _ x1: Self, _ x2: Self) -> HL<Self, Self> {
        let (x3, o3) = x0.addingReportingOverflow(x1)
        let (x4, o4) = x3.addingReportingOverflow(x2)
        let (x5) = o3 && o4 ? 2 : o3 || o4 ? 1 : 0 as Self
        return (x5, x4)
    }
}
