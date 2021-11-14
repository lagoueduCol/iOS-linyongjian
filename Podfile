source 'https://cdn.cocoapods.org/'

workspace './Moments.xcworkspace'
project './Moments/Moments.xcodeproj'

platform :ios, '14.0'
use_frameworks!

# ignore all warnings from all dependencies
inhibit_all_warnings!

def dev_pods
  pod 'SwiftLint', '= 0.42.0', configurations: ['Debug']
  pod 'SwiftGen', '= 6.4.0', configurations: ['Debug']
end

def core_pods
  pod 'RxSwift', '= 6.2.0'
  pod 'RxRelay', '= 6.2.0'
  pod 'Alamofire', '= 5.3.0'
end

def thirdparty_pods
  pod 'Firebase/Analytics', '= 7.0.0'
  pod 'Firebase/Crashlytics', '= 7.0.0'
  pod 'Firebase/RemoteConfig', '= 7.0.0'
  pod 'Firebase/Performance', '= 7.0.0'
end

def ui_pods
  pod 'SnapKit', '= 5.0.1'
  pod 'Kingfisher', '= 5.15.6'
  pod 'RxCocoa', '= 6.2.0'
  pod 'RxDataSources', '= 5.0.0'
end

def internal_pods
  pod 'DesignKit', :path => './Frameworks/DesignKit', :inhibit_warnings => false 
end

def test_pods
  pod 'Quick', '= 3.0.0'
  pod 'Nimble', '= 9.0.0'
  pod 'RxTest', '= 6.2.0'
  pod 'RxBlocking', '= 6.2.0'
end

target 'Moments' do
  dev_pods
  core_pods
  thirdparty_pods
  ui_pods
  internal_pods
end

target 'MomentsTests' do
  core_pods
  thirdparty_pods
  test_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
    end
  end
end
