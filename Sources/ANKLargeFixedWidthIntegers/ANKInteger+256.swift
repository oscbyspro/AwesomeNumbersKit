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

@frozen public struct ANKInt256: _ANKSignedLargeFixedWidthInteger {
        
    public typealias Digit = Int
    
    public typealias X64 = Magnitude.X64
    
    public typealias X32 = Magnitude.X32
    
    public typealias Magnitude = ANKUInt256
    
    @usableFromInline typealias Base = ANKInt128
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline var body: Body
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init(bitPattern: Body) {
        self.body = bitPattern
    }
}

//*============================================================================*
// MARK: * ANK x UInt256
//*============================================================================*

@frozen public struct ANKUInt256: _ANKUnsignedLargeFixedWidthInteger {
    
    public typealias Digit = UInt
        
    public typealias X64 = (UInt64, UInt64, UInt64, UInt64)

    public typealias X32 = (UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)
    
    @usableFromInline typealias Base = ANKUInt128
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline var body: Body
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init(bitPattern: Body) {
        self.body = bitPattern
    }
}
