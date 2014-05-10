require 'spec_helper'

describe Laurel do
  describe 'self.config' do
    Laurel.config.class.should == Hashie::Mash
  end

end
