//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKCoreKit
@testable import ANKFullWidthKit
import XCTest

//*============================================================================*
// MARK: * ANK x Radix UInt Root
//*============================================================================*

final class RadixUIntRootTests: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let radices = UInt(2) ... 36
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testTheGeneralCaseAlgorithmAlsoSolvesPowerOf2() {
        for radix in self.radices where radix.isPowerOf2 {
            let special = AnyRadixUIntRoot.solutionAssumingRadixIsPowerOf2(radix)
            let general = AnyRadixUIntRoot.solutionAssumingRadixIsWhatever(radix)
            XCTAssert(general == special)
        }
    }
}

#endif
