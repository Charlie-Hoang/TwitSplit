# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'TwitSplit.xcworkspace'

use_frameworks!

inhibit_all_warnings!

def framework_pods
	pod 'RxSwift'
	pod 'RxCocoa'
end

target 'TwitSplitApp' do
	project 'TwitSplitApp/TwitSplitApp.xcodeproj'
    framework_pods
    pod 'NextGrowingTextView'
end

target 'TwitSplitCore' do
	project 'TwitSplitCore/TwitSplitCore.xcodeproj'
end

