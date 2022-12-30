//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Int128
//*============================================================================*

@frozen public struct ANKInt128: _ANKSignedLargeFixedWidthInteger {
    
    public typealias Digit = Int
    
    public typealias X64 = Magnitude.X64
    
    public typealias X32 = Magnitude.X32
    
    public typealias BitPattern = Magnitude
        
    public typealias Magnitude = ANKUInt128
    
    @usableFromInline typealias Base = ANKInt64
    
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
// MARK: * ANK x UInt128
//*============================================================================*

@frozen public struct ANKUInt128: _ANKUnsignedLargeFixedWidthInteger {
        
    public typealias Digit = UInt
    
    public typealias X64 = (UInt64, UInt64)
    
    public typealias X32 = (UInt32, UInt32, UInt32, UInt32)
    
    public typealias BitPattern = Magnitude
        
    public typealias Magnitude = ANKUInt128
    
    @usableFromInline typealias Base = ANKUInt64
    
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
