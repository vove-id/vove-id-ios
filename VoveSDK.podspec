Pod::Spec.new do |s|
  s.name          = "VoveSDK"
  s.version       = "0.1.0"
  s.summary       = "VOVE ID - Instant, seamless identity verification. Designed for trust, user-centric, fully compliant with AML/KYC. Optimized for the MEA region."
  s.description   = "Swift, secure digital ID verification tailored for MEA markets. Enhance user onboarding with our AI-powered, biometric-driven platform. Perfect for businesses seeking robust, compliant solutions."
  s.homepage      = "https://www.voveid.com/"
  s.license       = "Apache License, Version 2.0"
  s.author        = "Vove"
  s.platform      = :ios, "11.0"
  s.swift_version = "4.2"
  s.source        = { :git => "https://github.com/VOVE-ID/vove-id-ios.git", :tag => "#{s.version}" }
  s.vendored_frameworks = "VoveSDK.xcframework, FaceTecSDK.xcframework"

end
