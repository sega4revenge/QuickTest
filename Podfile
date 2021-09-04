# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


def rx
  pod 'RxSwift', '6.1.0'
  pod 'RxCocoa', '6.1.0'
  pod 'RealmSwift'
end

def libraryUI
  pod 'Kingfisher'
  pod 'JGProgressHUD'
  
end

def utils
  pod 'SwifterSwift', '5.2.0'
  pod 'SwiftyUserDefaults', '5.1.0'
  pod 'Bagel', '1.4.0'
  pod 'ObjectMapper'
  pod 'IQKeyboardManagerSwift', '6.3.0'
end

def netwoking
  pod 'Alamofire', '~> 5.2'
end

target 'QuickTest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  libraryUI
  utils
  netwoking
  rx
  # Pods for QuickTest

  target 'QuickTestTests' do
    inherit! :search_paths
    pod 'OHHTTPStubs/Swift'
    # Pods for testing
  end

  target 'QuickTestUITests' do
    # Pods for testing
  end

end
