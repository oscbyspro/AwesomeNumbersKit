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
/// - `High.bitWidth >= UInt.bitWidth`
/// - `Low .bitWidth >= UInt.bitWidth`
/// - `Self.bitWidth >= UInt.bitWidth * 2`
///
/// - `High.bitWidth` must be an integer multiple of `UInt.bitWidth`
/// - `Low .bitWidth` must be an integer multiple of `UInt.bitWidth`
/// - `Self.bitWidth` must be an integer multiple of `UInt.bitWidth`
///
@frozen @usableFromInline struct OBEFullWidth<High, Low>: Hashable where
High: AwesomeFixedWidthInteger, Low: AwesomeUnsignedFixedWidthInteger {
    
    public typealias Magnitude = OBEFullWidth<High.Magnitude, Low>
    
    @usableFromInline typealias Reader  = OBEFullWidthLittleEndianReader <High, Low>
    
    @usableFromInline typealias Mutator = OBEFullWidthLittleEndianMutator<High, Low>
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var isSigned: Bool {
        High.isSigned
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
    
    /// Creates a new value equal to zero.
    ///
    @inlinable public init() {
        (self.high, self.low) = (High(), Low())
    }
    
    /// Creates a new value from digits of ascending significance.
    ///
    /// - Parameter ascending: a low and high integer with platform endianness
    ///
    @inlinable public init(ascending digits: (low: Low, high: High)) {
        (self.low, self.high) = digits
    }
    
    /// Creates a new value from digits of descending significance.
    ///
    /// - Parameter descending: a high and low integer with platform endianness
    ///
    @inlinable public init(descending digits: (high: High, low: Low)) {
        (self.high, self.low) = digits
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(_ bit: Bool) {
        self.init(descending:(High(), Low(bit)))
    }
    
    @inlinable public init(repeating bit: Bool) {
        self.init(descending:(High(repeating: bit), Low(repeating: bit)))
    }
    
    @inlinable init<H>(bitPattern: OBEFullWidth<H, Low>) where H.Magnitude == High.Magnitude {
        self = unsafeBitCast(bitPattern,  to: Self.self) // signitude or magnitude
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Aliases
//*============================================================================*

@usableFromInline typealias OBEDoubleWidth<Base: AwesomeFixedWidthInteger> = OBEFullWidth<Base, Base.Magnitude>
