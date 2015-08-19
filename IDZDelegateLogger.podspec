Pod::Spec.new do |s|
  s.name         = "IDZDelegateLogger"
  s.version      = "0.0.3"
  s.summary      = "A class to log all messages sent to an object."

  s.homepage     = "https://github.com/iosdevzone/IDZDelegateLogger"

  s.license      = "MIT"

  s.author             = { "iOS Developer Zone" => "idz@iosdeveloperzone.com" }
  s.social_media_url   = "http://twitter.com/iOSDevZone"

  s.ios.deployment_target = "5.0"
  s.osx.deployment_target = "10.7"

  s.source       = { :git => "https://github.com/iosdevzone/IDZDelegateLogger.git", :tag => s.version.to_s }

  s.source_files  = "IDZDelegateLogger"
  s.public_header_files = "IDZDelegateLogger/*.h"

  s.dependency "IDZInvocation", "~>0.0.5"

end
