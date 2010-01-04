dir = File.dirname(__FILE__)
Dir[File.expand_path("#{dir}/**/*.rb")].uniq.each do |file|
  if (file =~ /\/test_\w+\.rb$/) && (file !~ /\/test_helper\.rb$/)
    puts file
    File.open(file,File::RDWR) do |f|
      new_lines = []
      old_lines = f.readlines
      old_lines.each do |line|
        if line =~ /\A\s*def\stest_(.*)\Z/
          desc = $1.gsub(/\s/, "").gsub(/_/, " ")
          line = "test \"#{desc}\""
        end
        new_lines << line
      end
      f.puts new_lines
    end
  end
end