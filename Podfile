# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'MyRecipeApp_CleanArchitecture'

# Infrastracture Module
def infrastracture_pods
  pod 'Alamofire', '~> 5.4'
  pod 'AlamofireImage', '~> 4.1'
end

target 'Infrastracture' do
  project 'Infrastracture/Infrastracture.project'
  infrastracture_pods
end

target 'Domain' do
  project 'Domain/Domain.project'
  # TODO: - Add Pods if needed
end

target 'MyRecipeApp_CleanArchitecture' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MyRecipeApp_CleanArchitecture
  infrastracture_pods
  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'
  pod 'RxDataSources', '~> 5.0'

end

# RxTest and RxBlocking make the most sense in the context of unit/integration tests
target 'MyRecipeApp_CleanArchitectureTests' do
    pod 'RxBlocking', '6.2.0'
    pod 'RxTest', '6.2.0'
end
