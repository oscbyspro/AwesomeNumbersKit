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
        precondition(!lhs.addReportingOverflow(rhs))
    }
    
    @inlinable static func +(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.addingReportingOverflow(rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    @inlinable static func &+=(lhs: inout Self, rhs: Digit) {
        _ = lhs.addReportingOverflow(rhs)
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
            var index: Int  = LHS.startIndex
            var carry: Bool = LHS[unchecked: index].addReportingOverflow(UInt(bitPattern: amount))
            LHS.formIndex(after: &index)
            //=----------------------------------=
            // Propagate Carry Digit By Digit
            //=----------------------------------=
            if  carry    == rhsWasLessThanZero { return false }
            let increment = rhsWasLessThanZero ? ~0 : 1 as UInt // -1 vs +1
            while carry  != rhsWasLessThanZero && index != LHS.endIndex {
                carry = LHS[unchecked: index].addReportingOverflow(increment)
                LHS.formIndex(after:  &index)
            }
            
            return carry as Bool
        }
        //=--------------------------------------=
        if  !Self.isSigned {  return carry }
        let    hadSameSign =  lhsWasLessThanZero ==  rhsWasLessThanZero
        return hadSameSign && lhsWasLessThanZero != self.isLessThanZero
    }
    
    @inlinable func addingReportingOverflow(_ amount: Digit) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.addReportingOverflow(amount)
        return PVO(partialValue, overflow)
    }
}
