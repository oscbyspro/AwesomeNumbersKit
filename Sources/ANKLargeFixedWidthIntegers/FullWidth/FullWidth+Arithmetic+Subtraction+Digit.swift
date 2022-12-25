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
        precondition(!lhs.subtractReportingOverflow(rhs))
    }
    
    @inlinable static func -(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.subtractingReportingOverflow(rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    @inlinable static func &-=(lhs: inout Self, rhs: Digit) {
        _ = lhs.subtractReportingOverflow(rhs)
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
            var index:  Int  = LHS.startIndex
            var borrow: Bool = LHS[unchecked: index].subtractReportingOverflow(UInt(bitPattern: amount))
            LHS.formIndex(after: &index)
            //=----------------------------------=
            if borrow == rhsWasLessThanZero { return false }
            //=----------------------------------=
            let decrement: UInt = rhsWasLessThanZero ? ~0 : 1 // -1 vs +1
            loop: while borrow != rhsWasLessThanZero, index != LHS.endIndex {
                borrow = LHS[unchecked: index].subtractReportingOverflow(decrement)
                LHS.formIndex(after:   &index)
            }
            
            return borrow as Bool
        }
        //=--------------------------------------=
        if !Self.isSigned { return borrow }
        let notSameSign: Bool = lhsWasLessThanZero !=  rhsWasLessThanZero
        return notSameSign &&   lhsWasLessThanZero != self.isLessThanZero
    }
    
    @inlinable func subtractingReportingOverflow(_ amount: Digit) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.subtractReportingOverflow(amount)
        return PVO(partialValue, overflow)
    }
}
