//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Int128
//*============================================================================*

@frozen public struct Int128: OBESignedLargeFixedWidthInteger {
    
    public typealias Magnitude = UInt128
        
    public typealias X64 = (UInt64, UInt64)
    
    public typealias X32 = (UInt32, UInt32, UInt32, UInt32)
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline var body: OBEFullWidth<Int64, UInt64>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(bitPattern: OBEFullWidth<Int64, UInt64>) {
        self.body = bitPattern
    }
}

//*============================================================================*
// MARK: * UInt128
//*============================================================================*

@frozen public struct UInt128: OBEUnsignedLargeFixedWidthInteger {
    
    public typealias X64 = (UInt64, UInt64)
    
    public typealias X32 = (UInt32, UInt32, UInt32, UInt32)
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline var body: OBEFullWidth<UInt64, UInt64>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(bitPattern: OBEFullWidth<UInt64, UInt64>) {
        self.body = bitPattern
    }
}
