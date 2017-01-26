describe 'Car' do

  describe 'attributes' do
    before(:example) do
      @car = Car.new
    end
    it 'allows reading and writing for :make' do
      @car.make = 'Test'
      expect(car.make).to eq('Test')
    end

    it 'allows reading and writing for year' do
      @car.year = 9999
      expect(@car.year).to eq(9999)
    end

    it 'allows reading and writing for :color' do
      @car.color = 'foo'
      expect(@car.color).to eq('foo')
    end

    it 'allows reading for :wheels' do
      expect(@car.wheels).to eq(4)
    end
  end
end
