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

  def self.build(file)
    if file === 'all'
      entries_path = File.expand_path(File.join(Laurel::Config.directories.posts))
      Dir.glob(File.join(entries_path, '**', '*')).each do |build_file|
        self.build_item(build_file)
      end
    end
  end

  private
  def self.generate_page_name(flagment=nil)
    path = if flagment.nil?
      file = Digest::MD5.hexdigest(Time.now.to_s)

      File.join(file)
    elsif self.directory?(flagment)
      file = Digest::MD5.hexdigest(Time.now.to_s)

      File.join(flagment, file)
    elsif self.file?(flagment)
      flagment
    end
    path = File.expand_path(File.join(Laurel::Config.directories.posts, path)) unless path =~ /^\//
    path += '.'+Laurel::Config.format if File.extname(path).blank?

    {
      file: File.basename(path),
      dir: path.gsub(/\/#{File.basename(path)}$/, '')
    }
  end

  def self.file?(flagment)
    expanded_flagment = File.expand_path(File.join(Laurel::Config.directories.posts, flagment))
    not File.directory?(expanded_flagment)
  end

  def self.directory?(flagment)
    expanded_flagment = File.expand_path(File.join(Laurel::Config.directories.posts, flagment))
    Dir.exists?(expanded_flagment)
  end

  def self.build_item(item)
    return if Dir.exists?(item)

    base = item.gsub(File.expand_path(Laurel::Config.directories.posts)+File::SEPARATOR, '')
    compiled = self.compile_resource(item)
    self.write_out(File.join(Laurel::Config.directories.build, base), compiled)

    #p dir, base
  end

  def self.compile_resource(path)
    f = open(path)
    compiled = RedCloth.new(f.read).to_html
    f.close

    compiled
  end

  def self.write_out(path, body)
    base = path.gsub(/\/#{File.basename(path)}$/, '')
    FileUtils.mkdir_p(base)

    out_path = path.gsub(File.extname(path), '.html')
    f = open(out_path, 'w')
    f.print(body)
    f.close
  end
end
