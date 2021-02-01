# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'DivingMemoriesApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DivingMemoriesApp

pod 'Firebase'
pod 'Firebase/Auth'
pod 'PKHUD','~>5.0'
pod 'FirebaseMessaging'
pod 'EMAlertController'
pod 'Firebase/Core'
pod 'Firebase/Analytics'
pod 'Firebase/Firestore'
pod 'FSCalendar'
pod 'CalculateCalendarLogic' 
pod 'IQKeyboardManagerSwift'
pod 'ViewAnimator'
pod 'Firebase/Storage'
pod 'SDWebImage', '~> 5.0'
pod 'SwiftyJSON', '~> 4.0'
pod 'Alamofire', '~> 5.2'
pod 'SDWebImage', '~> 5.0'
pod 'lottie-ios'
pod 'SwiftGifOrigin', '~> 1.7.0'
pod 'APNGKit', '~> 1.0'
pod 'Google-Mobile-Ads-SDK'


post_install do |installer|  
  installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
  end
end





end
