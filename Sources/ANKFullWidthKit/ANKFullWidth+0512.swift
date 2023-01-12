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
// MARK: * ANK x (U)Int512
//*============================================================================*

public typealias  ANKInt512 = ANKFullWidth< ANKInt256, ANKUInt256>
public typealias ANKUInt512 = ANKFullWidth<ANKUInt256, ANKUInt256>

//*============================================================================*
// MARK: * ANK x (U)Int512 x X(32/64)
//*============================================================================*

extension ANKFullWidth where Magnitude == ANKUInt512 {
    
    public typealias X64_512 = (
    UInt64, UInt64, UInt64, UInt64, UInt64, UInt64, UInt64, UInt64)
    
    public typealias X32_512 = (
    UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32,
    UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(x64: X64_512) {
        self.init(ascending: unsafeBitCast(x64, to: LH<Low, High>.self))
    }
    
    @_transparent public init(x32: X32_512) {
        self.init(ascending: unsafeBitCast(x32, to: LH<Low, High>.self))
    }
}
