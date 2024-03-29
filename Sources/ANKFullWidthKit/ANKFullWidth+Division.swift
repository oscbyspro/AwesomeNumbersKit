//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit

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
        let minus = lhsIsLessThanZero != rhsIsLessThanZero
        //=--------------------------------------=
        var qro = ANK.bitCast(self.magnitude.quotientAndRemainderReportingOverflow(dividingBy: other.magnitude)) as PVO<QR<Self, Self>>
        //=--------------------------------------=
        if  minus {
            qro.partialValue.quotient.formTwosComplement()
        }
        
        if  lhsIsLessThanZero {
            qro.partialValue.remainder.formTwosComplement()
        }
        
        if  lhsIsLessThanZero && rhsIsLessThanZero && qro.partialValue.quotient.isLessThanZero {
            qro.overflow = true
        }
        //=--------------------------------------=
        return qro as PVO<QR<Self, Self>>
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Full Width
    //=------------------------------------------------------------------------=
    
    @inlinable public func dividingFullWidth(_ other: HL<Self, Magnitude>) -> QR<Self, Self> {
        self.dividingFullWidth(ANKFullWidth<Self, Magnitude>(descending: other))
    }
    
    @inlinable public func dividingFullWidth(_ other: ANKFullWidth<Self, Magnitude>) -> QR<Self, Self> {
        let pvo: PVO<QR<Self, Self>> = self.dividingFullWidthReportingOverflow(other)
        precondition(!pvo.overflow, ANK.callsiteOverflowInfo())
        return pvo.partialValue as  QR<Self, Self>
    }
    
    @inlinable public func dividingFullWidthReportingOverflow(_ other: HL<Self, Magnitude>) -> PVO<QR<Self, Self>> {
        self.dividingFullWidthReportingOverflow(ANKFullWidth<Self, Magnitude>(descending: other))
    }
    
    @inlinable public func dividingFullWidthReportingOverflow(_ other: ANKFullWidth<Self, Magnitude>) -> PVO<QR<Self, Self>> {
        let lhsIsLessThanZero: Bool = other.isLessThanZero
        let rhsIsLessThanZero: Bool = self .isLessThanZero
        let minus = lhsIsLessThanZero != rhsIsLessThanZero
        //=--------------------------------------=
        var qro = ANK.bitCast(self.magnitude.dividingFullWidthReportingOverflow(other.magnitude)) as PVO<QR<Self, Self>>
        //=--------------------------------------=
        if  minus {
            qro.partialValue.quotient.formTwosComplement()
        }
        
        if  lhsIsLessThanZero {
            qro.partialValue.remainder.formTwosComplement()
        }
        
        if  minus != qro.partialValue.quotient.isLessThanZero {
            qro.overflow = qro.overflow || !(minus && qro.partialValue.quotient.isZero)
        }
        //=--------------------------------------=
        return qro as PVO<QR<Self, Self>>
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
    @_specialize(where Self == UInt128)
    @_specialize(where Self == UInt192)
    @_specialize(where Self == UInt256)
    @_specialize(where Self == UInt384)
    @_specialize(where Self == UInt512)
    @inlinable func quotientAndRemainderReportingOverflow(dividingBy other: Self) -> PVO<QR<Self, Self>> {
        //=--------------------------------------=
        // divisor is zero
        //=--------------------------------------=
        guard let otherMinLastIndex: Int = other.lastIndex(where:{ !$0.isZero }) else {
            return PVO(QR(self, self), true)
        }
        //=--------------------------------------=
        // divisor is one word
        //=--------------------------------------=
        if  otherMinLastIndex.isZero {
            let qro: PVO<QR<Self, Digit>> = self.quotientAndRemainderReportingOverflow(dividingBy: other.first)
            return   PVO(QR(qro.partialValue.quotient, Self(digit: qro.partialValue.remainder)),  qro.overflow)
        }
        //=--------------------------------------=
        // divisor is greater than or equal
        //=--------------------------------------=
        if  self <= other {
            return self == other ? PVO(QR(1, Self.zero), false) : PVO(QR(Self.zero, self), false)
        }
        //=--------------------------------------=
        let thisMinLastIndex: Int = self.lastIndex(where:{ !$0.isZero })!
        let minLastIndexGapSize = thisMinLastIndex &- otherMinLastIndex as Int
        let shift = other[unchecked: otherMinLastIndex].leadingZeroBitCount as Int
        //=--------------------------------------=
        // shift to clamp approximation
        //=--------------------------------------=
        var remainder = ANKFullWidth<Digit, Magnitude>(low: self)
        remainder.bitshiftLeft(words: Int.zero, bits: shift)
        
        var increment = ANKFullWidth<Digit, Magnitude>(low: other)
        increment.low.bitshiftLeft(words: minLastIndexGapSize, bits: shift)
        assert(increment.high.isZero)
        
        let discriminant: UInt = increment.low[unchecked: thisMinLastIndex]
        assert(discriminant.mostSignificantBit)
        //=--------------------------------------=
        // division
        //=--------------------------------------=
        let quotient = Self.fromUnsafeMutableWords { quotient in
            for quotientIndex in quotient.indices  {
                quotient[unchecked: quotientIndex] = UInt.zero
            }
            //=----------------------------------=
            for quotientIndex in quotient.indices[...minLastIndexGapSize].reversed() {
                //=------------------------------=
                // approximate quotient digit
                //=------------------------------=
                var digit: UInt = remainder.withUnsafeWords {  remainder in
                    let remainderIndex  = otherMinLastIndex &+  quotientIndex
                    let remainderLast0  = remainder[unchecked: remainderIndex &+ 1]
                    if  remainderLast0 >= discriminant { return UInt.max }
                    let remainderLast1  = remainder[unchecked: remainderIndex]
                    return discriminant.dividingFullWidth(HL(remainderLast0, remainderLast1)).quotient
                }
                //=------------------------------=
                var approximation = ANKFullWidth<Digit, Magnitude>(descending: increment.low.multipliedFullWidth(by: digit))
                //=------------------------------=
                // decrement if overestimated
                //=------------------------------=
                if  approximation > remainder {
                    brrrrrrrrrrrrrrrrrrrrrrr: do { digit &-= 1; approximation &-= increment }
                    if approximation > remainder { digit &-= 1; approximation &-= increment }
                }
                
                assert(approximation <= remainder)
                //=------------------------------=
                remainder &-= approximation
                quotient[unchecked: quotientIndex] = digit
                //=------------------------------=
                guard !quotientIndex.isZero else { break }
                assert(increment.low.first.isZero)
                increment.low.bitshiftRight(words: 1)
            }
        }
        //=--------------------------------------=
        // undo shift before division
        //=--------------------------------------=
        assert(remainder.high.isZero)
        remainder.low.bitshiftRight(words: Int.zero, bits: shift)
        return PVO(QR(quotient, remainder.low), false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Full Width
    //=------------------------------------------------------------------------=
    
    @inlinable func dividingFullWidthReportingOverflow(_ other: ANKFullWidth<Self, Magnitude>) -> PVO<QR<Self, Self>> {
        let extended = other.quotientAndRemainderReportingOverflow(dividingBy: ANKFullWidth<Self, Magnitude>(low: self))
        let overflow = extended.overflow || !extended.partialValue.quotient.high.isZero
        return PVO(QR(extended.partialValue.quotient.low, extended.partialValue.remainder.low), overflow)
    }
}
