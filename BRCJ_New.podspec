#
#  Be sure to run `pod spec lint BRCJ.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "BRCJ_New"
  spec.version      = "1.2.5"
  spec.summary      = "A short description of BRCJ."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!

  spec.homepage     = "https://@github.com/wuchunyi321/NextYVS"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  spec.license      = { :type => 'BSD' }
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "wuchunyi321" => "394319419@qq.com" }
  # Or just: spec.author    = "wuchunyi321"
  # spec.authors            = { "wuchunyi321" => "394319419@qq.com" }
  # spec.social_media_url   = "https://twitter.com/wuchunyi321"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # spec.platform     = :ios
   spec.platform     = :ios, "9.0"

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/wuchunyi321/NextYVS.git", :tag => spec.version  }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files  = "BRCJ 2/Classes/**/*.{h,m}"
  spec.exclude_files = "BRCJ 2/Classes/Login/VC/LoginViewController.{h,m}" 

  spec.vendored_libraries  = 'BRCJ 2/Classes/WechatSDK1.8.2/libWeChatSDK.a'

  spec.vendored_frameworks  = 'BRCJ 2/Classes/AlipaySDK-iOS/AlipaySDK.framework'
  spec.xcconfig = { 'USER_HEADER_SEARCH_PATHS' => 'BRCJ 2/Classes/AlipaySDK-iOS/*.{h}' }
  spec.resources = ['BRCJ 2/Classes/AlipaySDK-iOS/AlipaySDK.bundle','BRCJ 2/Classes/BRSource.bundle']

 # 设置全局引用 直接在.pch文件中引用
   spec.prefix_header_contents = <<-EOS
 	#ifdef __OBJC__
 	#import "HeaderDefine.h"    //HeaderDefine包含了所有头文件
	#import "BrHeader.h"    //HeaderDefine包含了所有头文件
 	#endif 
	EOS
   spec.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
  # spec.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
    spec.frameworks = "CoreTelephony", "SystemConfiguration", "UIKit", "Security", "CFNetwork", "SystemConfiguration"

  # spec.library   = "iconv"
   spec.libraries = "z", "sqlite3.0", "c++"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
       
spec.dependency 'AFNetworking','~> 3.1.0'
spec.dependency 'Masonry', '~> 1.1.0'
spec.dependency 'MJRefresh', '~> 3.1.15'
spec.dependency 'SDWebImage', '~> 5.0.0'
spec.dependency 'YYImage'
spec.dependency 'YYText'
spec.dependency 'SDCycleScrollView', '~> 1.80'
spec.dependency 'MJExtension', '~> 3.0.17'
spec.dependency 'SVProgressHUD', '~> 2.2.5' 

end
