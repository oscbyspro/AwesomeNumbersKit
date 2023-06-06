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
    
    @_transparent public mutating func divideReportingOverflow(by other: Self) -> Bool {
        let pvo: PVO<Self> = self.dividedReportingOverflow(by: other)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @_transparent public func dividedReportingOverflow(by other: Self) -> PVO<Self> {
        let qro: PVO<QR<Self, Self>> = self.quotientAndRemainderReportingOverflow(dividingBy: other)
        return   PVO(qro.partialValue.quotient, qro.overflow)
    }
    
    @_transparent public mutating func formRemainderReportingOverflow(dividingBy other: Self) -> Bool {
        let pvo: PVO<Self> = self.remainderReportingOverflow(dividingBy: other)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @_transparent public func remainderReportingOverflow(dividingBy other: Self) -> PVO<Self> {
        let qro: PVO<QR<Self, Self>> = self.quotientAndRemainderReportingOverflow(dividingBy: other)
        return   PVO(qro.partialValue.remainder, qro.overflow)
    }
    
    @inlinable public func quotientAndRemainderReportingOverflow(dividingBy other: Self) -> PVO<QR<Self, Self>> {
        let lhsIsLessThanZero: Bool = self .isLessThanZero
        let rhsIsLessThanZero: Bool = other.isLessThanZero
        //=--------------------------------------=
        var qro = self.magnitude._quotientAndRemainderReportingOverflowAsUnsigned(dividingBy: other.magnitude)
        //=--------------------------------------=
        if  lhsIsLessThanZero != rhsIsLessThanZero {
            qro.partialValue.quotient.formTwosComplement()
        }

        if  lhsIsLessThanZero {
            qro.partialValue.remainder.formTwosComplement()
        }

        if  lhsIsLessThanZero, rhsIsLessThanZero, qro.partialValue.quotient.mostSignificantBit {
            qro.overflow = true
        }
        //=--------------------------------------=
        return PVO(QR(Self(bitPattern: qro.partialValue.quotient), Self(bitPattern: qro.partialValue.remainder)), qro.overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Full Width
    //=------------------------------------------------------------------------=
    
    @inlinable public func dividingFullWidth(_ other: HL<Self, Magnitude>) -> QR<Self, Self> {
        let lhs = DoubleWidth(descending: other)
        //=--------------------------------------=
        let lhsIsLessThanZero: Bool = lhs .isLessThanZero
        let rhsIsLessThanZero: Bool = self.isLessThanZero
        //=--------------------------------------=
        var qr: QR<Magnitude, Magnitude> = self.magnitude._dividingFullWidthAsUnsigned(lhs.magnitude)
        //=--------------------------------------=
        if  lhsIsLessThanZero != rhsIsLessThanZero {
            qr.quotient.formTwosComplement()
        }
        
        if  lhsIsLessThanZero {
            qr.remainder.formTwosComplement()
        }
        //=--------------------------------------=
        return QR(Self(bitPattern: qr.quotient), Self(bitPattern: qr.remainder))
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the quotient and remainder of dividing `self` by `other`.
    ///
    /// Performs unsigned long division with `UInt` digits.
    ///
    @_specialize(where Self == ANKUInt128)
    @_specialize(where Self == ANKUInt192)
    @_specialize(where Self == ANKUInt256)
    @_specialize(where Self == ANKUInt384)
    @_specialize(where Self == ANKUInt512)
    @inlinable func _quotientAndRemainderReportingOverflowAsUnsigned(dividingBy other: Self) -> PVO<QR<Self, Self>> {
        let other_ = other.minLastIndexReportingIsZeroOrMinusOne()
        //=--------------------------------------=
        // divisor is zero
        //=--------------------------------------=
        if  other_.isZeroOrMinusOne {
            return PVO(QR(self, self), true)
        }
        //=--------------------------------------=
        // divisor is greater than or equal
        //=--------------------------------------=
        if  self <= other {
            return self == other ? PVO(QR(1, Self()), false) : PVO(QR(Self(), self), false)
        }
        //=--------------------------------------=
        // divisor is one word
        //=--------------------------------------=
        if  other_.minLastIndex.isZero {
            let qro: PVO<QR<Self, Digit>> = self._quotientAndRemainderReportingOverflowAsUnsigned(dividingBy: other.first)
            return   PVO(QR(qro.partialValue.quotient, Self(digit: qro.partialValue.remainder)), qro.overflow)
        }
        //=--------------------------------------=
        let self_ = self.minLastIndexReportingIsZeroOrMinusOne()
        let minLastIndexGapSize: Int = self_.minLastIndex &- other_.minLastIndex
        let shift: Int = other[unchecked: other_.minLastIndex].leadingZeroBitCount
        //=--------------------------------------=
        // shift to clamp approximation
        //=--------------------------------------=
        var remainder = Plus1(descending: HL(UInt(), self))
        remainder._bitshiftLeft(words: Int(), bits:  shift)
        
        var increment = Plus1(descending: HL(UInt(), other))
        increment.low._bitshiftLeft(words: minLastIndexGapSize, bits: shift)
        assert(increment.high.isZero)
        
        let discriminant: UInt = increment.low[unchecked: self_.minLastIndex]
        assert(discriminant.mostSignificantBit)
        //=--------------------------------------=
        // division
        //=--------------------------------------=
        let quotient = Self.fromUnsafeMutableWords { QUOTIENT in
            for quotientIndex in QUOTIENT.indices  {
                QUOTIENT[quotientIndex] = UInt()
            }
            //=----------------------------------=
            for quotientIndex in QUOTIENT.indices[...minLastIndexGapSize].reversed() {
                //=------------------------------=
                // approximate quotient digit
                //=------------------------------=
                var digit: UInt = remainder.withUnsafeWords { REMAINDER in
                    let  remainderIndex  = other_.minLastIndex &+ quotientIndex
                    let  remainderLast0  = REMAINDER[remainderIndex &+ 1]
                    if   remainderLast0 >= discriminant { return UInt.max }
                    let  remainderLast1  = REMAINDER[remainderIndex /**/]
                    return discriminant.dividingFullWidth(HL(remainderLast0, remainderLast1)).quotient
                }
                //=------------------------------=
                var approximation = Plus1(descending: increment.low.multipliedFullWidth(by: digit))
                //=------------------------------=
                // decrement if overestimated
                //=------------------------------=
                if  approximation > remainder {
                    brrrrrrrrrrrrrrrrrrrrrrr: do { digit &-= 1; approximation &-= increment }
                    if approximation > remainder { digit &-= 1; approximation &-= increment }
                }
                //=------------------------------=
                assert(approximation <= remainder)
                remainder &-= approximation
                QUOTIENT[quotientIndex] = digit
                increment.low._bitshiftRight(words: 1, bits: Int())
            }
        }
        //=--------------------------------------=
        // undo shift before division
        //=--------------------------------------=
        assert(remainder.high.isZero)
        remainder.low._bitshiftRight(words: Int(), bits: shift)
        return PVO(QR(quotient, remainder.low), false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Full Width
    //=------------------------------------------------------------------------=
    
    @inlinable func _dividingFullWidthAsUnsigned(_ other: DoubleWidth) -> QR<Self, Self> {
        let this = DoubleWidth(descending: HL(Self(), self))
        let qro: PVO<QR<DoubleWidth, DoubleWidth>> = other._quotientAndRemainderReportingOverflowAsUnsigned(dividingBy: this)
        precondition(!qro.overflow, ANK.callsiteOverflowInfo())
        return QR(qro.partialValue.quotient.low, qro.partialValue.remainder.low)
    }
}
