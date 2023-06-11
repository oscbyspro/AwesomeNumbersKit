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
// MARK: * ANK x Signed x Text x Radix
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Decode
    //=------------------------------------------------------------------------=
    
    @inlinable public init?(_ description: some StringProtocol, radix: Int = 10) {
        let components = ANK.integerComponents(utf8: description.utf8)
        let body = description[components.body.startIndex ..< components.body.endIndex]
        guard let magnitude = Magnitude(body, radix: radix) else { return nil }
        self.init(magnitude, as: components.sign)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Encode
    //=------------------------------------------------------------------------=
    
    @inlinable public func description(radix: Int = 10, uppercase: Bool = false) -> String {
        let minus  = self.sign == Sign.minus
        let digits = self.magnitude.description(radix: radix, uppercase: uppercase)
        return minus ? "-" + digits : digits
    }
}
