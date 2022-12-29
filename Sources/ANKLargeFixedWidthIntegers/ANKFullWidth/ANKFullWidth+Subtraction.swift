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
// MARK: * ANK x Full Width x Subtraction
//*============================================================================*

extension _ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func -=(lhs: inout Self, rhs: Self) {
        precondition(!lhs.subtractReportingOverflow(rhs))
    }
    
    @inlinable static func -(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.subtractingReportingOverflow(rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func &-=(lhs: inout Self, rhs: Self) {
        _ = lhs.subtractReportingOverflow(rhs) as Bool
    }
    
    @inlinable static func &-(lhs: Self, rhs: Self) -> Self {
        lhs.subtractingReportingOverflow(rhs).partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        let a: Bool = self.low .subtractReportingOverflow(amount.low )
        let b: Bool = self.high.subtractReportingOverflow(amount.high)
        let c: Bool = a && self.high.subtractReportingOverflow(1 as Digit)
        return b || c
    }
    
    @inlinable func subtractingReportingOverflow(_ amount: Self) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.subtractReportingOverflow(amount)
        return PVO(partialValue, overflow)
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Subtraction x Digit
//*============================================================================*

extension _ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func -=(lhs: inout Self, rhs: Digit) {
        precondition(!lhs.subtractReportingOverflow(rhs))
    }
    
    @inlinable static func -(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.subtractingReportingOverflow(rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func &-=(lhs: inout Self, rhs: Digit) {
        _ = lhs.subtractReportingOverflow(rhs) as Bool
    }
    
    @inlinable static func &-(lhs: Self, rhs: Digit) -> Self {
        lhs.subtractingReportingOverflow(rhs).partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func subtractReportingOverflow(_ amount: Digit) -> Bool {
        let lhsWasLessThanZero: Bool =   self.isLessThanZero
        let rhsWasLessThanZero: Bool = amount.isLessThanZero
        //=--------------------------------------=
        let borrow: Bool = self.withUnsafeMutableWords { LHS in
            var index = LHS.startIndex
            var borrow: Bool = LHS[unchecked: index].subtractReportingOverflow(UInt(bitPattern: amount))
            LHS.formIndex(after: &index)
            //=----------------------------------=
            if borrow == rhsWasLessThanZero { return false }
            //=----------------------------------=
            let decrement = rhsWasLessThanZero ? ~0 : 1 as UInt
            while borrow != rhsWasLessThanZero, index != LHS.endIndex {
                borrow = LHS[unchecked: index].subtractReportingOverflow(decrement)
                LHS.formIndex(after:   &index)
            }
            
            return borrow as Bool
        }
        //=--------------------------------------=
        if !Self.isSigned { return borrow }
        if lhsWasLessThanZero == rhsWasLessThanZero { return false }
        return lhsWasLessThanZero != self.isLessThanZero
    }
    
    @inlinable func subtractingReportingOverflow(_ amount: Digit) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.subtractReportingOverflow(amount)
        return PVO(partialValue, overflow)
    }
}
