require "laurel/version"

module Laurel
  def self.create_project(name)
    Dir.mkdir(name)
  end
end
