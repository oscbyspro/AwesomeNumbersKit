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
    
    @inlinable public init(_ source: some BinaryInteger) {
        guard let value = Self(exactly: source) else {
            preconditionFailure("\(source) is not in \(Self.self)'s representable range")
        }
        
        self = value
    }
    
    @inlinable public init?(exactly source: some BinaryInteger) {
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(source, as: ANKSign.plus)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        guard let magnitude = Magnitude(exactly: source.magnitude) else { return nil }
        let sign = ANKSign(source < 0)
        self.init(magnitude, as: sign)
    }
    
    @inlinable public init(clamping source: some BinaryInteger) {
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(source, as: ANKSign.plus)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        let sign = ANKSign(source < 0)
        let magnitude = Magnitude(clamping: source.magnitude)
        self.init(magnitude, as: sign)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Literal
//=----------------------------------------------------------------------------=

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(integerLiteral source: Int) {
        self.init(source)
    }
}
