Pod::Spec.new do |s|
  s.name             = 'CrashReportKit'
  s.version          = '1.0.0'
  s.summary          = 'Unified Crash Reporting SDK Facade for iOS (Swift).'
  s.description      = <<-DESC
CrashReportKit provides a unified, decoupled crash reporting facade for iOS applications.
Business code only depends on CrashReportKit, and underlying crash vendors (such as Firebase Crashlytics)
can be swapped seamlessly without modifying call sites.
                       DESC

  s.homepage         = 'https://github.com/e-hai/CrashReportKit-iOS'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'e-hai' => 'dev@example.com' }
  s.source           = { :git => 'https://github.com/e-hai/CrashReportKit-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'
  s.osx.deployment_target = '11.0'
  s.tvos.deployment_target = '14.0'
  s.watchos.deployment_target = '7.0'

  s.swift_version    = '5.9'
  s.source_files     = 'Sources/CrashReportKit/**/*'

  s.default_subspecs = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = 'Sources/CrashReportKit/**/*'
  end

  s.subspec 'Firebase' do |ss|
    ss.dependency 'CrashReportKit/Core'
    ss.dependency 'FirebaseCrashlytics', '~> 11.0'
  end
end
