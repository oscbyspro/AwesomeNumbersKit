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
/// Base.bitWidth / UInt.bitWidth >= 1
/// Self.bitWidth / UInt.bitWidth >= 2
/// ```
///
/// ```
/// Base.bitWidth % UInt.bitWidth == 0
/// Self.bitWidth % UInt.bitWidth == 0
/// ```
///
/// ```
/// Base must use two's complement representation
/// ```
///
/// ```
/// It must be safe to bit cast between Self and Self.Magnitude
/// It must be safe to bit cast between Base and Base.Magnitude
/// ```
///
@usableFromInline protocol ANKLargeFixedWidthInteger<Base>:
AwesomeLargeFixedWidthInteger, CustomDebugStringConvertible where
Self.Magnitude: ANKUnsignedLargeFixedWidthInteger<Base.Magnitude>,
Base.Digit: AwesomeEitherIntOrUInt, Self.Digit == Base.Digit {
    
    associatedtype X64 = Never // (UInt64, UInt64, ...)
    
    associatedtype X32 = Never // (UInt32, UInt32, UInt32, UInt32, ...)
    
    associatedtype Base: AwesomeLargeFixedWidthInteger
        
    typealias High = Base
    
    typealias Low  = Base.Magnitude
    
    typealias Body = ANKFullWidth<Self.Base, Self.Base.Magnitude>
        
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @_hasStorage var body: Self.Body
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(bitPattern: Self.Body)
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init() {
        self.init(bitPattern: Self.Body())
    }
    
    @_transparent public init(bit: Bool) {
        self.init(bitPattern: Self.Body(bit: bit))
    }
    
    @_transparent public init(repeating bit: Bool) {
        self.init(bitPattern: Self.Body(repeating: bit))
    }
    
    @_transparent public init(repeating word: UInt) {
        self.init(bitPattern: Self.Body(repeating: word))
    }
    
    @_transparent public init(x64: X64) {
        self.init(bitPattern: Self.Body(ascending: unsafeBitCast(x64, to: (low: Self.Low, high: Self.High).self)))
    }
    
    @_transparent public init(x32: X32) {
        self.init(bitPattern: Self.Body(ascending: unsafeBitCast(x32, to: (low: Self.Low, high: Self.High).self)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init(ascending digits:(low: Low, high: High)) {
        self.init(bitPattern: Self.Body(ascending: digits))
    }
    
    @_transparent @usableFromInline init(descending digits:(high: High, low: Low)) {
        self.init(bitPattern: Self.Body(descending: digits))
    }
    
    @_transparent @usableFromInline static func uninitialized() -> Self {
        self.init(bitPattern: Self.Body.uninitialized())
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init<T>(bitPattern: T) where T: ANKLargeFixedWidthInteger, T.Magnitude == Self.Magnitude {
        self.init(bitPattern: Self.Body(bitPattern: bitPattern.body)) // signitude or magnitude
    }
    
    @_transparent @usableFromInline init<T>(bitPattern: ANKFullWidth<T, T.Magnitude>) where T.Magnitude == Self.Base.Magnitude {
        self.init(bitPattern: Self.Body(bitPattern: bitPattern)) // signitude or magnitude
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline static func h(l: inout Self, _ hl: Self.Body.DoubleWidth) -> Self {
        l = Self(bitPattern: hl.low); return Self(bitPattern: hl.high)
    }
    
    @_transparent @usableFromInline static func hl(_ hl: Self.Body.DoubleWidth) -> HL<Self, Self.Magnitude> {
        HL(Self(bitPattern: hl.high), Self.Magnitude(bitPattern: hl.low))
    }
    
    @_transparent @usableFromInline static func pvo(_ pvo: PVO<Self.Body>) -> PVO<Self> {
        PVO(Self(bitPattern: pvo.partialValue), pvo.overflow)
    }
    
    @_transparent @usableFromInline static func qr(_ qr: QR<Self.Body, Self.Body>) -> QR<Self, Self> {
        QR(Self(bitPattern: qr.quotient), Self(bitPattern: qr.remainder))
    }
    
    @_transparent @usableFromInline static func qr(_ qr: QR<Self.Body, Self.Digit>) -> QR<Self, Self.Digit> {
        QR(Self(bitPattern: qr.quotient), qr.remainder)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public static var zero: Self {
        Self(bitPattern: Body.zero)
    }
    
    @usableFromInline var high: Self.High {
        @_transparent _read   { yield  self.body.high }
        @_transparent _modify { yield &self.body.high }
    }
    
    @usableFromInline var low:  Self.Low  {
        @_transparent _read   { yield  self.body.low  }
        @_transparent _modify { yield &self.body.low  }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline static func reinterpret(_ value: Self.Low) -> Self.High {
        unsafeBitCast(value, to: Self.High.self)
    }
    
    @_transparent @usableFromInline static func reinterpret(_ value: Self.High) -> Self.Low {
        unsafeBitCast(value, to: Self.Low .self)
    }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Signed
//*============================================================================*

@usableFromInline protocol ANKSignedLargeFixedWidthInteger<Base>:
ANKLargeFixedWidthInteger, AwesomeSignedLargeFixedWidthInteger<Int> where
Self.Base: AwesomeSignedLargeFixedWidthInteger<Int>,
X64 == Self.Magnitude.X64, X32 == Self.Magnitude.X32 {
    
    associatedtype X64 = Self.Magnitude.X64 // (UInt64, UInt64, ...)
    
    associatedtype X32 = Self.Magnitude.X32 // (UInt32, UInt32, UInt32, UInt32, ...)
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKSignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public static var min: Self {
        Self(bitPattern: Self.Body.min)
    }

    @_transparent public static var max: Self {
        Self(bitPattern: Self.Body.max)
    }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Unsigned
//*============================================================================*

@usableFromInline protocol ANKUnsignedLargeFixedWidthInteger<Base>: ANKLargeFixedWidthInteger,
AwesomeUnsignedLargeFixedWidthInteger<UInt> where Self.High: AwesomeUnsignedLargeFixedWidthInteger<UInt>,
Self.Base == Self.Base.Magnitude { }

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
