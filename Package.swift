// swift-tools-version: 6.3

import PackageDescription

let package = Package(
  name: "swift-identified-collections",
  platforms: [.iOS(.v15), .watchOS(.v9), .tvOS(.v15), .macOS(.v12), .visionOS(.v26)],
  products: [
    .library(
      name: "IdentifiedCollections",
      targets: ["IdentifiedCollections"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/importRyan/swift-collections", revision: "b166474a4e5053f8d382c95e97de8c237944fcba"),
  ],
  targets: [
    .target(
      name: "IdentifiedCollections",
      dependencies: [
        .product(name: "OrderedCollections", package: "swift-collections")
      ]
    ),
  ],
  swiftLanguageModes: [.v6]
)

#if !os(Windows)
  // DocC needs to be ported to Windows
  // https://github.com/thebrowsercompany/swift-build/issues/39
  package.dependencies.append(
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
  )
#endif

for target in package.targets {
  target.swiftSettings = target.swiftSettings ?? []
  target.swiftSettings?.append(contentsOf: [
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("ImmutableWeakCaptures"),
    .enableUpcomingFeature("InferIsolatedConformances"),
    .enableUpcomingFeature("InternalImportsByDefault"),
    .enableUpcomingFeature("MemberImportVisibility"),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
  ])
}
