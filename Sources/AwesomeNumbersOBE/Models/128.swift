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
// MARK: * Int128
//*============================================================================*

@frozen public struct Int128: OBESignedFixedWidthInteger {
    
    public typealias Magnitude = UInt128
        
    public typealias X64 = (UInt64, UInt64)
    
    public typealias X32 = (UInt32, UInt32, UInt32, UInt32)
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline var _storage: DoubleWidth<Int64>
}

//*============================================================================*
// MARK: * UInt128
//*============================================================================*

@frozen public struct UInt128: OBEUnsignedFixedWidthInteger {
        
    public typealias X64 = (UInt64, UInt64)
    
    public typealias X32 = (UInt32, UInt32, UInt32, UInt32)
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline var _storage: DoubleWidth<UInt64>
}
