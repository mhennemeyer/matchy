module Testing
  # == Temporary
  # A temporary module that holds functionality
  # that awaits to be refactored to the right place.
  module Functions   
    def self.determine_class_name(name) #:nodoc:
      name.to_s.split(/\W+/).map { |s| s[0..0].upcase + s[1..-1] }.join 
    end
    
    def self.make_constantizeable(string)
      return string unless string.class.to_s == "String"
      string = string.gsub(/[^\w\s]/,"").gsub(/^[\d\s]*/,"")
      raise ArgumentError.new(
          "Invalid argument. Must not be empty after removing '\W'-class chars."
      ) if string.gsub(/\s/,"").empty?
      string
    end
  end # Functions
end # Testing