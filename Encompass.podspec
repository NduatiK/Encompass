#
# Be sure to run `pod lib lint Encompass.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Encompass'
  s.version          = '0.2.0'
  s.summary          = 'Navigation Library'


  s.description      = <<-DESC
A wrapper for hypersolo's navigation library – Compass (https://github.com/hyperoslo/Compass)              
         DESC

  s.homepage         = 'https://github.com/NduatiK/Encompass'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NduatiK' => '012nkuria@gmail.com' }
  s.source           = { :git => 'https://github.com/NduatiK/Encompass.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Encompass/Classes/**/*'
    s.dependency 'Compass', '6.0.0'

swift_version = '4.0'
end
