describe 'compound expectations' do
  it 'will match using: and , or, &, |' do
    expect([1,2,3,4]).to start_with(1).and end_with(4)
    expect([1,2,3,4]).to start_with(1) & include(2)
    expect(10 * 10).to be_odd.or be > 50

    array = ['hello', 'goodbye'].shuffle
    expect(array.first).to eq('hello') | eq('goodbye')
  end

  describe 'composing matchers' do
    #Some matchers accept some matchers as arguments. (new in rspec 3)
    it 'will match all collection elements using a matcher' do
      array = [1,2,3]
      expect(array).to all( be < 5)
    end

    it 'will match by sending matchers as arguments to matchers' do
      string = "hello"
      expect { string = "goodbye" }.to change { string }.from( match(/ll/) ).to( match(/oo/))

      hash = {:a => 1, :b => 2, :c => 3}
      expect(hash).to include(:a => be_odd, :b => be_even, :c => be_odd)
    end

    it 'will match using noun-phrase aliases for matchers' do
      # these are built in aliases that make specs read better by using noun-based phrases instead of verb-based phrases.
      # valid but akward example
      fruits = ['apple', 'banana', 'cherry']
      expect(fruits).to start_with( start_with('a') ) & include( match(/a.a.a/)) & end_with( end_with('y'))

      #improved version of the previous example "start_with" becomes "a_string_starting_with"
      #"end_with" becomes "a_string_ending_with" match becomes "a string_matching"
      fruit = ['apple', 'banana', 'cherry']
      expect(fruit).to start_with(a_string_starting_with('a') ) &
      include( a_string_matching(/a.a.a/) ) & end_with(a_string_ending_with('y') )

      # valid but akward example
      array = [1,2,3,4]
      expect(array).to start_with( be <= 2 ) | end_with( be_within(1).of(5) )

      #improved version of the previous example
      #"be <= 2" becomes "a_value_within"
      array = [1,2,3,4]
      expect(array).to start_with(a_value <= 2 ) | end_with( a_value_within(1).of(5))
    end
  end
end
