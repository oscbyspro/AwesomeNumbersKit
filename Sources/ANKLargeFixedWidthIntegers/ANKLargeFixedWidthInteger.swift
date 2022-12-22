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
// MARK: * ANK x Fixed Width Integer x Large
//*============================================================================*

/// An internal fixed-width integer implementation protocol.
///
/// ```
/// High.bitWidth / UInt.bitWidth >= 1
/// Low .bitWidth / UInt.bitWidth >= 1
/// Self.bitWidth / UInt.bitWidth >= 2
/// ```
///
/// ```
/// High.bitWidth % UInt.bitWidth == 0
/// Low .bitWidth % UInt.bitWidth == 0
/// Self.bitWidth % UInt.bitWidth == 0
/// ```
///
/// ```
/// High must use two's complement representation
/// Low  must use two's comlpement representation
/// ```
///
/// ```
/// It must be safe to bit cast between Self.High and Self.Low
/// It must be safe to bit cast between Self and Self.Magnitude
/// ```
///
@usableFromInline protocol ANKLargeFixedWidthInteger<High, Low>:
AwesomeLargeFixedWidthInteger, CustomDebugStringConvertible where
Magnitude: ANKUnsignedLargeFixedWidthInteger<High.Magnitude, Low.Magnitude> {
    
    associatedtype X64 = Never // (UInt64, UInt64, ...)
    
    associatedtype X32 = Never // (UInt32, UInt32, UInt32, UInt32, ...)
    
    associatedtype High: AwesomeLargeFixedWidthInteger where Digit == High.Digit
        
    associatedtype Low:  AwesomeUnsignedLargeFixedWidthInteger where Low == Low.Magnitude
    
    typealias Body = ANKFullWidth<High, Low>
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @_hasStorage var body: Body
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(bitPattern: Body)
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init() {
        self.init(bitPattern: Body())
    }
    
    @_transparent public init(_ bit: Bool) {
        self.init(bitPattern: Body(bit))
    }
    
    @_transparent public init(repeating bit: Bool) {
        self.init(bitPattern: Body(repeating: bit))
    }
    
    @_transparent public init(repeating word: UInt) {
        self.init(bitPattern: Body(repeating: word))
    }
    
    @_transparent public init(x64: X64) {
        self.init(bitPattern: Body(ascending: unsafeBitCast(x64, to: (low: Low, high: High).self)))
    }
    
    @_transparent public init(x32: X32) {
        self.init(bitPattern: Body(ascending: unsafeBitCast(x32, to: (low: Low, high: High).self)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init(ascending digits:(low: Low, high: High)) {
        self.init(bitPattern: Body(ascending: digits))
    }
    
    @_transparent @usableFromInline init(descending digits:(high: High, low: Low)) {
        self.init(bitPattern: Body(descending: digits))
    }
    
    @_transparent @usableFromInline static func uninitialized() -> Self {
        self.init(bitPattern: Body.uninitialized())
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init<T>(bitPattern: ANKFullWidth<T, Low>) where T.Magnitude == High.Magnitude {
        self.init(bitPattern: Body(bitPattern: bitPattern)) // signitude or magnitude
    }
    
    @_transparent @usableFromInline init<T>(bitPattern: T) where T: ANKLargeFixedWidthInteger, T.Magnitude == Self.Magnitude {
        self.init(bitPattern: Body(bitPattern: bitPattern.body)) // signitude or magnitude
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline static func h(l: inout Self, _ hl: Body.DoubleWidth) -> Self {
        l = Self(bitPattern: hl.low); return Self(bitPattern: hl.high)
    }
    
    @_transparent @usableFromInline static func hl(_ hl: Body.DoubleWidth) -> HL<Self, Magnitude> {
        HL(Self(bitPattern: hl.high), Magnitude(bitPattern: hl.low))
    }
    
    @_transparent @usableFromInline static func pvo(_ pvo: PVO<Body>) -> PVO<Self> {
        PVO(Self(bitPattern: pvo.partialValue), pvo.overflow)
    }
    
    @_transparent @usableFromInline static func qr(_ qr: QR<Body, Body>) -> QR<Self, Self> {
        QR(Self(bitPattern: qr.quotient), Self(bitPattern: qr.remainder))
    }
    
    @_transparent @usableFromInline static func qr(_ qr: QR<Body, Digit>) -> QR<Self, Digit> {
        QR(Self(bitPattern: qr.quotient), qr.remainder)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public static var zero: Self {
        Self(bitPattern: Body.zero)
    }
    
    @usableFromInline var high: High {
        @_transparent _read   { yield  self.body.high }
        @_transparent _modify { yield &self.body.high }
    }
    
    @usableFromInline var low:  Low  {
        @_transparent _read   { yield  self.body.low  }
        @_transparent _modify { yield &self.body.low  }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline static func reinterpret(_ value: Low) -> High {
        unsafeBitCast(value, to: High.self)
    }
    
    @_transparent @usableFromInline static func reinterpret(_ value: High) -> Low {
        unsafeBitCast(value, to: Low .self)
    }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Signed
//*============================================================================*

@usableFromInline protocol ANKSignedLargeFixedWidthInteger<High, Low>:
ANKLargeFixedWidthInteger, AwesomeSignedLargeFixedWidthInteger where High:
AwesomeSignedFixedWidthInteger, X64 == Magnitude.X64, X32 == Magnitude.X32 {
    
    associatedtype X64 = Magnitude.X64 // (UInt64, UInt64, ...)
    
    associatedtype X32 = Magnitude.X32 // (UInt32, UInt32, UInt32, UInt32, ...)
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKSignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public static var min: Self {
        Self(bitPattern: Body.min)
    }

    @_transparent public static var max: Self {
        Self(bitPattern: Body.max)
    }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Unsigned
//*============================================================================*

@usableFromInline protocol ANKUnsignedLargeFixedWidthInteger<High, Low>: ANKLargeFixedWidthInteger,
AwesomeUnsignedLargeFixedWidthInteger where High: AwesomeUnsignedFixedWidthInteger, High == Low { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKUnsignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public static var min: Self {
        Self(bitPattern: Body.min)
    }

    @_transparent public static var max: Self {
        Self(bitPattern: Body.max)
    }
}
