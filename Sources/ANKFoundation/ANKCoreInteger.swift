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

/// An awesome, fixed-width, binary integer.
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
    // MARK: Details x Bits
    //=------------------------------------------------------------------------=
    
    @_transparent public init(bit: Bool) {
        self = bit ?  (1 as Self) : (0 as Self)
    }
    
    @_transparent public init(repeating bit: Bool) {
        self = bit ? ~(0 as Self) : (0 as Self)
    }
    
    @_transparent public var mostSignificantBit: Bool {
        self & ((1 as Self) &<< (Self.bitWidth &- 1)) != (0 as Self)
    }
    
    @_transparent public var leastSignificantBit: Bool {
        self & ((1 as Self)) != (0 as Self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Comparisons
    //=------------------------------------------------------------------------=
    
    @_transparent public var isFull: Bool {
        self == ~(0 as Self)
    }
    
    @_transparent public var isZero: Bool {
        self ==  (0 as Self)
    }
    
    @_transparent public var isLessThanZero: Bool {
        Self.isSigned && self < (0 as Self)
    }
    
    @_transparent public var isMoreThanZero: Bool {
        self > (0 as Self)
    }
    
    @inlinable public func compared(to other: Self) -> Int {
        self < other ? -1 : self == other ? 0 : 1
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Bit Pattern
    //=------------------------------------------------------------------------=
    
    @_transparent public var bitPattern: BitPattern {
        unsafeBitCast(self, to: BitPattern.self)
    }
    
    @_transparent public init(bitPattern source: some ANKBitPatternConvertible<BitPattern>) {
        self = unsafeBitCast(source.bitPattern, to: Self.self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Two's Complement
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func formTwosComplement() {
        self = self.twosComplement()
    }
    
    @_transparent public func twosComplement() -> Self {
        ~self &+ (1 as Self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func addReportingOverflow(_ other: Self) -> Bool {
        let pvo: PVO<Self> = self.addingReportingOverflow(other)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @_transparent public mutating func subtractReportingOverflow(_ other: Self) -> Bool {
        let pvo: PVO<Self> = self.subtractingReportingOverflow(other)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @_transparent public mutating func multiplyReportingOverflow(by other: Self) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: other)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @_transparent public mutating func multiplyFullWidth(by other: Self) -> Self {
        let product: HL<Self, Magnitude> = self.multipliedFullWidth(by: other)
        self = Self(bitPattern: product.low)
        return product.high as Self
    }
    
    @_transparent public mutating func divideReportingOverflow(by other: Self) -> Bool {
        let pvo: PVO<Self> = self.dividedReportingOverflow(by: other)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @_transparent public mutating func formRemainderReportingOverflow(dividingBy other: Self) -> Bool {
        let pvo: PVO<Self> = self.remainderReportingOverflow(dividingBy: other)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @_transparent public func quotientAndRemainderReportingOverflow(dividingBy other: Self) -> PVO<QR<Self, Self>> {
        let quotient:  PVO<Self> = self.dividedReportingOverflow(by: other)
        let remainder: PVO<Self> = self.remainderReportingOverflow(dividingBy: other)
        assert(quotient.overflow == remainder.overflow)
        return PVO(QR(quotient.partialValue, remainder.partialValue), quotient.overflow)
    }
    
    @_transparent public func quotientAndRemainder(dividingBy other: Self) -> QR<Self, Self> {
        let qro: PVO<QR<Self, Self>> = self.quotientAndRemainderReportingOverflow(dividingBy: other)
        precondition(!qro.overflow, ANK.callsiteOverflowInfo())
        return qro.partialValue as QR<Self, Self>
    }
    
    @inlinable public func dividingFullWidthReportingOverflow(_ other: HL<Self, Magnitude>) -> PVO<QR<Self, Self>> {
        //=--------------------------------------=
        if  self.isZero {
            return ANK.bitCast(PVO(QR(other.low, other.low), true))
        }
        //=--------------------------------------=
        let lhsIsLessThanZero: Bool =  other.high.isLessThanZero
        let rhsIsLessThanZero: Bool =  /*--*/self.isLessThanZero
        let minus: Bool = lhsIsLessThanZero != rhsIsLessThanZero
        //=--------------------------------------=
        var lhsMagnitude = ANK.bitCast(other) as HL<Magnitude, Magnitude>
        if  lhsIsLessThanZero {
            var carry = true
            (lhsMagnitude.low,  carry) = (~lhsMagnitude.low ).addingReportingOverflow(Magnitude(bit: carry))
            (lhsMagnitude.high, carry) = (~lhsMagnitude.high).addingReportingOverflow(Magnitude(bit: carry))
        }
        
        let rhsMagnitude = self.magnitude as Magnitude
        //=--------------------------------------=
        var qro = ANK.bitCast(PVO(rhsMagnitude.dividingFullWidth(lhsMagnitude), lhsMagnitude.high >= rhsMagnitude)) as PVO<QR<Self, Self>>
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
// MARK: + Details where Signed
//=----------------------------------------------------------------------------=

extension ANKCoreInteger where Self: ANKSignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func negateReportingOverflow() -> Bool {
        let pvo: PVO<Self> = self.negatedReportingOverflow()
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @_transparent public func negatedReportingOverflow() -> PVO<Self> {
        PVO(self.twosComplement(), self == Self.min)
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
