//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Core Integer
//*============================================================================*

/// A fixed-width, binary, integer that is up to 64 bits wide.
///
/// Only the following types in the standard library may conform to this protocol:
///
/// - `Int`
/// - `Int8`
/// - `Int16`
/// - `Int32`
/// - `Int64`
///
/// - `UInt`
/// - `UInt8`
/// - `UInt16`
/// - `UInt32`
/// - `UInt64`
///
public protocol ANKCoreInteger<Magnitude>: ANKFixedWidthInteger where
BitPattern == Magnitude, Digit == Self, Magnitude: ANKCoreInteger { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKCoreInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Bit Pattern
    //=------------------------------------------------------------------------=
    
    @inlinable public init(bitPattern: BitPattern) {
        self = Swift.unsafeBitCast(bitPattern, to: Self.self)
    }
    
    @inlinable public var bitPattern: BitPattern {
        Swift.unsafeBitCast(self, to: BitPattern.self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Two's Complement
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func formTwosComplementSubsequence(_ carry: Bool) -> Bool {
        let pvo: PVO<Self> = self.twosComplementSubsequence(carry)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @inlinable public func twosComplementSubsequence(_ carry: Bool) -> PVO<Self> {
        var partialValue = ~self
        let overflow: Bool = carry && partialValue.addReportingOverflow(1 as Self)
        return PVO(partialValue, overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Addition, Subtraction, Multiplication, Division
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func addReportingOverflow(_ other: Self) -> Bool {
        let pvo: PVO<Self> = self.addingReportingOverflow(other)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @inlinable public mutating func subtractReportingOverflow(_ other: Self) -> Bool {
        let pvo: PVO<Self> = self.subtractingReportingOverflow(other)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @inlinable public mutating func multiplyReportingOverflow(by other: Self) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: other)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @inlinable public mutating func multiplyFullWidth(by other: Self) -> Self {
        let product: HL<Self, Magnitude> = self.multipliedFullWidth(by: other)
        self = Self(bitPattern: product.low)
        return product.high as Self
    }
    
    @inlinable public mutating func divideReportingOverflow(by other: Self) -> Bool {
        let pvo: PVO<Self> = self.dividedReportingOverflow(by: other)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @inlinable public mutating func formRemainderReportingOverflow(dividingBy other: Self) -> Bool {
        let pvo: PVO<Self> = self.remainderReportingOverflow(dividingBy: other)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @inlinable public func quotientAndRemainderReportingOverflow(dividingBy other: Self) -> PVO<QR<Self, Self>> {
        let quotient:  PVO<Self> = self.dividedReportingOverflow(by: other)
        let remainder: PVO<Self> = self.remainderReportingOverflow(dividingBy: other)
        assert(quotient.overflow == remainder.overflow)
        return PVO(QR(quotient.partialValue, remainder.partialValue), quotient.overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Division x Full Width
    //=------------------------------------------------------------------------=
    
    @inlinable public func dividingFullWidthReportingOverflow(_ other: HL<Self, Magnitude>) -> PVO<QR<Self, Self>> where Self: ANKSignedInteger {
        let lhsIsLessThanZero: Bool =  other.high.isLessThanZero
        let rhsIsLessThanZero: Bool =  /*--*/self.isLessThanZero
        let minus: Bool = lhsIsLessThanZero != rhsIsLessThanZero
        //=--------------------------------------=
        var lhsMagnitude = ANK.bitCast(other) as HL<Magnitude, Magnitude>
        if  lhsIsLessThanZero {
            var carry = true
            carry = lhsMagnitude.low .formTwosComplementSubsequence(carry)
            carry = lhsMagnitude.high.formTwosComplementSubsequence(carry)
        }
        
        let rhsMagnitude = self.magnitude as Magnitude
        //=--------------------------------------=
        var qro = ANK.bitCast(rhsMagnitude.dividingFullWidthReportingOverflow(lhsMagnitude)) as PVO<QR<Self, Self>>
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
    
    @inlinable public func dividingFullWidthReportingOverflow(_ other: HL<Self, Magnitude>) -> PVO<QR<Self, Self>> where Self: ANKUnsignedInteger {
        //=--------------------------------------=
        // divisor is zero
        //=--------------------------------------=
        if  self.isZero {
            return ANK.bitCast(PVO(QR(other.low, other.low), true))
        }
        //=--------------------------------------=
        // quotient does not fit in two halves
        //=--------------------------------------=
        if  self <= other.high {
            return PVO(self.dividingFullWidth(HL(other.high % self, other.low)), true) // stdlib
        }
        //=--------------------------------------=
        return PVO(self.dividingFullWidth(other), false) // stdlib
    }
}

//*============================================================================*
// MARK: * ANK x Core Integer x Swift
//*============================================================================*

extension Int: ANKCoreInteger, ANKSignedInteger {
    public typealias BitPattern = Magnitude
}

extension Int8: ANKCoreInteger, ANKSignedInteger {
    public typealias BitPattern = Magnitude
}

extension Int16: ANKCoreInteger, ANKSignedInteger {
    public typealias BitPattern = Magnitude
}

extension Int32: ANKCoreInteger, ANKSignedInteger {
    public typealias BitPattern = Magnitude
}

extension Int64: ANKCoreInteger, ANKSignedInteger {
    public typealias BitPattern = Magnitude
}

extension UInt: ANKCoreInteger, ANKUnsignedInteger {
    public typealias BitPattern = Magnitude
}

extension UInt8: ANKCoreInteger, ANKUnsignedInteger {
    public typealias BitPattern = Magnitude
}

extension UInt16: ANKCoreInteger, ANKUnsignedInteger {
    public typealias BitPattern = Magnitude
}

extension UInt32: ANKCoreInteger, ANKUnsignedInteger {
    public typealias BitPattern = Magnitude
}

extension UInt64: ANKCoreInteger, ANKUnsignedInteger {
    public typealias BitPattern = Magnitude
}
