describe 'numeric comparision matchers' do

  it 'will be less than/greater than' do
    expect(10).to be > 9
    expect(10).to be >= 10
    expect(10).to be <= 10
    expect(9).to be < 10
  end

  it 'will match numeric ranges' do
    expect(10).to be_between(5, 10).inclusive
    expect(10).not_to be_between(5, 10).exclusive
    expect(10).to be_within(1).of(11)
    expect(5..10).to cover(9)
  end

end
