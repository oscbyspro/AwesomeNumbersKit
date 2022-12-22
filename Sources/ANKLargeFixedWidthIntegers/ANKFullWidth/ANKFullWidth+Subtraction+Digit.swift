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
// MARK: * ANK x Full Width x Subtraction x Digit
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func -=(lhs: inout Self, rhs: Self.Digit) {
        let o = lhs.subtractReportingOverflow(rhs); precondition(!o)
    }
    
    @inlinable static func -(lhs: Self, rhs: Self.Digit) -> Self {
        let (pv, o) = lhs.subtractingReportingOverflow(rhs); precondition(!o); return pv
    }
    
    @inlinable static func &-=(lhs: inout Self, rhs: Self.Digit) {
        let _ = lhs.subtractReportingOverflow(rhs)
    }
    
    @inlinable static func &-(lhs: Self, rhs: Self.Digit) -> Self {
        let (pv, _) = lhs.subtractingReportingOverflow(rhs); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func subtractReportingOverflow(_ amount: Self.Digit) -> Bool {
        let lhsWasLessThanZero: Bool =   self.isLessThanZero
        let rhsWasLessThanZero: Bool = amount.isLessThanZero
        //=--------------------------------------=
        let borrow: Bool = self.withUnsafeMutableWords { LHS in
            var index:  Int  = LHS.startIndex
            var borrow: Bool = LHS[unchecked: index].subtractReportingOverflow(UInt(bitPattern: amount))
            LHS.formIndex(after: &index)
            //=----------------------------------=
            // Propagate Borrow Digit By Digit
            //=----------------------------------=
            if  borrow   == rhsWasLessThanZero { return false }
            let decrement = rhsWasLessThanZero ? ~0 : 1 as UInt  // -1 vs +1
            while borrow != rhsWasLessThanZero && index != LHS.endIndex {
                borrow = LHS[unchecked: index].subtractReportingOverflow(decrement)
                LHS.formIndex(after:   &index)
            }
            
            return borrow as Bool
        }
        //=--------------------------------------=
        if  !Self.isSigned { return borrow }
        let    notSameSign =  lhsWasLessThanZero !=  rhsWasLessThanZero
        return notSameSign && lhsWasLessThanZero != self.isLessThanZero
    }
    
    @inlinable func subtractingReportingOverflow(_ amount: Self.Digit) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount); return (pv, o)
    }
}