# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'cowry-cal' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for cowry-cal
  pod 'Alamofire','5.2.1'
  pod 'AlamofireImage'
  pod 'RealmSwift'
  pod 'MaterialComponents/Snackbar','109.6.0'
  pod 'SwiftyJSON', '~> 5.0'
  pod 'SnapKit', '~> 4.0.0'
  pod 'DGCharts'
  pod 'IQKeyboardManagerSwift'

  #Rx
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '~> 5.0'
  pod 'RxSwiftExt', '~> 5.0'
  pod 'RxOptional'
  pod 'Action'
  pod 'RxDataSources'
  pod 'R.swift'

  post_install do |installer|
  installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
  end
  end
  end

end
