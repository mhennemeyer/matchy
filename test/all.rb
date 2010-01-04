dir = File.dirname(__FILE__)
Dir[File.expand_path("#{dir}/**/*.rb")].uniq.each do |file|
  if (file =~ /\/test_\w+\.rb$/) && (file !~ /\/test_helper\.rb$/)
    puts file
    require file 
  end
end