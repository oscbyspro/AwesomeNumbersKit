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
// MARK: * ANK x Full Width x Division
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline static func /=(lhs: inout Self, rhs: Self) {
        lhs.divideAsKnuth(by: rhs)
    }
    
    @_transparent @usableFromInline static func /(lhs: Self, rhs: Self) -> Self {
        lhs.dividedAsKnuth(by: rhs)
    }
    
    @_transparent @usableFromInline static func %=(lhs: inout Self, rhs: Self) {
        lhs.formRemainderAsKnuth(dividingBy: rhs)
    }
    
    @_transparent @usableFromInline static func %(lhs: Self, rhs: Self) -> Self {
        lhs.remainderAsKnuth(dividingBy: rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline mutating func divideReportingOverflow(by divisor: Self) -> Bool {
        self.divideReportingOverflowAsKnuth(by: divisor)
    }
    
    @_transparent @usableFromInline func dividedReportingOverflow(by  divisor: Self) -> PVO<Self> {
        self.dividedReportingOverflowAsKnuth(by: divisor)
    }
    
    @_transparent @usableFromInline mutating func formRemainderReportingOverflow(by divisor: Self) -> Bool {
        self.formRemainderReportingOverflowAsKnuth(by: divisor)
    }
    
    @_transparent @usableFromInline func remainderReportingOverflow(dividingBy  divisor: Self) -> PVO<Self> {
        self.remainderReportingOverflowAsKnuth(dividingBy: divisor)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline func quotientAndRemainder(dividingBy  divisor: Self) -> QR<Self, Self> {
        self.quotientAndRemainderAsKnuth(dividingBy: divisor)
    }
    
    @_transparent @usableFromInline func dividingFullWidth(_ dividend: HL<Self, Magnitude>) -> QR<Self, Self> {
        self.dividingFullWidthAsKnuth(dividend)
    }
}
