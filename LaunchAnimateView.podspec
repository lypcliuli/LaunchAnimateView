
Pod::Spec.new do |s|
  s.name             = 'LaunchAnimateView'
  s.version          = '0.1.0'
  s.summary          = '启动图动画启动图添加广告'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lypcliuli/LaunchAnimateView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lypcliuli' => 'lypcliuli@163.com' }
  s.source           = { :git => 'https://github.com/lypcliuli/LaunchAnimateView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LaunchAnimateView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LaunchAnimateView' => ['LaunchAnimateView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
