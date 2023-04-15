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
    
    @_disfavoredOverload @inlinable public static func /=(lhs: inout Self, rhs: Digit) {
        let overflow: Bool = lhs.divideReportingOverflow(by: rhs)
        precondition(!overflow)
    }
    
    @_disfavoredOverload @inlinable public static func /(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.dividedReportingOverflow(by: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    @_disfavoredOverload @inlinable public static func %=(lhs: inout Self, rhs: Digit) {
        let overflow: Bool = lhs.formRemainderReportingOverflow(dividingBy: rhs)
        precondition(!overflow)
    }
    
    @_disfavoredOverload @inlinable public static func %(lhs: Self, rhs: Digit) -> Digit {
        let pvo: PVO<Digit> = lhs.remainderReportingOverflow(dividingBy: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public mutating func divideReportingOverflow(by divisor: Digit) -> Bool {
        let pvo: PVO<Self> = self.dividedReportingOverflow(by: divisor)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_disfavoredOverload @inlinable public func dividedReportingOverflow(by divisor: Digit) -> PVO<Self> {
        //=--------------------------------------=
        if  divisor.isZero {
            return PVO(self, true)
        }
        //=--------------------------------------=
        if  Self.isSigned, divisor == (-1 as Digit), self == Self.min {
            return PVO(self, true)
        }
        //=--------------------------------------=
        let qr: QR<Self, Digit> = self.quotientAndRemainder(dividingBy: divisor)
        return PVO(qr.quotient, false)
    }
    
    @_disfavoredOverload @inlinable public mutating func formRemainderReportingOverflow(dividingBy divisor: Digit) -> Bool {
        let pvo: PVO<Digit> = self.remainderReportingOverflow(dividingBy: divisor)
        self = Self(digit: pvo.partialValue); return pvo.overflow
    }
    
    @_disfavoredOverload @inlinable public func remainderReportingOverflow(dividingBy divisor: Digit) -> PVO<Digit> {
        //=--------------------------------------=
        if  divisor.isZero {
            return PVO(Digit(), true)
        }
        //=--------------------------------------=
        if  Self.isSigned, divisor == (-1 as Digit), self == Self.min {
            return PVO(Digit(), true)
        }
        //=--------------------------------------=
        let qr: QR<Self, Digit> = self.quotientAndRemainder(dividingBy: divisor)
        return PVO(qr.remainder, false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public func quotientAndRemainder(dividingBy divisor: Digit) -> QR<Self, Digit> {
        let dividendIsLessThanZero: Bool =    self.isLessThanZero
        let  divisorIsLessThanZero: Bool = divisor.isLessThanZero
        //=--------------------------------------=
        var qr: QR<Magnitude, UInt> = self.magnitude._quotientAndRemainderAsUnsigned(dividingBy: divisor.magnitude)
        //=--------------------------------------=
        if  dividendIsLessThanZero != divisorIsLessThanZero {
            let overflow = qr.quotient._negateReportingOverflowAsSigned()
            precondition(!overflow, "quotient overflowed during division")
        }
        
        if  dividendIsLessThanZero {
            qr.remainder.formTwosComplement()
        }
        //=--------------------------------------=
        return QR(Self(bitPattern: qr.quotient), Digit(bitPattern: qr.remainder))
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func _quotientAndRemainderAsUnsigned(dividingBy divisor: Digit) -> QR<Self, Digit> {
        var quotient  = self
        let remainder = quotient._formQuotientReportingRemainderAsUnsigned(dividingBy: divisor)
        return QR(quotient, remainder)
    }
    
    @inlinable mutating func _formQuotientReportingRemainderAsUnsigned(dividingBy divisor: Digit) -> Digit {
        precondition(!divisor.isZero)
        //=--------------------------------------=
        var remainder = UInt()
        //=--------------------------------------=
        self.withUnsafeMutableWords { SELF in
            var index: Int = SELF.endIndex
            backwards: while index != SELF.startIndex {
                (SELF.formIndex(before: &index))
                (SELF[index], remainder) = divisor.dividingFullWidth(HL(remainder, SELF[index]))
            }
        }
        //=--------------------------------------=
        return remainder
    }
}
