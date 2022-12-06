// swift-tools-version: 5.7
//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import PackageDescription

//*============================================================================*
// MARK: * AwesomeNumbersKit
//*============================================================================*

let package = Package(
    name: "AwesomeNumbersKit",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        //=--------------------------------------=
        // AwesomeNumbersKit
        //=--------------------------------------=
        .library(
            name: "AwesomeNumbersKit",
            targets: ["AwesomeNumbersKit"]),
    ],
    targets: [
        //=--------------------------------------=
        // AwesomeNumbersKit
        //=--------------------------------------=
        .target(
        name: "AwesomeNumbersKit",
        dependencies: []),
        .testTarget(
        name: "AwesomeNumbersKitTests",
        dependencies: ["AwesomeNumbersKit"]),
    ]
)
