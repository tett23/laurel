require 'spec_helper'

describe Laurel::Config do
  it 'load config' do
     expect(Laurel::Config.directories.is_a?(Hashie::Mash)).to be_true
  end
end
