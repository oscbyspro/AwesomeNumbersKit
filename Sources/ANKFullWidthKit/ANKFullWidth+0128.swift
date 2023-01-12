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

public typealias  ANKInt128 = ANKFullWidth< ANKInt64, ANKUInt64>
public typealias ANKUInt128 = ANKFullWidth<ANKUInt64, ANKUInt64>

//*============================================================================*
// MARK: * ANK x (U)Int128 x X(32/64)
//*============================================================================*

extension ANKFullWidth where Magnitude == ANKUInt128 {
    
    public typealias X64_128 = (UInt64, UInt64)
    
    public typealias X32_128 = (UInt32, UInt32, UInt32, UInt32)
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(x64: X64_128) {
        self.init(ascending: unsafeBitCast(x64, to: LH<Low, High>.self))
    }
    
    @_transparent public init(x32: X32_128) {
        self.init(ascending: unsafeBitCast(x32, to: LH<Low, High>.self))
    }
}
