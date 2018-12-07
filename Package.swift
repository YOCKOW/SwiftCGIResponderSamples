// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let versionOfSwiftCGIResponder: Version = "0.2.0-dev20181207"

let samples: [String?] = [
  "WithoutLibrary", // CRS-0000
  "SimpleCGI", // CRS-0001
]

private extension Int {
  var label: String { return String(format:"CRS-%04d", self) }
}

/// Products to be passed to initializer of `Package`
var products: [Product] = []
for ii in 0..<samples.count {
  guard let _ = samples[ii] else { continue }
  let label = ii.label
  products.append(.executable(name:label, targets:[label]))
}

/// Targets to be passed to initializer of `Package`
var targets: [Target] = []
for ii in 0..<samples.count {
  guard let name = samples[ii] else { continue }
  let label = ii.label
  targets.append(
    .target(name:label,
            dependencies:["SwiftCGIResponder"],
            path:"Sources/\(label)_\(name)")
  )
}

/// No tests are available with executables,
///   because of [SR-1503](https://bugs.swift.org/browse/SR-1503).
/// That is, this "test target" is dummy.
var testDependencies: [Target.Dependency] = []
/*
for ii in 0..<samples.count {
  guard let _ = samples[ii] else { continue }
  testDependencies.append(.target(name:ii.label))
}
 */
targets.append(
  .testTarget(name:"CGIResponderSamplesTests",
              dependencies:testDependencies,
              path:"Tests/CGIResponderSamplesTests")
)

// Package
let package = Package(
  name: "CGIResponderSamples",
  products:products,
  dependencies: [
    .package(url:"https://github.com/YOCKOW/SwiftCGIResponder.git", from:versionOfSwiftCGIResponder),
  ],
  targets:targets,
  swiftLanguageVersions:[.v4, .v4_2]
)
