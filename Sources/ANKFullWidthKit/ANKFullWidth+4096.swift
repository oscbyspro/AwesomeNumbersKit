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
// MARK: * ANK x [U]Int4096
//*============================================================================*

/// A 4096-bit signed integer value type.
public typealias ANKInt4096 = ANKFullWidth<ANKInt2048, ANKUInt2048>

/// A 4096-bit unsigned integer value type.
public typealias ANKUInt4096 = ANKFullWidth<ANKUInt2048, ANKUInt2048>
