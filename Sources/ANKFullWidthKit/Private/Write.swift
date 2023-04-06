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
// MARK: * ANK x Write
//*============================================================================*

extension UnsafeMutableBufferPointer<UInt8> {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func write(_ element: Element, from index: inout Index) {
        self[index] = element
        self.formIndex(after: &index)
    }
    
    @inlinable func write(_ content: some Sequence<Element>, from index: inout Index) {
        for element in content {
            self.write(element, from: &index)
        }
    }
}
