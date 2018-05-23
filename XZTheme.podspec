#
# Be sure to run `pod lib lint OMKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XZTheme'
  s.version          = '0.0.2'
  s.summary          = 'XZTheme 是一款高效、简介的 iOS 主题管理框架。'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
      XZTheme 是 XZKit 框架中的一个组件，目前已开源。
                       DESC

  s.homepage         = 'https://github.com/mlibai/XZTheme'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mlibai' => 'mlibai@163.com' }
  s.source           = { :git => 'https://github.com/mlibai/XZTheme.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version    = "4.0"

  s.ios.deployment_target = '8.0'

  s.requires_arc = false
  # spec.requires_arc = 'Classes/Arc'
   s.requires_arc = [
    'XZTheme/**/*.swift',
    'XZTheme/**/UIView+XZThemeSupporting.m',
    'XZTheme/**/UIViewController+XZThemeSupporting.m',
    'XZTheme/**/UIViewController+XZTheme.m'
  ]

  s.source_files = 'XZTheme/**/*'
  
  # s.resource_bundles = {
  #   'OMKit' => ['OMKit/Assets/**/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  # s.dependency 'AFNetworking', '~> 2.3'
  # s.dependency 'SDWebImage', '~> 4.0'
  s.dependency 'XZKit'

end
