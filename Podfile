# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TPM Instagram' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TPM Instagram
  pod 'AlamofireImage', '~> 3.3'
  pod 'CameraManager', '~> 3.2'
  pod 'Parse'
  pod ‘ParseUI’
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.2'
      end
    end
  end  

end
