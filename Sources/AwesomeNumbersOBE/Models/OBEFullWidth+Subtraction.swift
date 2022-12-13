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
// MARK: * OBE x Full Width x Integer x Subtraction
//*============================================================================*

extension OBEFullWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func -=(lhs: inout Self, rhs: Self) {
        let o = lhs.subtractReportingOverflow(rhs); precondition(!o)
    }
    
    @inlinable static func -(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs -= rhs; return lhs
    }
    
    @inlinable static func &-=(lhs: inout Self, rhs: Self) {
        let _ = lhs.subtractReportingOverflow(rhs)
    }
    
    @inlinable static func &-(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs &-= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        let o0 = self.low .subtractReportingOverflow(amount.low )
        let o1 = self.high.subtractReportingOverflow(amount.high)
        let o2 = self.high.subtractReportingOverflow(o0 ? 1 : 0 as High) // TODO: as Small or Pointer
        return o1 || o2
    }
    
    @inlinable func subtractingReportingOverflow(_ amount: Self) -> PVO<Self> {
        // the code is duplicated because it's faster this way...
        var pv = self
        let o0 = pv.low .subtractReportingOverflow(amount.low )
        let o1 = pv.high.subtractReportingOverflow(amount.high)
        let o2 = pv.high.subtractReportingOverflow(o0 ? 1 : 0 as High) // TODO: as Small or Pointer
        return  (pv, o1 || o2)
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Integer x Unsigned x Subtraction
//*============================================================================*

extension OBEFullWidthInteger where High: SignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func -=(lhs: inout Self, rhs: Int) {
        lhs.subtract(rhs, at: 0)
    }
    
    @inlinable static func -(lhs: Self, rhs: Int) -> Self {
        lhs.subtracting(rhs, at: 0)
    }
    
    @inlinable static func &-=(lhs: inout Self, rhs: Int) {
        lhs.subtractWrappingAround(rhs, at: 0)
    }
    
    @inlinable static func &-(lhs: Self, rhs: Int) -> Self {
        lhs.subtractingWrappingAround(rhs, at: 0)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func subtract(_ amount: Int, at index: Int) {
        let o = self.subtractReportingOverflow(amount, at: index); precondition(!o)
    }
    
    @inlinable func subtracting(_ amount: Int, at index: Int) -> Self {
        var x = self; x.subtract(amount, at: index); return x
    }
    
    @inlinable mutating func subtractWrappingAround(_ amount: Int, at index: Int) {
        let _ = self.subtractReportingOverflow(amount, at: index)
    }
    
    @inlinable func subtractingWrappingAround(_ amount: Int, at index: Int) -> Self {
        var x = self; x.subtractWrappingAround(amount, at: index); return x
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func subtractReportingOverflow(_ amount: Int, at index: Int) -> Bool {
        precondition(index >= self.startIndex)
        if index >= self.endIndex { return !amount.isZero }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let lhsIsLessThanZero =   self.isLessThanZero
        let rhsIsLessThanZero = amount.isLessThanZero
        //=--------------------------------------=
        //
        //=--------------------------------------=
        var borrow = self[unchecked: index].subtractReportingOverflow(UInt(bitPattern: amount))
        var index = self.index(after: index)
        //=----------------------------------=
        //
        //=----------------------------------=
        if  borrow != rhsIsLessThanZero {
            let predicate = borrow
            let decrement = borrow ? 1 : ~0 as UInt // +1 vs -1
            
            while index != self.endIndex && borrow == predicate {
                borrow = self[unchecked: index].subtractReportingOverflow(decrement)
                self.formIndex(after: &index)
            }
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        return lhsIsLessThanZero != rhsIsLessThanZero && lhsIsLessThanZero != self.isLessThanZero
    }

    @inlinable func subtractingReportingOverflow(_ amount: Int, at index: Int) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount, at: index); return (pv, o)
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Integer x Unsigned x Subtraction
//*============================================================================*

extension OBEFullWidthInteger where High: UnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func -=(lhs: inout Self, rhs: UInt) {
        lhs.subtract(rhs, at: 0)
    }
    
    @inlinable static func -(lhs: Self, rhs: UInt) -> Self {
        lhs.subtracting(rhs, at: 0)
    }
    
    @inlinable static func &-=(lhs: inout Self, rhs: UInt) {
        lhs.subtractWrappingAround(rhs, at: 0)
    }
    
    @inlinable static func &-(lhs: Self, rhs: UInt) -> Self {
        lhs.subtractingWrappingAround(rhs, at: 0)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func subtract(_ amount: UInt, at index: Int) {
        let o = self.subtractReportingOverflow(amount, at: index); precondition(!o)
    }
    
    @inlinable func subtracting(_ amount: UInt, at index: Int) -> Self {
        var x = self; x.subtract(amount, at: index); return x
    }
    
    @inlinable mutating func subtractWrappingAround(_ amount: UInt, at index: Int) {
        let _ = self.subtractReportingOverflow(amount, at: index)
    }
    
    @inlinable func subtractingWrappingAround(_ amount: UInt, at index: Int) -> Self {
        var x = self; x.subtractWrappingAround(amount, at: index); return x
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func subtractReportingOverflow(_ amount: UInt, at index: Int) -> Bool {
        precondition(index >= self.startIndex)
        if index >= self.endIndex { return !amount.isZero }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        var borrow = self[unchecked: index].subtractReportingOverflow(amount)
        for index in self.index(after: index) ..< endIndex {
            guard borrow else { break }
            borrow = self[unchecked: index].subtractReportingOverflow(UInt(1))
        }
        
        return borrow
    }

    @inlinable func subtractingReportingOverflow(_ amount: UInt, at index: Int) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount, at: index); return (pv, o)
    }
}
