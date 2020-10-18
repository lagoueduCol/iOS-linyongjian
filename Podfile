source 'https://cdn.cocoapods.org/'

workspace './Moments.xcworkspace'
project './Moments/Moments.xcodeproj'

platform :ios, '14.0'
use_frameworks!

# ignore all warnings from all dependencies
inhibit_all_warnings!

def core_pods
  pod 'SwiftLint', '0.40.3', configurations: ['Debug']
  pod 'RxSwift', '5.1.1'
  pod 'RxRelay', '5.1.1'
end

def ui_pods
  pod 'SnapKit', '5.0.1'
  pod 'Kingfisher', '5.15.6'
  pod 'RxCocoa', '5.1.1'
  pod 'RxDataSources', '4.0.1'
end

def internal_pods
  pod 'DesignKit', :path => './Frameworks/DesignKit', :inhibit_warnings => false 
end

def test_pods
  pod 'Quick', '3.0.0'
  pod 'Nimble', '9.0.0'
  pod 'RxTest', '5.1.1'
  pod 'RxBlocking', '5.1.1'
end

target 'Moments' do
  core_pods
  ui_pods
  internal_pods
end

target 'MomentsTests' do
  core_pods
  test_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

