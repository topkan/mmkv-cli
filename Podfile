platform :osx, '10.10'

target 'mmkv-cli' do
  pod 'MMKV', '1.0.23'
  pod 'Commander', '0.9.1'
end

post_install do |installer|
  %w(
    Pods/MMKV/iOS/MMKV/MMKV/MMKVLog.mm
  ).flat_map { |x| Dir.glob(x) }.each do |file|
    contents = File.read(file)
    contents.sub! 'NSLog', '// NSLog'
    File.open(file, "w") do |f|
      f.puts contents
    end
  end
end
