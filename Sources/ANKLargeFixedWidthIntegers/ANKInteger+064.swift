//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=
//=----------------------------------------------------------------------------=
// await compiler condition akin to #if MemoryLayout<UInt>.size == 8
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Int64
//*============================================================================*
//=----------------------------------------------------------------------------=
// MARK: + 32-bit
//=----------------------------------------------------------------------------=

#if arch(i386) || arch(arm) || arch(arm64_32) || arch(wasm32) || arch(powerpc)

@frozen @usableFromInline struct ANKInt64: _ANKUnsignedLargeFixedWidthInteger {
    
    public typealias Digit = Int
    
    public typealias X64 = Magnitude.X64
    
    public typealias X32 = Magnitude.X32
    
    public typealias Magnitude = ANKUInt64
    
    @usableFromInline typealias Base = Int
    
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

//=----------------------------------------------------------------------------=
// MARK: + 64-bit
//=----------------------------------------------------------------------------=

#elseif arch(x86_64) || arch(arm64) || arch(powerpc64) || arch(powerpc64le) || arch(s390x)

@usableFromInline typealias ANKInt64 = Int

//=----------------------------------------------------------------------------=
// MARK: + 💥💥💥
//=----------------------------------------------------------------------------=

#else

@usableFromInline typealias ANKInt64 = Never

#endif

//*============================================================================*
// MARK: * ANK x UInt64
//*============================================================================*
//=----------------------------------------------------------------------------=
// MARK: + 32-bit
//=----------------------------------------------------------------------------=

#if arch(i386) || arch(arm) || arch(arm64_32) || arch(wasm32) || arch(powerpc)

@frozen @usableFromInline struct ANKUInt64: _ANKUnsignedLargeFixedWidthInteger {
    
    public typealias Digit = UInt
    
    public typealias X64 = (UInt64)
    
    public typealias X32 = (UInt32, UInt32)
    
    @usableFromInline typealias Base = UInt
    
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

//=----------------------------------------------------------------------------=
// MARK: + 64-bit
//=----------------------------------------------------------------------------=

#elseif arch(x86_64) || arch(arm64) || arch(powerpc64) || arch(powerpc64le) || arch(s390x)

@usableFromInline typealias ANKUInt64 = UInt

//=----------------------------------------------------------------------------=
// MARK: + 💥💥💥
//=----------------------------------------------------------------------------=

#else

@usableFromInline typealias ANKUInt64 = Never

#endif
