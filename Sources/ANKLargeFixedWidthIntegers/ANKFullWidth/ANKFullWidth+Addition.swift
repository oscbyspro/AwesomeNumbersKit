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
// MARK: * ANK x Full Width x Addition
//*============================================================================*

extension _ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func +=(lhs: inout Self, rhs: Self) {
        precondition(!lhs.addReportingOverflow(rhs))
    }
    
    @inlinable static func +(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.addingReportingOverflow(rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func &+=(lhs: inout Self, rhs: Self) {
        _ = lhs.addReportingOverflow(rhs) as Bool
    }
    
    @inlinable static func &+(lhs: Self, rhs: Self) -> Self {
        lhs.addingReportingOverflow(rhs).partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addReportingOverflow(_ amount: Self) -> Bool {
        let a: Bool = self.low .addReportingOverflow(amount.low )
        let b: Bool = self.high.addReportingOverflow(amount.high)
        let c: Bool = a && self.high.addReportingOverflow(1 as Digit)
        return b || c
    }
    
    @inlinable func addingReportingOverflow(_ amount: Self) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.addReportingOverflow(amount)
        return PVO(partialValue, overflow)        
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Addition x Digit
//*============================================================================*

extension _ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func +=(lhs: inout Self, rhs: Digit) {
        precondition(!lhs.addReportingOverflow(rhs))
    }
    
    @inlinable static func +(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.addingReportingOverflow(rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func &+=(lhs: inout Self, rhs: Digit) {
        _ = lhs.addReportingOverflow(rhs) as Bool
    }
    
    @inlinable static func &+(lhs: Self, rhs: Digit) -> Self {
        lhs.addingReportingOverflow(rhs).partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addReportingOverflow(_ amount: Digit) -> Bool {
        let lhsWasLessThanZero: Bool =   self.isLessThanZero
        let rhsWasLessThanZero: Bool = amount.isLessThanZero
        //=--------------------------------------=
        let carry: Bool = self.withUnsafeMutableWords { LHS in
            var index = LHS.startIndex
            var carry: Bool = LHS[unchecked: index].addReportingOverflow(UInt(bitPattern: amount))
            LHS.formIndex(after: &index)
            //=----------------------------------=
            if carry == rhsWasLessThanZero { return false }
            //=----------------------------------=
            let increment = rhsWasLessThanZero ? ~0 : 1 as UInt
            while carry  != rhsWasLessThanZero, index != LHS.endIndex {
                carry = LHS[unchecked: index].addReportingOverflow(increment)
                LHS.formIndex(after:  &index)
            }
            
            return carry as Bool
        }
        //=--------------------------------------=
        if !Self.isSigned { return carry }
        if lhsWasLessThanZero != rhsWasLessThanZero { return false }
        return lhsWasLessThanZero != self.isLessThanZero
    }
    
    @inlinable func addingReportingOverflow(_ amount: Digit) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.addReportingOverflow(amount)
        return PVO(partialValue, overflow)
    }
}
