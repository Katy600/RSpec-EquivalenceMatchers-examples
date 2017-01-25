describe 'other useful matchers' do
  it 'will match strings with regex' do
    # This matcher is a good way to "spot check" strings
    string = "The order has been recieved."
    expect(string).to match(/order(.+)recieved/)

    expect('123').to match(/\d{3}/)
    expect(123).not_to match(/\d{3}/) # only works with strings

    email = 'someone@somewhere.com'
    expect(email).to match(/\A\w+@\w+\.\w{3}\Z/)
  end

  it 'will match object type' do
    expect('test').to be_instance_of(String)
    expect('test').to be_an_instance_of(String) #alias of be_instance_of

    expect('test').to be_kind_of(String)
    expect('test').to be_a_kind_of(String) #alias of be_kind_of

    expect('test').to be_a(String) #alias of be_kind_of
    expect([1, 2, 3]).to be_an(Array) #alias of be_kind_of
  end

  it 'will match object with #respond_to' do
    string = 'test'
    expect(string).to respond_to(:length)
    expect(string).not_to respond_to(:sort)
  end

  it 'will match a class instance with #have_attributes' do
    class Car
      attr_accessor :make, :year, :color
    end
    car = Car.new
    car.make = 'Dodge'
    car.year = 2010
    car.color = 'green'

    expect(car).to have_attributes(:color => 'green')
    expect(car).to have_attributes(
    :make => 'Dodge', :year => 2010, :color => 'green')
  end

  it 'will match anything to #satisfy' do
    # This is the most flexible matcher
    expect(10).to satisfy do |value|
      (value >= 5) && (value <=10) && (value % 2 == 0)
    end
  end
end
