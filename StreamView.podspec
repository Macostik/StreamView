
Pod::Spec.new do |s|
  s.name = 'StreamView'
  s.version = '1.4.0'
  s.license     = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'Elegant collection view'
  s.homepage = 'https://github.com/Macostik/StreamView.git'
  s.social_media_url = 'http://twitter.com/StreamView'
  s.authors = { 'Macostik' => 'info@macostik.org' }
  s.source = { :git => 'https://github.com/Macostik/StreamView.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/*.swift' 

end
