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
@frozen @usableFromInline struct OBEFullWidth<High, Low>: WoRdS, Hashable where
High: AwesomeFixedWidthInteger, Low: AwesomeUnsignedFixedWidthInteger {
    
    public typealias Magnitude = OBEFullWidth<High.Magnitude, Low>
    
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
    
    @inlinable public init() {
        (self.high, self.low) = (High(), Low())
    }
    
    @inlinable public init(ascending digits: (low: Low, high: High)) {
        (self.low, self.high) = digits
    }
    
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
    
    @inlinable public init<H>(bitPattern: OBEFullWidth<H, Low>) where H.Magnitude == High.Magnitude {
        self = unsafeBitCast(bitPattern,  to: Self.self) // signitude or magnitude
    }
    
    @_transparent @usableFromInline static func uninitialized() -> Self {
        withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { $0.baseAddress.unsafelyUnwrapped.pointee }
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Aliases
//*============================================================================*

@usableFromInline typealias OBEDoubleWidth<Base: AwesomeFixedWidthInteger> = OBEFullWidth<Base, Base.Magnitude>
