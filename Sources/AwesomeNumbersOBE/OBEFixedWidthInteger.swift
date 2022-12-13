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
// MARK: * OBE x Fixed Width Integer
//*============================================================================*

/// A fixed width integer implementation protocol.
///
/// - It must be safe to bit cast between `High` and `Low`.
/// - It must be safe to bit cast between `Self` and `Magnitude`.
///
@usableFromInline protocol OBEFixedWidthInteger:  AwesomeFixedWidthInteger,
CustomDebugStringConvertible where Magnitude: OBEUnsignedFixedWidthInteger,
Magnitude.High == High.Magnitude,  Magnitude.Low == Low {
    
    associatedtype X64 // (UInt64, UInt64, ...)
    
    associatedtype X32 // (UInt32, UInt32, UInt32, UInt32, ...)
    
    associatedtype High: AwesomeFixedWidthInteger
    
    typealias Low  = High.Magnitude // double width
    
    typealias Body = OBEFullWidth<High, Low>
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @inlinable var body: Body { get set }
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(bitPattern: OBEFullWidth<High, Low>) {
        self = unsafeBitCast(bitPattern,  to: Self.self)
    }
    
    @inlinable init<T>(bitPattern: T) where T: OBEFixedWidthInteger, T.Magnitude == Magnitude {
        self.init(bitPattern: Body(bitPattern: bitPattern.body))
    }
    
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
// MARK: * OBE x Fixed Width Integer x Signed
//*============================================================================*

@usableFromInline protocol OBESignedFixedWidthInteger: OBEFixedWidthInteger,
AwesomeSignedFixedWidthInteger where High: AwesomeSignedFixedWidthInteger { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension OBESignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var min: Self {
        Self(descending:(High.min, Low.min))
    }

    @inlinable public static var max: Self {
        Self(descending:(High.max, Low.max))
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Unsigned
//*============================================================================*

@usableFromInline protocol OBEUnsignedFixedWidthInteger: OBEFixedWidthInteger,
AwesomeUnsignedFixedWidthInteger where High == Low { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension OBEUnsignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var min: Self {
        Self(descending:(High.min, Low.min))
    }

    @inlinable public static var max: Self {
        Self(descending:(High.max, Low.max))
    }
}
