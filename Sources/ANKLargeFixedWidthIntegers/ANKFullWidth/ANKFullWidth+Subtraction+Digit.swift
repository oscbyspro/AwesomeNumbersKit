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
    
    @inlinable static func -=(lhs: inout Self, rhs: Digit) {
        let o = lhs.subtractReportingOverflow(rhs); precondition(!o)
    }
    
    @inlinable static func -(lhs: Self, rhs: Digit) -> Self {
        let (pv, o) = lhs.subtractingReportingOverflow(rhs); precondition(!o); return pv
    }
    
    @inlinable static func &-=(lhs: inout Self, rhs: Digit) {
        let _ = lhs.subtractReportingOverflow(rhs)
    }
    
    @inlinable static func &-(lhs: Self, rhs: Digit) -> Self {
        let (pv, _) = lhs.subtractingReportingOverflow(rhs); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func subtractReportingOverflow(_ amount: Digit) -> Bool {
        let lhsWasLessThanZero: Bool =   self.isLessThanZero
        let rhsWasLessThanZero: Bool = amount.isLessThanZero
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let borrow: Bool = self.withUnsafeMutableWords { LHS in
            var index:  Int  = LHS.startIndex
            var borrow: Bool = LHS[index].subtractReportingOverflow(UInt(bitPattern: amount))
            LHS.formIndex(after: &index)
            //=----------------------------------=
            //
            //=----------------------------------=
            if  borrow == rhsWasLessThanZero { return false }
            let predicate: Bool = borrow
            let decrement: UInt = borrow ? 1 : ~0 // +1 vs -1

            while borrow == predicate && index != LHS.endIndex {
                borrow = LHS[index].subtractReportingOverflow(decrement)
                LHS.formIndex(after: &index)
            }
            
            return borrow as Bool
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if !Self.isSigned { return borrow }
        let notSameSign = lhsWasLessThanZero != rhsWasLessThanZero
        return notSameSign && lhsWasLessThanZero != isLessThanZero
    }
    
    @inlinable func subtractingReportingOverflow(_ amount: Digit) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount); return (pv, o)
    }
}
