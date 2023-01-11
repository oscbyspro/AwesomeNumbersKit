//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Trivial
//*============================================================================*

/// An awesome fixed-width integer with trivial implementation.
///
/// - `Int`
/// - `Int8`
/// - `Int16`
/// - `Int32`
/// - `Int64`
/// - `UInt`
/// - `UInt8`
/// - `UInt16`
/// - `UInt32`
/// - `UInt64`
///
public protocol ANKTrivialFixedWidthInteger: ANKBigEndianTextCodable, ANKFixedWidthInteger where BitPattern == Magnitude { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKTrivialFixedWidthInteger {
    
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
        self & (1 as Self) << (Self.bitWidth - 1) != (0 as Self)
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
    
    @_transparent public mutating func formRemainderReportingOverflow(by amount: Self) -> Bool {
        let pvo: PVO<Self> = self.remainderReportingOverflow(dividingBy: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @_transparent public mutating func multiplyFullWidth(by amount: Self) -> Self {
        let hl: HL<Self, Magnitude> = self.multipliedFullWidth(by: amount)
        self = Self(truncatingIfNeeded: hl.low); return hl.high
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Details x Bit Pattern
//=----------------------------------------------------------------------------=

extension ANKTrivialFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent public init(bitPattern: BitPattern) {
        self = unsafeBitCast(bitPattern, to: Self.self)
    }
        
    @_transparent public var bitPattern: BitPattern {
        return unsafeBitCast(self, to: BitPattern.self)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Details x Two's Complement
//=----------------------------------------------------------------------------=

extension ANKTrivialFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func formTwosComplement() {
        self = self.twosComplement()
    }
    
    @_transparent public func twosComplement() -> Self {
        ~self &+ 1
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Details x Big Endian Text Codable
//=----------------------------------------------------------------------------=

extension ANKTrivialFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public static func decodeBigEndianText(_ source: some StringProtocol, radix: Int?) -> Self? {
        var bigEndianText = source[...]
        let sign  = bigEndianText._removeSignPrefix() ?? ANKSign.plus
        let radix = radix ?? bigEndianText._removeRadixLiteralPrefix() ?? 10
        let magnitude = Magnitude(bigEndianText, radix: radix)
        guard  let magnitude else { return nil }
        return Self(exactly: ANKSigned(magnitude, as: sign))
    }
    
    @inlinable public static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool) -> String {
        String(source, radix: radix, uppercase: uppercase)
    }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Signed x Trivial
//*============================================================================*

extension ANKTrivialFixedWidthInteger where Self: ANKSignedFixedWidthInteger {
    
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
// MARK: * ANK x Fixed Width Integer x Trivial x Swift
//*============================================================================*

extension Int: ANKTrivialFixedWidthInteger, ANKSignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension Int8: ANKTrivialFixedWidthInteger, ANKSignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension Int16: ANKTrivialFixedWidthInteger, ANKSignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension Int32: ANKTrivialFixedWidthInteger, ANKSignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension Int64: ANKTrivialFixedWidthInteger, ANKSignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension UInt: ANKTrivialFixedWidthInteger, ANKUnsignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension UInt8: ANKTrivialFixedWidthInteger, ANKUnsignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension UInt16: ANKTrivialFixedWidthInteger, ANKUnsignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension UInt32: ANKTrivialFixedWidthInteger, ANKUnsignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}

extension UInt64: ANKTrivialFixedWidthInteger, ANKUnsignedFixedWidthInteger {
    public typealias BitPattern = Magnitude
}
