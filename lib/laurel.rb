require "laurel/version"

module Laurel
  def self.create_project(name)
    Dir.mkdir(name)
  end

  def self.add_page(name)
    FileUtils.touch(name)
  end

  def self.generate_page_name
    Digest::MD5.hexdigest(Time.now.to_s)+'.textile'
  end
end
