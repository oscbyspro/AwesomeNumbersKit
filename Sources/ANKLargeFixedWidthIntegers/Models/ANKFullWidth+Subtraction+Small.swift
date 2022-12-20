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
// MARK: * ANK x Full Width x Signed x Subtraction x Small
//*============================================================================*

extension ANKFullWidth where Self: SignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func -=(lhs: inout Self, rhs: Int) {
        let o = lhs.subtractReportingOverflow(rhs); precondition(!o)
    }
    
    @inlinable static func -(lhs: Self, rhs: Int) -> Self {
        let (pv, o) = lhs.subtractingReportingOverflow(rhs); precondition(!o); return pv
    }
    
    @inlinable static func &-=(lhs: inout Self, rhs: Int) {
        let _ = lhs.subtractReportingOverflow(rhs)
    }
    
    @inlinable static func &-(lhs: Self, rhs: Int) -> Self {
        let (pv, _) = lhs.subtractingReportingOverflow(rhs); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func subtractReportingOverflow(_ amount: Int) -> Bool {
        let lhsWasLessThanZero =   self.isLessThanZero
        let rhsWasLessThanZero = amount.isLessThanZero
        //=--------------------------------------=
        //
        //=--------------------------------------=
        self.withUnsafeMutableWords { LHS in
            var index  = LHS.startIndex
            var borrow = LHS[index].subtractReportingOverflow(UInt(bitPattern: amount))
            LHS.formIndex(after: &index)
            //=----------------------------------=
            //
            //=----------------------------------=
            if  borrow == rhsWasLessThanZero { return }
            let predicate = borrow
            let decrement = borrow ? 1 : ~0 as UInt // +1 vs -1

            while borrow == predicate && index != LHS.endIndex {
                borrow = LHS[index].subtractReportingOverflow(decrement)
                LHS.formIndex(after: &index)
            }
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        return lhsWasLessThanZero != rhsWasLessThanZero && lhsWasLessThanZero != isLessThanZero
    }
    
    @inlinable func subtractingReportingOverflow(_ amount: Int) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount); return (pv, o)
    }
}


//*============================================================================*
// MARK: * ANK x Full Width x Subtraction x Addition x Small
//*============================================================================*

extension ANKFullWidth where Self: UnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func -=(lhs: inout Self, rhs: UInt) {
        let o = lhs.subtractReportingOverflow(rhs); precondition(!o)
    }
    
    @inlinable static func -(lhs: Self, rhs: UInt) -> Self {
        let (pv, o) = lhs.subtractingReportingOverflow(rhs); precondition(!o); return pv
    }
    
    @inlinable static func &-=(lhs: inout Self, rhs: UInt) {
        let _ = lhs.subtractReportingOverflow(rhs)
    }
    
    @inlinable static func &-(lhs: Self, rhs: UInt) -> Self {
        let (pv, _) = lhs.subtractingReportingOverflow(rhs); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func subtractReportingOverflow(_ amount: UInt) -> Bool {
        self.withUnsafeMutableWords { LHS in
            var index  = LHS.startIndex
            var borrow = LHS[index].subtractReportingOverflow(amount)
            LHS.formIndex(after: &index)
            
            while borrow && index != LHS.endIndex {
                borrow = LHS[index].subtractReportingOverflow(1 as UInt)
                LHS.formIndex(after: &index)
            }
            
            return borrow
        }
    }
    
    @inlinable func subtractingReportingOverflow(_ amount: UInt) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount); return (pv, o)
    }
}
