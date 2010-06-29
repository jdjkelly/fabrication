require 'spec_helper'

describe Fabrication::Generator::Mongoid do

  let(:generator) do
    Fabrication::Generator::Mongoid.new(Author) do
      name 'Name'
      handle { |author| author.name.downcase }
      books(:count => 3) { |author, index| "#{author.name} #{index}" }
    end
  end

  context 'mongoid object' do

    before { generator.generate(:name => 'Something') }

    it 'passes the object to blocks' do
      generator.generate({}).handle.should == "name"
    end

    it 'passes the object and count to blocks' do
      generator.generate({}).books.should == ["Name 1","Name 2","Name 3"]
    end

    it 'persists the author upon creation' do
      Author.where(:name => 'Something').first.should be
    end

  end

end