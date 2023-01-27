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

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func -=(lhs: inout Self, rhs: Self) {
        let overflow: Bool = lhs.subtractReportingOverflow(rhs)
        precondition(!overflow)
    }
    
    @inlinable public static func -(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.subtractingReportingOverflow(rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func &-=(lhs: inout Self, rhs: Self) {
        _ = lhs.subtractReportingOverflow(rhs) as Bool
    }
    
    @_transparent public static func &-(lhs: Self, rhs: Self) -> Self {
        lhs.subtractingReportingOverflow(rhs).partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        let a: Bool = self.low .subtractReportingOverflow(amount.low )
        let b: Bool = self.high.subtractReportingOverflow(amount.high)
        let c: Bool = a && self.high.subtractReportingOverflow(1 as Digit)
        return b || c
    }
    
    @inlinable public func subtractingReportingOverflow(_ amount: Self) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.subtractReportingOverflow(amount)
        return PVO(partialValue, overflow)
    }
}
