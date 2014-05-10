require "laurel/version"

module Laurel
  ROOT = File.expand_path(File.join(__FILE__, '../../'))

  def self.create_project(name)
    template_dir = File.join(Laurel::ROOT, 'templates')
    FileUtils.cp_r(template_dir, name) unless Dir.exists?(name)
  end

  def self.add_page(name)
    dir = nil
    dir = name.gsub(/^.+\//, '') if name =~ /\//

    FileUtils.touch(name)
  end

  def self.generate_page_name
    Digest::MD5.hexdigest(Time.now.to_s)+'.textile'
  end

  private
  def self.config
    Hashie::Mash.new(YAML.load_file('config/laurel.yml'))
  end
end
