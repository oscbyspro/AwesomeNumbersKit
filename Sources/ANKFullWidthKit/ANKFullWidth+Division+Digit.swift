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
    
    @_disfavoredOverload @_transparent public mutating func divideReportingOverflow(by divisor: Digit) -> Bool {
        let pvo: PVO<Self> = self.dividedReportingOverflow(by: divisor)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @_disfavoredOverload @_transparent public func dividedReportingOverflow(by divisor: Digit) -> PVO<Self> {
        let qro: PVO<QR<Self, Digit>> = self.quotientAndRemainderReportingOverflow(dividingBy: divisor)
        return   PVO(qro.partialValue.quotient, qro.overflow)
    }
    
    @_disfavoredOverload @_transparent public mutating func formRemainderReportingOverflow(dividingBy divisor: Digit) -> Bool {
        let pvo: PVO<Digit> = self.remainderReportingOverflow(dividingBy: divisor)
        self = Self(digit: pvo.partialValue)
        return pvo.overflow as Bool
    }
    
    @_disfavoredOverload @_transparent public func remainderReportingOverflow(dividingBy divisor: Digit) -> PVO<Digit> {
        let qro: PVO<QR<Self, Digit>> = self.quotientAndRemainderReportingOverflow(dividingBy: divisor)
        return   PVO(qro.partialValue.remainder, qro.overflow)
    }
    
    @_disfavoredOverload @inlinable public func quotientAndRemainderReportingOverflow(dividingBy divisor: Digit) -> PVO<QR<Self, Digit>> {
        let dividendIsLessThanZero: Bool =    self.isLessThanZero
        let  divisorIsLessThanZero: Bool = divisor.isLessThanZero
        //=--------------------------------------=
        let qro_ = self.magnitude._quotientAndRemainderReportingOverflowAsUnsigned(dividingBy: divisor.magnitude)
        var qro  = PVO(QR(Self(bitPattern: qro_.partialValue.quotient), Digit(bitPattern: qro_.partialValue.remainder)), qro_.overflow)
        //=--------------------------------------=
        if  qro.overflow {
            assert(divisor.isZero)
            assert(qro.partialValue.quotient  == self)
            assert(qro.partialValue.remainder == Digit())
            return qro
        }

        if  dividendIsLessThanZero != divisorIsLessThanZero {
            qro.partialValue.quotient.formTwosComplement()
        }
        
        if  dividendIsLessThanZero && divisorIsLessThanZero && qro.partialValue.quotient.isLessThanZero {
            assert(Self.isSigned && self == Self.min && divisor == -1)
            assert(qro.partialValue.quotient  == self)
            assert(qro.partialValue.remainder == Digit())
            qro.overflow = true
            return qro
        }
        
        if  dividendIsLessThanZero {
            qro.partialValue.remainder.formTwosComplement()
        }
        //=--------------------------------------=
        return qro as PVO<QR<Self, Digit>>
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func _quotientAndRemainderReportingOverflowAsUnsigned(dividingBy divisor: Digit) -> PVO<QR<Self, Digit>> {
        var quotient  = self
        let remainder = quotient._formQuotientReportingRemainderAndOverflowAsUnsigned(dividingBy: divisor)
        return PVO(QR(quotient, remainder.partialValue), remainder.overflow)
    }
    
    @inlinable mutating func _formQuotientReportingRemainderAndOverflowAsUnsigned(dividingBy divisor: Digit) -> PVO<Digit> {
        //=--------------------------------------=
        if  divisor.isZero {
            return PVO(UInt(), true)
        }
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
        return PVO(remainder, false)
    }
}
