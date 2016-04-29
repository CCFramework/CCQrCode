#
#  Be sure to run `pod spec lint CCQrCode.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.name         = "CCQrCode"
s.version      = "1.0"
s.summary      = "AVFoundation encapsulation of qr code scanning tools, support for multiple type code."
s.homepage     = "https://github.com/CCFramework/CCQrCode"

s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "MuZiLee" => "li.feiheng@gmail.com" }
s.platform     = :ios, "7.0"
s.source       = { :git => "https://github.com/CCFramework/CCQrCode.git", :tag => "v1.0" }
s.source_files  = "CCQrCode", "CCQrCode/*.{h,m}","CCQrCode/*.{wav}","CCQrCode/*.{xcassets}"

s.framework  = "AVFoundation","AudioToolbox"

s.requires_arc = true


end
