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
/// ```
/// High.bitWidth >= UInt.bitWidth
/// Low .bitWidth >= UInt.bitWidth
/// Self.bitWidth >= UInt.bitWidth *  2
/// ```
///
/// ```
/// High.bitWidth %  UInt.bitWidth == 0
/// Low .bitWidth %  UInt.bitWidth == 0
/// Self.bitWidth %  UInt.bitWidth == 0
/// ```
///
@frozen @usableFromInline struct OBEFullWidth<High, Low>: AwesomeLargeFixedWidthInteger, OBEFullWidthCollection where
High: AwesomeFixedWidthInteger, Low: AwesomeUnsignedFixedWidthInteger, Low == Low.Magnitude {
    
    @usableFromInline typealias IntegerLiteralType = Int
    
    @usableFromInline typealias DoubleWidth = OBEFullWidth<Self, Magnitude>
    
    @usableFromInline typealias Magnitude = OBEFullWidth<High.Magnitude, Low.Magnitude>
        
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable static var min: Self {
        Self(descending:(High.min, Low.min))
    }
    
    @inlinable static var max: Self {
        Self(descending:(High.max, Low.max))
    }
    
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
        self = Self.uninitialized(); for index in indices { self[unchecked: index] = word }
    }
    
    @inlinable static func uninitialized() -> Self {
        self.fromUnsafeWordsAllocation({ _ in })
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init<T>(bitPattern: OBEFullWidth<T, Low>) where T.Magnitude == High.Magnitude {
        self = unsafeBitCast(bitPattern, to: Self.self) // signitude or magnitude
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Conditional Conformances
//*============================================================================*

extension OBEFullWidth:   SignedNumeric where High:   SignedNumeric { }
extension OBEFullWidth:   SignedInteger where High:   SignedInteger { }
extension OBEFullWidth: UnsignedInteger where High: UnsignedInteger { }

extension OBEFullWidth:   AwesomeSignedInteger where High:   AwesomeSignedInteger { }
extension OBEFullWidth: AwesomeUnsignedInteger where High: AwesomeUnsignedInteger { }

extension OBEFullWidth:   AwesomeSignedFixedWidthInteger where High:   AwesomeSignedFixedWidthInteger { }
extension OBEFullWidth: AwesomeUnsignedFixedWidthInteger where High: AwesomeUnsignedFixedWidthInteger { }

extension OBEFullWidth:   AwesomeSignedLargeFixedWidthInteger where High:   AwesomeSignedFixedWidthInteger { }
extension OBEFullWidth: AwesomeUnsignedLargeFixedWidthInteger where High: AwesomeUnsignedFixedWidthInteger { }
