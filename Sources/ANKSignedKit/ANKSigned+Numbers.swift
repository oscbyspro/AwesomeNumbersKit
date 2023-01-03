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
// MARK: * ANK x Signed x Numbers x Integer
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(integerLiteral source: Int) {
        self.init(source)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(_ source: some BinaryInteger) {
        guard let value = Self(exactly: source) else {
            preconditionFailure("\(source) is not in \(Self.self)'s representable range")
        }
        
        self = value
    }
    
    @_transparent public init?(exactly source: some BinaryInteger) {
        //=--------------------------------------=
        // Self
        //=--------------------------------------=
        if  let source = source as? Self {
            self = source
            return
        }
        //=--------------------------------------=
        // TODO: Int
        //=--------------------------------------=
        //=--------------------------------------=
        // TODO: UInt
        //=--------------------------------------=
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(_exactlyAsMagnitude: source)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(_exactlyAsGeneric: source)
    }
    
    @_transparent public init(clamping source: some BinaryInteger) {
        //=--------------------------------------=
        // Self
        //=--------------------------------------=
        if  let source = source as? Self {
            self = source
            return
        }
        //=--------------------------------------=
        // TODO: Int
        //=--------------------------------------=
        //=--------------------------------------=
        // TODO: UInt
        //=--------------------------------------=
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(_clampingAsMagnitude: source)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(_clampingAsGeneric: source)
    }
    
    @_transparent public init(truncatingIfNeeded source: some BinaryInteger) {
        //=--------------------------------------=
        // Self
        //=--------------------------------------=
        if  let source = source as? Self {
            self = source
            return
        }
        //=--------------------------------------=
        // TODO: Int
        //=--------------------------------------=
        //=--------------------------------------=
        // TODO: UInt
        //=--------------------------------------=
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(_truncatingIfNeededAsMagnitude: source)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(_truncatingIfNeededAsGeneric: source)
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Number x Integer x Magnitude
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init?(_exactlyAsMagnitude source: Magnitude) {
        self.init(source, as: .plus)
    }
    
    @_transparent @usableFromInline init(_clampingAsMagnitude source: Magnitude) {
        self.init(source, as: .plus)
    }
    
    @_transparent @usableFromInline init(_truncatingIfNeededAsMagnitude source: Magnitude) {
        self.init(source, as: .plus)
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Numbers x Integer x Generic
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init?<T>(_exactlyAsGeneric source: T) where T: BinaryInteger {
        fatalError("TODO")
    }
    
    @inlinable init<T>(_clampingAsGeneric source: T) where T: BinaryInteger {
        fatalError("TODO")
    }
    
    @inlinable init<T>(_truncatingIfNeededAsGeneric source: T) where T: BinaryInteger {
        fatalError("TODO")
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Numbers x Floating Point
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(_ source: some BinaryFloatingPoint) {
        self.init(exactly: source.rounded(.towardZero))!
    }
    
    @inlinable public init?(exactly source: some BinaryFloatingPoint) {
        fatalError("TODO")
    }
}
