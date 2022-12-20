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
    
    associatedtype High: AwesomeFixedWidthInteger
        
    associatedtype Low:  AwesomeUnsignedFixedWidthInteger where Low == Low.Magnitude
    
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
    
    @inlinable public init() {
        self.init(bitPattern: Body())
    }
    
    @inlinable public init(_ bit: Bool) {
        self.init(bitPattern: Body(bit))
    }
    
    @inlinable public init(repeating bit: Bool) {
        self.init(bitPattern: Body(repeating: bit))
    }
    
    @inlinable public init(repeating word: UInt) {
        self.init(bitPattern: Body(repeating: word))
    }
    
    @inlinable public init(x64: X64) {
        self.init(bitPattern: Body(ascending: unsafeBitCast(x64, to: (low: Low, high: High).self)))
    }
    
    @inlinable public init(x32: X32) {
        self.init(bitPattern: Body(ascending: unsafeBitCast(x32, to: (low: Low, high: High).self)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(ascending digits:(low: Low, high: High)) {
        self.init(bitPattern: Body(ascending: digits))
    }
    
    @inlinable init(descending digits:(high: High, low: Low)) {
        self.init(bitPattern: Body(descending: digits))
    }
    
    @inlinable static func uninitialized() -> Self {
        self.init(bitPattern: Body.uninitialized())
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init<T>(bitPattern: ANKFullWidth<T, Low>) where T.Magnitude == High.Magnitude {
        self.init(bitPattern: Body(bitPattern: bitPattern)) // signitude or magnitude
    }
    
    @inlinable init<T>(bitPattern: T) where T: ANKLargeFixedWidthInteger, T.Magnitude == Self.Magnitude {
        self.init(bitPattern: Body(bitPattern: bitPattern.body)) // signitude or magnitude
    }
        
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var zero: Self {
        Self()
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
    
    @inlinable static func reinterpret(_ value: Low) -> High {
        unsafeBitCast(value, to: High.self)
    }
    
    @inlinable static func reinterpret(_ value: High) -> Low {
        unsafeBitCast(value, to: Low .self)
    }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Signed
//*============================================================================*

@usableFromInline protocol ANKSignedLargeFixedWidthInteger<High, Low>: ANKLargeFixedWidthInteger,
AwesomeSignedLargeFixedWidthInteger where High: AwesomeSignedFixedWidthInteger { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKSignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var min: Self {
        Self(bitPattern: Body.min)
    }

    @inlinable public static var max: Self {
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
    
    @inlinable public static var min: Self {
        Self(bitPattern: Body.min)
    }

    @inlinable public static var max: Self {
        Self(bitPattern: Body.max)
    }
}
