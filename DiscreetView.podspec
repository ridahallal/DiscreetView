Pod::Spec.new do |s|
  s.name             = 'DiscreetView'
  s.version          = '1.0.0'
  s.summary          = 'A UIView subclass that blurs itself when a user waves their hand above of the notch (or wherever the ambient light sensor is located).'

  s.homepage         = 'https://github.com/ridahallal/DiscreetView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Rida Hallal' => 'rida.hallal@gmail.com' }
  s.source           = { :git => 'https://github.com/ridahallal/DiscreetView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.source_files = 'Sources/*.swift'

  s.swift_version = '5'
end
