//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Stdlib x Text x Decode
//*============================================================================*

extension Swift.FixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    static func stdlib(_ source: some StringProtocol, radix: Int = 10) -> Self? {
        Self(source, radix: radix)
    }
}

//*============================================================================*
// MARK: * ANK x Stdlib x Text x Encode
//*============================================================================*

extension Swift.String {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    static func stdlib(_ source: some BinaryInteger, radix: Int = 10, uppercase: Bool = false) -> Self {
        Self(source, radix: radix, uppercase: uppercase)
    }
}
