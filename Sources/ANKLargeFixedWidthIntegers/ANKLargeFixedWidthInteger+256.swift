//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Int256
//*============================================================================*

@frozen public struct ANKInt256: ANKSignedLargeFixedWidthInteger {
    
    public typealias Magnitude = UInt256
        
    public typealias X64 = (UInt64, UInt64, UInt64, UInt64)
    
    public typealias X32 = (UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline var body: ANKFullWidth<Int128, UInt128>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(bitPattern: ANKFullWidth<Int128, UInt128>) {
        self.body = bitPattern
    }
}

//*============================================================================*
// MARK: * ANK x UInt256
//*============================================================================*

@frozen public struct ANKUInt256: ANKUnsignedLargeFixedWidthInteger {
    
    public typealias X64 = (UInt64, UInt64, UInt64, UInt64)

    public typealias X32 = (UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline var body: ANKFullWidth<UInt128, UInt128>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(bitPattern: ANKFullWidth<UInt128, UInt128>) {
        self.body = bitPattern
    }
}
