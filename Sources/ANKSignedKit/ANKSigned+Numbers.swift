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
// MARK: * ANK x Signed x Numbers x Integer x Decode
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
    
    @inlinable public init(_ source: some BinaryInteger) {
        guard let value = Self(exactly: source) else {
            preconditionFailure("\(source) is not in \(Self.self)'s representable range")
        }
        
        self = value
    }
    
    @inlinable public init?(exactly source: some BinaryInteger) {
        //=--------------------------------------=
        // Self
        //=--------------------------------------=
        if  let source = source as? Self {
            self = source
            return
        }
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(_exactlyAsSignMagnitude: source)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(_exactlyAsBinaryInteger: source)
    }
    
    @inlinable public init(clamping source: some BinaryInteger) {
        //=--------------------------------------=
        // Self
        //=--------------------------------------=
        if  let source = source as? Self {
            self = source
            return
        }
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(_clampingAsSignMagnitude: source)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(_clampingAsBinaryInteger: source)
    }
    
    @inlinable public init(truncatingIfNeeded source: some BinaryInteger) {
        //=--------------------------------------=
        // Self
        //=--------------------------------------=
        if  let source = source as? Self {
            self = source
            return
        }
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(_truncatingIfNeededAsSignMagnitude: source)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(_truncatingIfNeededAsBinaryInteger: source)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Magnitude
//=----------------------------------------------------------------------------=

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init?(_exactlyAsSignMagnitude source: Magnitude) {
        self.init(source, as: .plus)
    }
    
    @_transparent @usableFromInline init(_clampingAsSignMagnitude source: Magnitude) {
        self.init(source, as: .plus)
    }
    
    @_transparent @usableFromInline init(_truncatingIfNeededAsSignMagnitude source: Magnitude) {
        self.init(source, as: .plus)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Binary Integer
//=----------------------------------------------------------------------------=

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init?<T>(_exactlyAsBinaryInteger source: T) where T: BinaryInteger {
        let sign = ANKSign(source < 0)
        guard let magnitude = Magnitude(exactly: source.magnitude) else { return nil }
        self.init(magnitude, as: sign)
    }
    
    @inlinable init<T>(_clampingAsBinaryInteger source: T) where T: BinaryInteger {
        let sign = ANKSign(source < 0)
        let magnitude = Magnitude(clamping: source.magnitude)
        self.init(magnitude, as: sign)
    }
    
    @inlinable init<T>(_truncatingIfNeededAsBinaryInteger source: T) where T: BinaryInteger {
        fatalError("TODO")
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Numbers x Integer x Encode
//*============================================================================*

extension ANKBinaryInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(_ source: ANKSigned<Magnitude>) {
        self.init(asSignMagnitude: source.magnitude, uncheckedIsLessThanZero: source.isLessThanZero)
    }
    
    @inlinable init?(exactly source: ANKSigned<Magnitude>) {
        self.init(exactlyAsSignMagnitude: source.magnitude, uncheckedIsLessThanZero: source.isLessThanZero)
    }
    
    @inlinable init(clamping source: ANKSigned<Magnitude>) {
        self.init(clampingAsSignMagnitude: source.magnitude, uncheckedIsLessThanZero: source.isLessThanZero)
    }
    
    @inlinable init(truncatingIfNeeded source: ANKSigned<Magnitude>) {
        self.init(truncatingIfNeededAsSignMagnitude: source.magnitude, uncheckedIsLessThanZero: source.isLessThanZero)
    }
}
