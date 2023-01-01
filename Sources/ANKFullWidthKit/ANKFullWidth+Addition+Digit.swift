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
    
    @inlinable public static func +=(lhs: inout Self, rhs: Digit) {
        precondition(!lhs.addReportingOverflow(rhs))
    }
    
    @inlinable public static func +(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.addingReportingOverflow(rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func &+=(lhs: inout Self, rhs: Digit) {
        _ = lhs.addReportingOverflow(rhs) as Bool
    }
    
    @_transparent public static func &+(lhs: Self, rhs: Digit) -> Self {
        lhs.addingReportingOverflow(rhs).partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func addReportingOverflow(_ amount: Digit) -> Bool {
        let lhsWasLessThanZero: Bool =   self.isLessThanZero
        let rhsWasLessThanZero: Bool = amount.isLessThanZero
        //=--------------------------------------=
        let carry: Bool = self.withUnsafeMutableWordsPointer { LHS in
            var index = LHS.startIndex
            var carry: Bool = LHS[index].addReportingOverflow(UInt(bitPattern: amount))
            LHS.formIndex(after: &index)
            //=----------------------------------=
            let increment = rhsWasLessThanZero ? ~0 : 1 as UInt // -1 vs +1
            //=----------------------------------=
            carrying: while carry != rhsWasLessThanZero, index != LHS.endIndex {
                carry = LHS[index].addReportingOverflow(increment)
                LHS.formIndex(after: &index)
            }
            //=----------------------------------=
            return carry as Bool
        }
        //=--------------------------------------=
        if !Self.isSigned { return carry }
        if lhsWasLessThanZero != rhsWasLessThanZero { return false }
        return lhsWasLessThanZero != self.isLessThanZero
    }
    
    @inlinable public func addingReportingOverflow(_ amount: Digit) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.addReportingOverflow(amount)
        return PVO(partialValue, overflow)
    }
}
