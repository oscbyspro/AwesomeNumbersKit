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
public protocol ANKCoreInteger: ANKBigEndianTextCodable, ANKFixedWidthInteger, ANKTrivialContiguousBytes where
Magnitude: ANKCoreInteger, Magnitude == BitPattern { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKCoreInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(bit: Bool) {
        self = bit ?  (1 as Self) : (0 as Self)
    }
    
    @_transparent public init(repeating bit: Bool) {
        self = bit ? ~(0 as Self) : (0 as Self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var isZero: Bool {
        self == (0 as Self)
    }
    
    @_transparent public var isLessThanZero: Bool {
        Self.isSigned && self < (0 as Self)
    }
    
    @_transparent public var isMoreThanZero: Bool {
        self > (0 as Self)
    }
    
    @_transparent public var mostSignificantBit: Bool {
        self & ((1 as Self) &<< (Self.bitWidth &- 1)) != (0 as Self)
    }
    
    @_transparent public var leastSignificantBit: Bool {
        self & (1 as Self) != (0 as Self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func addReportingOverflow(_ amount: Self) -> Bool {
        let pvo: PVO<Self> = self.addingReportingOverflow(amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_transparent public mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        let pvo: PVO<Self> = self.subtractingReportingOverflow(amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_transparent public mutating func multiplyReportingOverflow(by amount: Self) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_transparent public mutating func divideReportingOverflow(by amount: Self) -> Bool {
        let pvo: PVO<Self> = self.dividedReportingOverflow(by: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_transparent public mutating func formRemainderReportingOverflow(dividingBy amount: Self) -> Bool {
        let pvo: PVO<Self> = self.remainderReportingOverflow(dividingBy: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_transparent public mutating func multiplyFullWidth(by amount: Self) -> Self {
        let hl: HL<Self, Magnitude> = self.multipliedFullWidth(by: amount)
        self = Self(bitPattern: hl.low); return hl.high
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
    // MARK: Details x Big Endian Text Codable
    //=------------------------------------------------------------------------=
    
    @inlinable public static func decodeBigEndianText(_ source: some StringProtocol, radix: Int?) -> Self? {
        let components = source._bigEndianTextComponents(radix: radix)
        guard let magnitude = Magnitude(components.body, radix: components.radix) else { return nil }
        return Self(exactly: ANKSigned(magnitude, as: components.sign))
    }
    
    @inlinable public static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool) -> String {
        String(source, radix: radix, uppercase: uppercase)
    }
}

//*============================================================================*
// MARK: * ANK x Core Integer x Signed
//*============================================================================*

extension ANKCoreInteger where Self: ANKSignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func negateReportingOverflow() -> Bool {
        let pvo: PVO<Self> = self.negatedReportingOverflow()
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_transparent public func negatedReportingOverflow() -> PVO<Self> {
        PVO(self.twosComplement(), self == Self.min)
    }
}

//*============================================================================*
// MARK: * ANK x Core Integer x Swift
//*============================================================================*

extension Int: ANKCoreInteger, ANKSignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension Int8: ANKCoreInteger, ANKSignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension Int16: ANKCoreInteger, ANKSignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension Int32: ANKCoreInteger, ANKSignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension Int64: ANKCoreInteger, ANKSignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension UInt: ANKCoreInteger, ANKUnsignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension UInt8: ANKCoreInteger, ANKUnsignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension UInt16: ANKCoreInteger, ANKUnsignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension UInt32: ANKCoreInteger, ANKUnsignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension UInt64: ANKCoreInteger, ANKUnsignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}
