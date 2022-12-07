//=----------------------------------------------------------------------------=
// This source file is part of the ExtraLargeNumbers open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Full Width
//*============================================================================*

@frozen public struct FullWidth<High, Low> where High: FixedWidthInteger, Low: FixedWidthInteger & UnsignedInteger {
    
    public typealias Magnitude = FullWidth<High.Magnitude, Low>
    
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
    
    /// Creates a new value from perameters of ascending significance.
    ///
    /// - Parameter ascending: a low and high integer with platform endianness
    ///
    @inlinable public init(ascending storage: (low: Low, high: High)) {
        (self.low, self.high) = storage
    }
    
    /// Creates a new value from perameters of descending significance.
    ///
    /// - Parameter descending: a high and low integer with platform endianness
    ///
    @inlinable public init(descending storage: (high: High, low: Low)) {
        (self.high, self.low) = storage
    }
}

//*============================================================================*
// MARK: * Doulbe Width
//*============================================================================*

public typealias DoubleWidth<Base> = FullWidth<Base, Base.Magnitude> where Base: FixedWidthInteger
