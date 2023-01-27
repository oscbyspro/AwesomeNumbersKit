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
// MARK: * ANK x (U)Int128
//*============================================================================*

public typealias  ANKInt192 = ANKFullWidth< ANKInt64, ANKUInt128>
public typealias ANKUInt192 = ANKFullWidth<ANKUInt64, ANKUInt128>

//*============================================================================*
// MARK: * ANK x (U)Int192 x X(32/64)
//*============================================================================*

extension ANKFullWidth where Magnitude == ANKUInt192 {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given tuple.
    ///
    /// - Parameter x64: A tuple of `UInt64` words, from least significant to most.
    ///
    @_transparent public init(x64: ANK192X64) {
        self.init(ascending: unsafeBitCast(x64, to: LH<Low, High>.self))
    }
    
    /// Creates a new instance from the given tuple.
    ///
    /// - Parameter x32: A tuple of `UInt32` words, from least significant to most.
    ///
    @_transparent public init(x32: ANK192X32) {
        self.init(ascending: unsafeBitCast(x32, to: LH<Low, High>.self))
    }
}

//*============================================================================*
// MARK: * ANK x (U)Int192 x Tuples
//*============================================================================*

public typealias ANK192X64 = (UInt64, UInt64, UInt64)

public typealias ANK192X32 = (UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)
