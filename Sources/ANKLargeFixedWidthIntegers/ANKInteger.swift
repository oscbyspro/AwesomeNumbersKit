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
// MARK: * ANK x Integer
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
@usableFromInline protocol _ANKLargeFixedWidthInteger<Base>: ANKBitPattern,
ANKLargeFixedWidthInteger, ANKTextualizableInteger, CustomDebugStringConvertible where
Magnitude: _ANKUnsignedLargeFixedWidthInteger<Base.Magnitude> {
    
    associatedtype X64 = Never // (UInt64, UInt64, ...)
    
    associatedtype X32 = Never // (UInt32, UInt32, UInt32, UInt32, ...)
    
    associatedtype Base: ANKLargeFixedWidthInteger where Base.Digit: ANKIntOrUInt, Digit == Base.Digit
    
    associatedtype BitPattern: ANKBitPattern = Magnitude
    
    typealias High = Base
    
    typealias Low  = Base.Magnitude
    
    typealias Body = _ANKFullWidth<Base, Base.Magnitude>
    
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

extension _ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init() {
        self.init(bitPattern: Body())
    }
    
    @_transparent public init(bit: Bool) {
        self.init(bitPattern: Body(bit: bit))
    }
    
    @_transparent public init(digit: Digit) {
        self.init(bitPattern: Body(digit: digit))
    }
    
    @_transparent public init(repeating bit: Bool) {
        self.init(bitPattern: Body(repeating: bit))
    }
    
    @_transparent public init(repeating word: UInt) {
        self.init(bitPattern: Body(repeating: word))
    }    
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init(ascending  digits: LH<Low, High>) {
        self.init(bitPattern: Body(ascending: digits))
    }
    
    @_transparent @usableFromInline init(descending digits: HL<High, Low>) {
        self.init(bitPattern: Body(descending: digits))
    }
    
    @_transparent public init(x64: X64) {
        self.init(bitPattern: Body(ascending: unsafeBitCast(x64, to: LH<Low, High>.self)))
    }
    
    @_transparent public init(x32: X32) {
        self.init(bitPattern: Body(ascending: unsafeBitCast(x32, to: LH<Low, High>.self)))
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
    // MARK: Details x Bit Pattern
    //=------------------------------------------------------------------------=
    
    @_transparent public init(bitPattern source: Magnitude) {
        self.init(bitPattern: Body(bitPattern: source.body))
    }
        
    @_transparent public var bitPattern: Magnitude {
        Magnitude(bitPattern: Magnitude.Body(bitPattern: self.body))
    }
}

//*============================================================================*
// MARK: * ANK x Integer x Signed
//*============================================================================*

@usableFromInline protocol _ANKSignedLargeFixedWidthInteger<Base>:
_ANKLargeFixedWidthInteger, ANKSignedLargeFixedWidthInteger<Int> where
Base: ANKSignedLargeFixedWidthInteger<Int> { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension _ANKSignedLargeFixedWidthInteger {
    
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
// MARK: * ANK x Integer x Unsigned
//*============================================================================*

@usableFromInline protocol _ANKUnsignedLargeFixedWidthInteger<Base>:
_ANKLargeFixedWidthInteger, ANKUnsignedLargeFixedWidthInteger<UInt> where
Base: ANKUnsignedLargeFixedWidthInteger<UInt>, Base == Base.Magnitude { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension _ANKUnsignedLargeFixedWidthInteger {
    
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
