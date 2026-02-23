Pod::Spec.new do |s|
  s.name          = "VoveSDK"
  s.version      = "1.7.0"
  s.summary       = "Verify once, Verify everywhere."
  s.description   = "VOVE ID - Instant, seamless identity verification. Designed for trust, user-centric, fully compliant with AML/KYC. Optimized for the MEA region."
  s.homepage      = "https://www.voveid.com/"
  s.license       = "Apache License, Version 2.0"
  s.author        = "Vove"
  s.platform      = :ios, "11.0"
  s.swift_version = "4.2"
  s.source        = { :git => "https://github.com/VOVE-ID/vove-id-ios.git", :tag => "#{s.version}" }
  s.vendored_frameworks = "VoveSDK.xcframework", "FaceTecSDK.xcframework"
  s.xcconfig = {
    "CLANG_MODULES_AUTOLINK" => "YES",
  }

end
