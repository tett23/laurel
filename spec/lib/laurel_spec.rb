require 'spec_helper'

describe Laurel do
  describe :add_page do
    it '引数なし' do
      path = Laurel.add_page()
      expect(File).to exist(path)
    end

    context '引数あり' do
      it '新規ファイル' do
        path = Laurel.add_page('foo.textile')
        expect(File).to exist(path)
      end

      it 'ディレクトリを掘る必要がある' do
        path = Laurel.add_page('foo/bar.textile')
        expect(File).to exist(path)
      end

      it '拡張子を追加させる' do
        path = Laurel.add_page('hoge')
        expect(File.extname(path)).to eq('.textile')
        expect(File).to exist(path)
      end

      it 'ディレクトリを指定' do
        path = Laurel.add_page('config')
        expect(File).to exist(path)
      end
    end
  end
end
