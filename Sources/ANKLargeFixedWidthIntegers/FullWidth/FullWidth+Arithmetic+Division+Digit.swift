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
// MARK: * ANK x Full Width x Division x Digit
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func /=(lhs: inout Self, rhs: Digit) {
        precondition(!lhs.divideReportingOverflow(by: rhs))
    }
    
    @inlinable static func /(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.dividedReportingOverflow(by: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    @inlinable static func %=(lhs: inout Self, rhs: Digit) {
         precondition(!lhs.formRemainderReportingOverflow(by: rhs))
    }
    
    @inlinable static func %(lhs: Self, rhs: Digit) -> Digit {
        let pvo: PVO<Digit> = lhs.remainderReportingOverflow(dividingBy: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func divideReportingOverflow(by divisor: Digit) -> Bool {
        let pvo: PVO<Self> = self.dividedReportingOverflow(by: divisor)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable func dividedReportingOverflow(by divisor: Digit) -> PVO<Self> {
        //=--------------------------------------=
        if  divisor.isZero {
            return PVO(self, true)
        }
        //=--------------------------------------=
        if  Self.isSigned, divisor == -1, self == Self.min {
            return PVO(self, true)
        }
        //=--------------------------------------=
        let qr: QR<Self, Digit> = self.quotientAndRemainder(dividingBy: divisor)
        return PVO(qr.quotient, false)
    }
    
    @inlinable mutating func formRemainderReportingOverflow(by divisor: Digit) -> Bool {
        let pvo: PVO<Digit> = self.remainderReportingOverflow(dividingBy: divisor)
        self = Self(digit: pvo.partialValue); return pvo.overflow
    }
    
    // TODO: decide appropriate digit division overflow semantics
    @inlinable func remainderReportingOverflow(dividingBy divisor: Digit) -> PVO<Digit> {
        //=--------------------------------------=
        if  divisor.isZero {
            return PVO(0, true)
        }
        //=--------------------------------------=
        if  Self.isSigned, divisor == -1, self == Self.min {
            return PVO(0, true)
        }
        //=--------------------------------------=
        let qr: QR<Self, Digit> = self.quotientAndRemainder(dividingBy: divisor)
        return PVO(qr.remainder, false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func quotientAndRemainder(dividingBy divisor: Digit) -> QR<Self, Digit> {
        let  divisorIsLessThanZero: Bool = divisor.isLessThanZero
        let dividendIsLessThanZero: Bool =    self.isLessThanZero
        //=--------------------------------------=
        var qr: QR<Magnitude, UInt> = self.magnitude.quotientAndRemainder(dividingBy: divisor.magnitude)
        //=--------------------------------------=
        if  dividendIsLessThanZero != divisorIsLessThanZero {
            let overflow: Bool = qr.quotient.formTwosComplementReportingOverflow()
            precondition(!overflow, "quotient overflow during division")
        }
        
        if  dividendIsLessThanZero {
            qr.remainder = ~qr.remainder &+ 1 // cannot overflow: abs <= max
        }
        //=--------------------------------------=
        return QR(Self(bitPattern: qr.quotient), Digit(bitPattern: qr.remainder))
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Unsigned x Division x Digit
//*============================================================================*

extension ANKFullWidth where Self: AwesomeUnsignedLargeFixedWidthInteger {
 
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func quotientAndRemainder(dividingBy divisor: Digit) -> QR<Self, Digit> {
        precondition(!divisor.isZero)
        //=--------------------------------------=
        var quotient  = self
        var remainder = UInt()
        //=--------------------------------------=
        quotient.withUnsafeMutableWords { QUOTIENT in
            var quotientIndex: Int = QUOTIENT.endIndex
            //=----------------------------------=
            backwards: while quotientIndex != QUOTIENT.startIndex {
                QUOTIENT.formIndex(before: &quotientIndex)
                let dividend: (UInt, UInt) = (remainder, QUOTIENT[unchecked: quotientIndex])
                (QUOTIENT[unchecked: quotientIndex], remainder) = divisor.dividingFullWidth(dividend)
            }
        }
        //=--------------------------------------=
        return QR(quotient, remainder)
    }
}
