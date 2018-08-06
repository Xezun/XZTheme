#
# Be sure to run `pod lib lint OMKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
	
	s.name             = 'XZTheme'
	s.version          = '0.1.1'
	s.summary          = 'XZTheme is an efficient and succinct iOS thematic management framework.'

	# This description is used to generate tags and improve search results.
	#   * Think: What does it do? Why did you write it? What is the focus?
	#   * Try to keep it short, snappy and to the point.
	#   * Write the description between the DESC delimiters below.
	#   * Finally, don't worry about the indent, CocoaPods strips it!

	s.description      = <<-DESC
							XZTheme is a part of XZKit, an efficient iOS third framework. XZTheme depends on the XZKit.
						DESC

	s.homepage         = 'https://github.com/mlibai/XZTheme'
  	# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  	s.license          = { :type => 'MIT', :file => 'LICENSE' }
  	s.author           = { 'mlibai' => 'mlibai@163.com' }
  	s.source           = { :git => 'https://github.com/mlibai/XZTheme.git', :tag => s.version.to_s }
  	# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  	s.swift_version    = '4.0'

  	s.ios.deployment_target = '8.0'

  	s.requires_arc = true

    s.public_header_files = 'XZTheme/**/*.h'
	s.source_files = 'XZTheme/**/*.{h,m,swift}'


  	s.dependency 'XZKit'

end
