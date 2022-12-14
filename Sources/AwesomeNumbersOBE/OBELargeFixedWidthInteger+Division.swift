//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import AwesomeNumbersKit

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Large x Division
//*============================================================================*

extension OBELargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func /=(lhs: inout Self, rhs: Self) {
        let (pv, o) = lhs.dividedReportingOverflow(by: rhs); precondition(!o); lhs = pv
    }
    
    @inlinable public static func /(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs /= rhs; return lhs
    }
    
    @inlinable public static func %=(lhs: inout Self, rhs: Self) {
        let (pv, o) = lhs.remainderReportingOverflow(dividingBy: rhs); precondition(!o); lhs = pv
    }
    
    @inlinable public static func %(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs %= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func divideReportingOverflow(by divisor: Self) -> Bool {
        let o: Bool; (self, o) = self.dividedReportingOverflow(by: divisor); return o
    }
    
    @inlinable public func dividedReportingOverflow(by divisor: Self) -> PVO<Self> {
        if divisor.isZero { return PVO(self, true) }
        if Self.isSigned && divisor == -1 && self == Self.min { return PVO(self, true) }
        return PVO(self.quotientAndRemainder(dividingBy: divisor).quotient, false)
    }
    
    @inlinable public mutating func formRemainderReportingOverflow(by divisor: Self) -> Bool {
        let o: Bool; (self, o) = self.remainderReportingOverflow(dividingBy: divisor); return o
    }
    
    @inlinable public func remainderReportingOverflow(dividingBy divisor: Self) -> PVO<Self> {
        if divisor.isZero { return PVO(self, true) }
        if Self.isSigned && divisor == -1 && self == Self.min { return PVO(Self(), true) }
        return PVO(self.quotientAndRemainder(dividingBy: divisor).remainder, false)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Large x Signed x Division
//*============================================================================*

extension OBESignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public func quotientAndRemainder(dividingBy divisor: Self) -> QR<Self, Self> {
        let division  = self.magnitude.quotientAndRemainder(dividingBy: divisor.magnitude)
        var quotient  = Self(division.quotient )
        var remainder = Self(division.remainder)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  isLessThanZero {
            remainder.negate()
        }
        
        if  isLessThanZero != divisor.isLessThanZero {
            quotient .negate()
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        return (quotient, remainder)
    }
    
    @inlinable public func dividingFullWidth(_ dividend: HL<Self, Magnitude>) -> QR<Self, Self> {
        let dividend = OBEDoubleWidthInteger<Self>(descending: dividend)
        let dividendIsLessThanZero = dividend.isLessThanZero
        var (quotient, remainder) = Magnitude._divide(dividend.magnitude, by: self.magnitude)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  dividendIsLessThanZero {
            remainder.formTwosComplement()
        }
        
        if  dividendIsLessThanZero != self.isLessThanZero {
            quotient .formTwosComplement()
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        return (Self(bitPattern: quotient), Self(bitPattern: remainder))
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Large x Unsigned x Division
//*============================================================================*

extension OBEUnsignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public func quotientAndRemainder(dividingBy divisor: Self) -> QR<Self, Self> {
        Magnitude._divide(self.magnitude, by: divisor.magnitude)
    }
    
    @inlinable public func dividingFullWidth(_ dividend: HL<Self, Magnitude>) -> QR<Self, Self> {
        Magnitude._divide(OBEDoubleWidthInteger<Self>(descending: dividend).magnitude, by: self.magnitude)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// See: https://github.com/apple/swift/blob/main/test/Prototypes/DoubleWidth.swift.gyb
    @inlinable static func _divide(_ lhs: (high: Low, mid: Low, low: Low), by rhs: Magnitude) -> QR<Low, Magnitude> {
        typealias M = Magnitude
        typealias D = OBEDoubleWidthInteger<Magnitude>
        //=--------------------------------------=
        //
        //=--------------------------------------=
        assert(rhs.mostSignificantBit)
        assert(M(descending:(lhs.high, lhs.mid)) < rhs)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        var quotient = (lhs.high == rhs.high) ? Low.max : rhs.high.dividingFullWidth((lhs.high, lhs.mid)).quotient
        var product  = D(descending:(M(), M(descending:(quotient.multipliedFullWidth(by: rhs.low)))))
        let (x, y): (High, High) = quotient.multipliedFullWidth(by: rhs.high)
        product += D(descending:(Magnitude(descending:(High(), x)),  M(descending:(y, Low()))))
        var remainder = D(descending:(M(descending:(High(), lhs.high)), M(descending:(lhs.mid, lhs.low))))
        //=--------------------------------------=
        //
        //=--------------------------------------=
        overestimated: while remainder < product {
            quotient  &-= 1 as High
            remainder  += D(descending:(M(), rhs))
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        remainder -= product
        return (quotient, remainder.low)
    }
    
    /// See: https://github.com/apple/swift/blob/main/test/Prototypes/DoubleWidth.swift.gyb
    @inlinable static func _divide(_ lhs: OBEDoubleWidthInteger<Magnitude>, by rhs: Magnitude) -> QR<Magnitude, Magnitude> {
        typealias M = Magnitude
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  lhs.high.isZero {
            return lhs.low.quotientAndRemainder(dividingBy: rhs)
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  rhs.isZero {
            fatalError("division by zero")
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  rhs.high.isZero {
            let r0: Low
            = lhs.high.high % rhs.low
            
            let r1 = r0.isZero
            ? lhs.high.low % rhs.low
            : rhs.low.dividingFullWidth((r0, lhs.high.low)).remainder
            
            let (q2, r2) = r1.isZero
            ? lhs.low.high.quotientAndRemainder(dividingBy: rhs.low)
            : rhs.low.dividingFullWidth((r1, lhs.low.high))
            
            let (q3, r3) = r2.isZero
            ? lhs.low.low.quotientAndRemainder(dividingBy: rhs.low)
            : rhs.low.dividingFullWidth((r2, lhs.low.low))
            
            return (M(descending:(q2, q3)), M(descending:(High(), r3)))
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  rhs < lhs.high {
            fatalError("division overflow")
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let normalization = rhs.leadingZeroBitCount
        let rhs = rhs &<< normalization
        let lhs = lhs &<< normalization
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  lhs.high.high.isZero, M(descending:(lhs.high.low, lhs.low.high)) < rhs {
            let (q0, r0) = M._divide((lhs.high.low, lhs.low.high, lhs.low.low), by: rhs)
            return (M(descending:(High(), q0)), r0 &>> normalization)
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let (q0, r0) = M._divide((lhs.high.high, lhs.high.low, lhs.low.high), by: rhs)
        let (q1, r1) = M._divide((r0.high,       r0.low,       lhs.low.low ), by: rhs)
        return (M(descending:(q0, q1)), r1 &>> normalization)
    }
    
    /// See: https://github.com/apple/swift/blob/main/test/Prototypes/DoubleWidth.swift.gyb
    @inlinable static func _divide(_ lhs: Magnitude, by rhs: Magnitude) -> QR<Magnitude, Magnitude> {
        typealias M = Magnitude
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  lhs.high.isZero {
            let (q0, r0) = lhs.low.quotientAndRemainder(dividingBy: rhs.low)
            return (M(descending:(High(), q0)),  M(descending:(High(), r0)))
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  rhs.isZero {
            fatalError("division by zero")
        }
        
        if  rhs >= lhs {
            return rhs > lhs ? (M(), lhs) : (1, M())
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  rhs.high.isZero {
            let (q0, r0): (High, High)
            = lhs.high.quotientAndRemainder(dividingBy: rhs.low)
            
            let (q1, r1) = r0.isZero
            ? lhs.low.quotientAndRemainder(dividingBy: rhs.low)
            : rhs.low.dividingFullWidth((r0, lhs.low))
            
            return (M(descending:(q0, q1)), M(descending:(High(), r1)))
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let normalization =  rhs.leadingZeroBitCount
        let rhs   =  rhs &<< normalization
        let high  = (lhs &>> (M.bitWidth &- normalization)).low
        let lhs   =  lhs &<< normalization
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let (q0, r0) = M._divide((high, lhs.high, lhs.low), by: rhs)
        return (M(descending:(High(), q0)), r0 &>> normalization)
    }
}
