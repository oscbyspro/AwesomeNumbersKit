//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKFoundation
import XCTest

//*============================================================================*
// MARK: * Types x Either Int Or UInt
//*============================================================================*

final class TypesTestsOnEitherIntOrUInt: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types = Trivial.allEitherIntOrUIntTypes
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsEitherIntOrUInt() {
        for type: any AwesomeEitherIntOrUInt.Type in types {
            if let _ = type as?  Int.Type { continue }
            if let _ = type as? UInt.Type { continue }
            XCTFail("\(type) is neither Int nor UInt")
        }
    }
}

#endif
