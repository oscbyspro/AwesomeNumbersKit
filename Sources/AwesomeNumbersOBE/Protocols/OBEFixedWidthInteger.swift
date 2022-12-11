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
@usableFromInline protocol OBEFixedWidthInteger: AwesomeFixedWidthInteger,
CustomDebugStringConvertible, OBEFixedWidthIntegerLayout where  Magnitude:
OBEUnsignedFixedWidthInteger, Magnitude.High == High.Magnitude, Magnitude.Low == Low {
    
    associatedtype High: AwesomeFixedWidthInteger
    
    associatedtype Low:  AwesomeUnsignedFixedWidthInteger where Low == High.Magnitude
    
    associatedtype X64 // (UInt64, UInt64, ...)
    
    associatedtype X32 // (UInt32, UInt32, UInt32, UInt32, ...)
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @_hasStorage var _storage: OBEFullWidth<High, Low>
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init() {
        self.init(bitPattern: OBEFullWidth<High, Low>())
    }
    
    @inlinable public init(_ bit: Bool) {
        self.init(bitPattern: OBEFullWidth(bit))
    }
    
    @inlinable public init(repeating bit: Bool) {
        self.init(bitPattern: OBEFullWidth(repeating: bit))
    }
    
    @inlinable public init(x64: X64) {
        self.init(ascending: unsafeBitCast(x64, to: (low: Low, high: High).self))
    }
    
    @inlinable public init(x32: X32) {
        self.init(ascending: unsafeBitCast(x32, to: (low: Low, high: High).self))
    }
    
    @inlinable init(bitPattern: OBEFullWidth<High, Low>) {
        self = unsafeBitCast(bitPattern, to: Self.self)
    }
    
    @inlinable init<T>(bitPattern: T) where T: OBEFixedWidthInteger, T.Low == Low {
        self = unsafeBitCast(bitPattern, to: Self.self) // signitude or magnitude
    }
    
    @inlinable init(ascending digits:(low: Low, high: High)) {
        self.init(bitPattern: OBEFullWidth(ascending: digits))
    }
    
    @inlinable init(descending digits:(high: High, low: Low)) {
        self.init(bitPattern: OBEFullWidth(descending: digits))
    }
        
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var high: High {
        _read   { yield  self._storage.high }
        _modify { yield &self._storage.high }
    }
    
    @inlinable var low:  Low  {
        _read   { yield  self._storage.low  }
        _modify { yield &self._storage.low  }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func reinterpret(_ value: Low) -> High {
        unsafeBitCast(value, to: High.self)
    }
    
    @inlinable static func reinterpret(_ value: High) -> Low {
        unsafeBitCast(value, to: Low.self)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Signed
//*============================================================================*

@usableFromInline protocol OBESignedFixedWidthInteger: OBEFixedWidthInteger, AwesomeSignedFixedWidthInteger { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension OBESignedFixedWidthInteger {
    
    // TODO: these should not be needed
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var zero: Self {
        Self()
    }
    
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

@usableFromInline protocol OBEUnsignedFixedWidthInteger: OBEFixedWidthInteger, AwesomeUnsignedFixedWidthInteger where High == Low { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension OBEUnsignedFixedWidthInteger {
    
    // TODO: these should not be needed
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var zero: Self {
        Self()
    }
    
    @inlinable public static var min: Self {
        Self(descending:(High.min, Low.min))
    }

    @inlinable public static var max: Self {
        Self(descending:(High.max, Low.max))
    }
}