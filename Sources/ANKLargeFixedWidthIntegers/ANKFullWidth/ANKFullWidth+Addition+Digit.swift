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
// MARK: * ANK x Full Width x Addition x Digit
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func +=(lhs: inout Self, rhs: Digit) {
        let o = lhs.addReportingOverflow(rhs); precondition(!o)
    }
    
    @inlinable static func +(lhs: Self, rhs: Digit) -> Self {
        let (pv, o) = lhs.addingReportingOverflow(rhs); precondition(!o); return pv
    }
    
    @inlinable static func &+=(lhs: inout Self, rhs: Digit) {
        let _ = lhs.addReportingOverflow(rhs)
    }
    
    @inlinable static func &+(lhs: Self, rhs: Digit) -> Self {
        let (pv, _) = lhs.addingReportingOverflow(rhs); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addReportingOverflow(_ amount: Digit) -> Bool {
        let lhsWasLessThanZero: Bool =   self.isLessThanZero
        let rhsWasLessThanZero: Bool = amount.isLessThanZero
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let carry: Bool = self.withUnsafeMutableWords { LHS in
            var index: Int  = LHS.startIndex
            var carry: Bool = LHS[index].addReportingOverflow(UInt(bitPattern: amount))
            LHS.formIndex(after: &index)
            //=----------------------------------=
            //
            //=----------------------------------=
            if  carry == rhsWasLessThanZero { return false }
            let predicate: Bool = carry
            let increment: UInt = carry ? 1 : ~0 // +1 vs -1

            while carry == predicate && index != LHS.endIndex {
                carry = LHS[index].addReportingOverflow(increment)
                LHS.formIndex(after: &index)
            }
            
            return carry as Bool
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if !Self.isSigned { return carry }
        let hadSameSign = lhsWasLessThanZero == rhsWasLessThanZero
        return hadSameSign && lhsWasLessThanZero != isLessThanZero
    }
    
    @inlinable func addingReportingOverflow(_ amount: Digit) -> PVO<Self> {
        var pv = self; let o = pv.addReportingOverflow(amount); return (pv, o)
    }
}
