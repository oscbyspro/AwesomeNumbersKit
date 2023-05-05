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
// MARK: * ANK x Signed x Division x Digit
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @_transparent public static func /=(lhs: inout Self, rhs: Digit) {
        let overflow: Bool = lhs.divideReportingOverflow(by: rhs)
        precondition(!overflow)
    }
    
    @_disfavoredOverload @_transparent public static func /(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.dividedReportingOverflow(by: rhs)
        precondition(!pvo.overflow)
        return pvo.partialValue as Self
    }
    
    @_disfavoredOverload @_transparent public static func %=(lhs: inout Self, rhs: Digit) {
        let overflow: Bool = lhs.formRemainderReportingOverflow(dividingBy: rhs)
        precondition(!overflow)
    }
    
    @_disfavoredOverload @_transparent public static func %(lhs: Self, rhs: Digit) -> Digit {
        let pvo: PVO<Digit> = lhs.remainderReportingOverflow(dividingBy: rhs)
        precondition(!pvo.overflow)
        return pvo.partialValue as Digit
    }
    
    @_disfavoredOverload @_transparent public func quotientAndRemainder(dividingBy divisor: Digit) -> QR<Self, Digit> {
        let qro: PVO<QR<Self, Digit>> = self.quotientAndRemainderReportingOverflow(dividingBy: divisor)
        precondition(!qro.overflow)
        return qro.partialValue as QR<Self, Digit>
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public mutating func divideReportingOverflow(by divisor: Digit) -> Bool {
        self.sign = self.sign ^ divisor.sign
        return self.magnitude.divideReportingOverflow(by: divisor.magnitude)
    }
    
    @_disfavoredOverload @inlinable public func dividedReportingOverflow(by divisor: Digit) -> PVO<Self> {
        let pvo: PVO<Magnitude> = self.magnitude.dividedReportingOverflow(by: divisor.magnitude)
        return PVO(Self(pvo.partialValue, as: self.sign ^ divisor.sign), pvo.overflow)
    }
    
    @_disfavoredOverload @inlinable public mutating func formRemainderReportingOverflow(dividingBy divisor: Digit) -> Bool {
        self.magnitude.formRemainderReportingOverflow(dividingBy: divisor.magnitude)
    }
    
    @_disfavoredOverload @inlinable public func remainderReportingOverflow(dividingBy divisor: Digit) -> PVO<Digit> {
        let pvo: PVO<Magnitude.Digit> = self.magnitude.remainderReportingOverflow(dividingBy: divisor.magnitude)
        return PVO(Digit(pvo.partialValue, as: self.sign), pvo.overflow)
    }
    
    @_disfavoredOverload @inlinable public func quotientAndRemainderReportingOverflow(dividingBy divisor: Digit) -> PVO<QR<Self, Digit>> {
        let qro: PVO<QR<Magnitude, Magnitude.Digit>> = self.magnitude.quotientAndRemainderReportingOverflow(dividingBy: divisor.magnitude)
        return PVO(QR(Self(qro.partialValue.quotient, as: self.sign ^ divisor.sign), Digit(qro.partialValue.remainder, as: self.sign)), qro.overflow)
    }
}
