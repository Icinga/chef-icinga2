
# This seems wrong, but I don't actually know how to do this
require_relative '../../libraries/icinga2.rb'

describe '#icinga_format' do
  subject { icinga_format }

  it 'handles hashes' do
    expect(icinga_format(:foo => :bar)).to eq('{ "foo" = "bar" }')
  end

  it 'handles arrays' do
    expect(icinga_format([1, 3, 5])).to eq('[ 1, 3, 5 ]')
  end

  it 'handles strings' do
    expect(icinga_format('foo')).to eq('"foo"')
  end

  it 'handles floats' do
    expect(icinga_format(1.2)).to eq('1.2')
  end

  it 'handles fixnums' do
    expect(icinga_format(10)).to eq('10')
  end

  it 'handles nulls' do
    expect(icinga_format(nil)).to eq('null')
  end

  it 'handles nesting' do
    expect(icinga_format(:foo => [:bar, { 1 => 2 }, { 1 => [:a, :b, :c] }])).to eq('{ "foo" = [ "bar", { 1 = 2 }, { 1 = [ "a", "b", "c" ] } ] }')
  end

  it 'handles arbitrary objects by stringifying them' do
    expect(icinga_format(StandardError.new)).to eq('"#<StandardError: StandardError>"')
  end

  it 'Arbitrary stringifying works with nesting' do
    expect(icinga_format('err' => StandardError.new, 'list' => [{ 'err' => IOError.new }])).to eq('{ "err" = "#<StandardError: StandardError>", "list" = [ { "err" = "#<IOError: IOError>" } ] }')
  end
end
