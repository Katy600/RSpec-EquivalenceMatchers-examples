describe 'observation matchers' do
  # note that all of these use "expect{}", not expect()",
  # It is a special block format that allows a process
  # to take place inside of the expectation.

  it 'will match when events change objects attributes' do
    # it calls the test before the block,
    # then again after the block
    array = []
    expect{ array << 1 }.to change(array, :empty?).from(true).to(false)

    class WebsiteHits
      attr_accessor :count
      def initialize; @count = 0; end
      def increment; @count  += 1; end
    end
    hits = WebsiteHits.new
    expect {hits.increment }.to change(hits, :count).from(0).to(1)
  end

  it 'will match when events change any value' do
    # it calls the test before the block,
    # then again after the block
    # notice the {} after 'change',
    # can be used on simple variables
    x = 10
    expect {x += 1 }.to change {x}.from(10).to(11)
    expect {x += 1 }.to change {x}.by(1)
    expect {x += 1 }.to change {x}.by_at_least(1)
    expect {x += 1 }.to change {x}.by_at_most(1)

    # notice the "{}" after "change",
    # can contain any block of code
    z = 11
    expect { z += 1 }.to change {z % 3}.from(2).to(0)

    # must have a value before the block
    # must change the value inside the block
  end

  it 'will match when errors are raised' do
    # observe any errors rased by the block
    expect {raise StandardError }.to raise_error
    expect {raise StandardError }.to raise_exception

    expect { 1/0 }.to raise_error(ZeroDivisionError)
    expect { 1/0 }.to raise_error.with_message('divided by 0')

    expect { 1/0 }.to raise_error.with_message(/divided/)

    #note that the negative form does not except arguments
    expect { 1/1 }.not_to raise_error
  end

  it 'will match when output is generated' do
    #observe output sent to $stdout or $StandardError
    expect {print('hello') }.to output.to_stdout
    expect {print('hello') }.to output('hello').to_stdout
    expect {print('hello') }.to output(/ll/).to_stdout

    expect {warn('problem') }.to output(/problem/).to_stderr
  end
end
