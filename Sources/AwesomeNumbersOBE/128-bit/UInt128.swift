//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * UInt128
//*============================================================================*

@frozen public struct UInt128 {
    
    public typealias Magnitude = UInt128
    public typealias X64 = (UInt64, UInt64)
    public typealias X32 = (UInt32, UInt32, UInt32, UInt32)
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline var _storage: DoubleWidth<UInt64>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new value equal to zero.
    ///
    @inlinable public init() {
        self._storage = DoubleWidth()
    }
    
    /// Creates a new value from digits of ascending significance.
    ///
    /// - Parameter x64: a tuple of `UInt64` digits
    ///
    @inlinable public init(x64: X64) {
        self._storage = DoubleWidth(ascending:(x64.0, x64.1))
    }
    
    /// Creates a new value from digits of ascending significance.
    ///
    /// - Parameter x32: a tuple of `UInt32` digits
    ///
    @inlinable public init(x32: X32) {
        self.init(x64: Swift.unsafeBitCast(x32, to: X64.self))
    }
}
