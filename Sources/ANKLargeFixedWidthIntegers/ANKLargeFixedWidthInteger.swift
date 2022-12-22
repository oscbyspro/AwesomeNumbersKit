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
    
    typealias Body = ANKFullWidth<Base, Base.Magnitude>
        
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
        self.init(bitPattern: Self.Body(ascending: unsafeBitCast(x64, to: LH<Self.Low, Self.High>.self)))
    }
    
    @_transparent public init(x32: X32) {
        self.init(bitPattern: Self.Body(ascending: unsafeBitCast(x32, to: LH<Self.Low, Self.High>.self)))
    }
    
    @_transparent @usableFromInline static func uninitialized() -> Self {
        self.init(bitPattern: Self.Body.uninitialized())
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init(ascending  digits: LH<Self.Low, Self.High>) {
        self.init(bitPattern: Self.Body(ascending: digits))
    }
    
    @_transparent @usableFromInline init(descending digits: HL<Self.High, Self.Low>) {
        self.init(bitPattern: Self.Body(descending: digits))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init<T>(bitPattern: ANKFullWidth<T, T.Magnitude>) where T.Magnitude == Base.Magnitude {
        self.init(bitPattern: Body(bitPattern: bitPattern))
    }
    
    @_transparent @usableFromInline init<T>(bitPattern: T) where T: ANKLargeFixedWidthInteger, T.Magnitude == Magnitude {
        self.init(bitPattern: Body(bitPattern: bitPattern.body))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public static var zero: Self {
        Self(bitPattern: Self.Body.zero)
    }
    
    @usableFromInline var high: Self.High {
        @_transparent _read   { yield  self.body.high }
        @_transparent _modify { yield &self.body.high }
    }
    
    @usableFromInline var low:  Self.Low  {
        @_transparent _read   { yield  self.body.low  }
        @_transparent _modify { yield &self.body.low  }
    }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Signed
//*============================================================================*

@usableFromInline protocol ANKSignedLargeFixedWidthInteger<Base>:
ANKLargeFixedWidthInteger, AwesomeSignedLargeFixedWidthInteger<Int> where
Base: AwesomeSignedLargeFixedWidthInteger<Int>,
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
AwesomeUnsignedLargeFixedWidthInteger<UInt> where Self.Base: AwesomeUnsignedLargeFixedWidthInteger<UInt>,
Self.Base == Self.Base.Magnitude { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKUnsignedLargeFixedWidthInteger {
    
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
