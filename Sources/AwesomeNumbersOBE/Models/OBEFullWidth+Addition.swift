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
// MARK: * OBE x Full Width x Integer x Addition
//*============================================================================*

extension OBEFullWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func +=(lhs: inout Self, rhs: Self) {
        let o = lhs.addReportingOverflow(rhs); precondition(!o)
    }
    
    @inlinable static func +(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs += rhs; return lhs
    }
    
    @inlinable static func &+=(lhs: inout Self, rhs: Self) {
        let _ = lhs.addReportingOverflow(rhs)
    }
    
    @inlinable static func &+(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs &+= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addReportingOverflow(_ amount: Self) -> Bool {
        let o0 = self.low .addReportingOverflow(amount.low )
        let o1 = self.high.addReportingOverflow(amount.high)
        let o2 = self.high.addReportingOverflow(o0 ? 1 : 0 as High) // TODO: as Small or Pointer
        return o1 || o2
    }
    
    @inlinable func addingReportingOverflow(_ amount: Self) -> PVO<Self> {
        // the code is duplicated because it's faster this way...
        var pv = self
        let o0 = pv.low .addReportingOverflow(amount.low )
        let o1 = pv.high.addReportingOverflow(amount.high)
        let o2 = pv.high.addReportingOverflow(o0 ? 1 : 0 as High) // TODO: as Small or Pointer
        return  (pv, o1 || o2)
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Integer x Signed x Addition
//*============================================================================*

extension OBEFullWidthInteger where High: SignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func +=(lhs: inout Self, rhs: Int) {
        lhs.add(rhs)
    }
    
    @inlinable static func +(lhs: Self, rhs: Int) -> Self {
        lhs.adding(rhs)
    }
    
    @inlinable static func &+=(lhs: inout Self, rhs: Int) {
        lhs.addWrappingAround(rhs)
    }
    
    @inlinable static func &+(lhs: Self, rhs: Int) -> Self {
        lhs.addingWrappingAround(rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func add(_ amount: Int, at index: Int = 0) {
        let o = self.addReportingOverflow(amount, at: index); precondition(!o)
    }
    
    @inlinable func adding(_ amount: Int, at index: Int = 0) -> Self {
        var x = self; x.add(amount, at: index); return x
    }
    
    @inlinable mutating func addWrappingAround(_ amount: Int, at index: Int = 0) {
        let _ = self.addReportingOverflow(amount, at: index)
    }
    
    @inlinable func addingWrappingAround(_ amount: Int, at index: Int = 0) -> Self {
        var x = self; x.addWrappingAround(amount, at: index); return x
    }
    
    @inlinable mutating func addReportingOverflow(_ amount: Int, at index: Int = 0) -> Bool {
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
        var carry = self[unchecked: index].addReportingOverflow(UInt(bitPattern: amount))
        var index = self.index(after: index)
        
        if  carry != rhsIsLessThanZero {
            let predicate = carry
            let increment = carry ? 1 : ~0 as UInt // +1 vs -1

            while index != self.endIndex && carry == predicate {
                carry = self[index].addReportingOverflow(increment)
                self.formIndex(after: &index)
            }
        }
        
        return lhsIsLessThanZero == rhsIsLessThanZero && lhsIsLessThanZero != self.isLessThanZero
    }
    
    @inlinable func addingReportingOverflow(_ amount: Int, at index: Int = 0) -> PVO<Self> {
        var pv = self; let o = pv.addReportingOverflow(amount, at: index); return (pv, o)
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Integer x Unsigned x Addition
//*============================================================================*

extension OBEFullWidthInteger where High: UnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func +=(lhs: inout Self, rhs: UInt) {
        lhs.add(rhs)
    }
    
    @inlinable static func +(lhs: Self, rhs: UInt) -> Self {
        lhs.adding(rhs)
    }
    
    @inlinable static func &+=(lhs: inout Self, rhs: UInt) {
        lhs.addWrappingAround(rhs)
    }
    
    @inlinable static func &+(lhs: Self, rhs: UInt) -> Self {
        lhs.addingWrappingAround(rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func add(_ amount: UInt, at index: Int = 0) {
        let o = self.addReportingOverflow(amount, at: index); precondition(!o)
    }
    
    @inlinable func adding(_ amount: UInt, at index: Int = 0) -> Self {
        var x = self; x.add(amount, at: index); return x
    }
    
    @inlinable mutating func addWrappingAround(_ amount: UInt, at index: Int = 0) {
        let _ = self.addReportingOverflow(amount, at: index)
    }
    
    @inlinable func addingWrappingAround(_ amount: UInt, at index: Int = 0) -> Self {
        var x = self; x.addWrappingAround(amount, at: index); return x
    }
    
    @inlinable mutating func addReportingOverflow(_ amount: UInt, at index: Int = 0) -> Bool {
        precondition(index >= self.startIndex)
        if index >= self.endIndex { return !amount.isZero }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        var carry = self[unchecked: index].addReportingOverflow(amount)
        
        for index in self.index(after: index) ..< self.endIndex {
            guard carry else { break }
            carry = self[unchecked: index].addReportingOverflow(1 as UInt)
        }
        
        return carry
    }
    
    @inlinable func addingReportingOverflow(_ amount: UInt, at index: Int = 0) -> PVO<Self> {
        var pv = self; let o = pv.addReportingOverflow(amount, at: index); return (pv, o)
    }
}
