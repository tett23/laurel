require 'singleton'

require "laurel/version"
require 'laurel/config'

module Laurel
  ROOT = File.expand_path(File.join(__FILE__, '../../'))

  def self.create_project(name)
    template_dir = File.join(Laurel::ROOT, 'templates')
    FileUtils.cp_r(template_dir, name) unless Dir.exists?(name)
  end

  def self.add_page(name=nil)
    path = self.generate_page_name(name)
    path += '.textile' unless File.extname(path) == '.textile'
    dir = path.gsub(/^(.+)\/(.+)/, '\1')
    FileUtils.mkdir_p(dir)
    FileUtils.touch(path)

    path
  end

  private
  def self.generate_page_name(flagment=nil)
    filename = if flagment.nil?
      file = Digest::MD5.hexdigest(Time.now.to_s)+'.textile'

      File.expand_path(File.join(Laurel::Config.directories.posts, file))
    elsif self.file?(flagment)
      File.expand_path(flagment)
    elsif self.directory?(flagment)
      file = Digest::MD5.hexdigest(Time.now.to_s)+'.textile'

      File.expand_path(File.join(flagment, file))
    end

    filename
  end

  def self.file?(flagment)
    return false if flagment.include?('/')

    expanded_flagment = File.expand_path(flagment)
    not File.directory?(expanded_flagment)
  end

  def self.directory?(flagment)
    return true if flagment.include?('/')

    expanded_flagment = File.expand_path(flagment)
    File.directory?(expanded_flagment)
  end
end
