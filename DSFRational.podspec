Pod::Spec.new do |s|
  s.name         = "DSFRational"
  s.version      = "1.0"
  s.summary      = "An extension for floating point values to return the rational components for that value"
  s.description  = <<-DESC
    An extension for floating point values to return the rational components for that value
  DESC
  s.homepage     = "https://github.com/dagronf"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Darren Ford" => "dford_au-reg@yahoo.com" }
  s.social_media_url   = ""
  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "11.4"
  s.tvos.deployment_target = "11.4"
  s.source       = { :git => ".git", :tag => s.version.to_s }
  s.subspec "Core" do |ss|
    ss.source_files  = "Sources/DSFRational/**/*.swift"
  end

  s.osx.framework  = 'AppKit'
  s.ios.framework  = 'UIKit'
  s.tvos.framework  = 'UIKit'
  s.swift_version = "5.0"
end
