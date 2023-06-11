//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit

//*============================================================================*
// MARK: * ANK x Signed x Numbers x Decode
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(integerLiteral source: Int) {
        self.init(source)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(digit: Digit) {
        let sign = digit.sign
        let magnitude = Magnitude(digit: digit.magnitude)
        self.init(magnitude, as: sign)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(_ source: some BinaryInteger) {
        guard let value = Self(exactly: source) else {
            preconditionFailure("\(Self.self) cannot represent \(source)")
        }
        
        self = value
    }
    
    @inlinable public init?(exactly source: some BinaryInteger) {
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(source, as: FloatingPointSign.plus)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        let sign = Sign(source < 0)
        guard let magnitude = Magnitude(exactly: source.magnitude) else { return nil }
        self.init(magnitude, as: sign)
    }
    
    @inlinable public init(clamping source: some BinaryInteger) {
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(source, as: FloatingPointSign.plus)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        let sign = Sign(source < 0)
        let magnitude = Magnitude(clamping: source.magnitude)
        self.init(magnitude, as: sign)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Fixed Width
//=----------------------------------------------------------------------------=

extension ANKSigned where Magnitude: ANKFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// The minimum representable value in this type.
    @inlinable public static var min: Self {
        Self(Magnitude.max, as: Sign.minus)
    }
    
    /// The maximum representable value in this type.
    @inlinable public static var max: Self {
        Self(Magnitude.max, as: Sign.plus)
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Numbers x Encode
//*============================================================================*

extension ANKFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(_ source: ANKSigned<Magnitude>) {
        guard let value = Self(exactly: source) else {
            preconditionFailure("\(Self.self) cannot represent \(source)")
        }
        
        self = value
    }
    
    @inlinable public init?(exactly source: ANKSigned<Magnitude>) {
        if let value = Self.exactly(sign: source.sign, magnitude: source.magnitude) { self = value } else { return nil }
    }
    
    @inlinable public init(clamping source: ANKSigned<Magnitude>) {
        self = Self.clamping(sign: source.sign, magnitude: source.magnitude)
    }
}
