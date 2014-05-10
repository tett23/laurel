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
    file_infomation = self.generate_page_name(name)
    full_path = File.join(file_infomation[:dir], file_infomation[:file])

    FileUtils.mkdir_p(file_infomation[:dir])
    FileUtils.touch(full_path)

    full_path
  end

  private
  def self.generate_page_name(flagment=nil)
    path = if flagment.nil?
      file = Digest::MD5.hexdigest(Time.now.to_s)+Laurel::Config.format

      File.expand_path(File.join(Laurel::Config.directories.posts, file))
    elsif self.directory?(flagment)
      file = Digest::MD5.hexdigest(Time.now.to_s)+Laurel::Config.format

      File.expand_path(File.join(flagment, file))
    elsif self.file?(flagment)
      File.expand_path(flagment)
    end
    path += '.'+Laurel::Config.format if File.extname(path) == ''

    {
      file: File.basename(path),
      dir: path.gsub(/\/#{File.basename(path)}$/, '')
    }
  end

  def self.file?(flagment)
    expanded_flagment = File.expand_path(flagment)
    not File.directory?(expanded_flagment)
  end

  def self.directory?(flagment)
    expanded_flagment = File.expand_path(flagment)
    Dir.exists?(expanded_flagment)
  end
end
