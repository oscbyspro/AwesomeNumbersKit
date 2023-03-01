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
// MARK: * ANK x [U]Int1024
//*============================================================================*

/// A 1024-bit signed integer value type.
public typealias ANKInt1024 = ANKFullWidth<ANKInt512, ANKUInt512>

/// A 1024-bit unsigned integer value type.
public typealias ANKUInt1024 = ANKFullWidth<ANKUInt512, ANKUInt512>
