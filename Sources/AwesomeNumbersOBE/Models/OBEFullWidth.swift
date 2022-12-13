//=----------------------------------------------------------------------------=
// This source file is part of the ExtraLargeNumbers open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import AwesomeNumbersKit

//*============================================================================*
// MARK: * OBE x Full Width
//*============================================================================*

/// The internal storage model for `(U)Int(128/256/512)`.
///
/// It behaves as if it were an integer, without conforming to such protocols.
///
/// - `High.bitWidth >= UInt.bitWidth`
/// - `Low .bitWidth >= UInt.bitWidth`
/// - `Self.bitWidth >= UInt.bitWidth * 2`
///
/// - `High.bitWidth` must be an integer multiple of `UInt.bitWidth`
/// - `Low .bitWidth` must be an integer multiple of `UInt.bitWidth`
/// - `Self.bitWidth` must be an integer multiple of `UInt.bitWidth`
///
@frozen @usableFromInline struct OBEFullWidth<High, Low>: Comparable, Hashable, WoRdS where
High: Comparable & Hashable, Low: Comparable & Hashable {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    #if _endian(big)
    public var high: High
    public var low:  Low
    #else
    public var low:  Low
    public var high: High
    #endif
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(ascending digits: (low: Low, high: High)) {
        (self.low, self.high) = digits
    }
    
    @inlinable public init(descending digits: (high: High, low: Low)) {
        (self.high, self.low) = digits
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init() {
        self.init(repeating: UInt())
    }
    
    @inlinable init(repeating bit: Bool) {
        self.init(repeating: UInt(repeating: bit))
    }
    
    @inlinable init(repeating word: UInt) {
        self = Self.uninitialized(); for index in self.indices { self[unchecked: index] = word }
    }
    
    @_transparent @usableFromInline static func uninitialized() -> Self {
        withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { $0.baseAddress.unsafelyUnwrapped.pointee }
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Aliases
//*============================================================================*

@usableFromInline typealias OBEFullWidthInteger<High, Low> =
OBEFullWidth<High, Low> where High: AwesomeFixedWidthInteger, Low: AwesomeUnsignedFixedWidthInteger

@usableFromInline typealias OBEDoubleWidthInteger<Base> =
OBEFullWidth<Base, Base.Magnitude> where Base: AwesomeFixedWidthInteger

//*============================================================================*
// MARK: * OBE x Full Width x Integer
//*============================================================================*

extension OBEFullWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init<H>(bitPattern: OBEFullWidthInteger<H, Low>) where H.Magnitude == High.Magnitude {
        self = unsafeBitCast(bitPattern, to: Self.self) // signitude or magnitude
    }
}
