# Using the Let method to help our test be more efficient.

There are a couple of problems with before each.
```
before(:example) do
  @car = Car.new
end

it "allows reading for :wheels" do
  expect(@car.wheels).to eq(4)
end
```

1. It gets called before every example. If we have 10 examples in the group, and one of those examples never even calls @car, it doesn't matter. The code is going to execute, and the instance variable is going to be assigned anyway.

2. it doesn't keep the car instance around. It overwrites it with a new one each and every time. Before each example, it reassigns that value.

3. It required us to go into our spec file and at @ symbols to make all of the local variables into instance variables.
## This is what the let method does for you.

```
before(:context) do
  def car
    @car ||= Car.new
  end
end

it 'allows reading for :wheels' do
  expect(car.wheels).to eq(4)
end
```
What would be better is before the context, we could actually define a new method, and that method would be called "car".

Whenever that method is called, then it will create a new instance of the car class and assign it to the instance variable, "car". Even better, though, notice that I've got upright pipes and equals in between car and car.new. That's the Ruby notation that says if we already have a value for the instance variable, use it. If not, then go get a new value, and assign it to the instance variable.

####This is called memoization.
Essentially, it's remembering the fact that we had one already.

If we don't have one, it'll go get a new one. But if we had one, it'll hang on to it. Now of course, we could have applied memoization to the before example hook that we had on the previous slide. But what I wanted to show you here is that we're defining a method called car. So that means that in our example, we're actually calling that method, car.wheels. Car is not a local variable anymore. Car is now a method, and the method is what's calling the variable for us.

### The let method

```
let(:car) { Car.new }

it "allows reading for :wheels " do
  expect(car.wheels).to eq(4)
end
```

The Let Method creates a helper method for you that you can then use. It takes one argument, which is the name of the method that you want to create. And then it takes a block of code, the block that you want to put inside that method. And Let will do the memoization for that block of code for you automatically. So now when I call expect(car.wheels).to eq(4), car is calling that helper method, the one that Let created for us, just like we had on the previous slide.

So now when I call expect(car.wheels).to eq(4), car is calling that helper method, the one that Let created for us, just like we had on the previous slide.

You don't need the @ symbols anymore!. You are not changing it to being a local variable again now we are changing it too begin a method call.
 We're actually calling a method that returns the value to us.

And it's either going to return to us an existing value for car, or it's going to go and execute that block of code in order to get a new one.

### If we have Let, then why do we need before hooks?

Before hooks are still very useful. And there's a lot of business and setup before your example groups that you can do with them. For example, maybe you want to populate your database with some data before your example group runs. A before hook is a great way to do that. But if you find your before hook is only assigning values to instance variables, then use Let.

Let is a better choice for that. Now, one additional benefit to this being a method is that it doesn't actually execute for the first time until we call it. So if in an example group, we have four examples that never even call car, then that block of code never runs.

## With out Let

```
describe '.colours' do

  it 'returns an array of color names' do
    c = ['blue', 'black', 'red', 'green']
    expect(Car.colors).to match_array(c)
  end

end
```

## With Let


```
describe '.colours' do

  let(:colors) {['blue', 'black', 'red', 'green']}

   it 'returns an array of color names' do
    expect(Car.colors).to match_array(colors)
  end

end
```
## With out Let

```
describe '#full_name' do

  it 'returns a string in the expected format' do
    @honda = Car.new(:make => 'Honda', :year => '2004', :color => 'blue')
    expect(@honda.full_name).to eq('2004 Honda (blue)')
  end

end
```
## With Let
```
describe '#full_name' do

  Let(:honda) {Car.new(:make => 'Honda', :year => '2004', :color => 'blue')}
  it 'returns a string in the expected format' do
    expect(honda.full_name).to eq('2004 Honda (blue)')
  end

end
```


# Another form of let with an exclamation mark after it.

```
let!(:car) { Car.new }

it "allows reading for :wheels: do
  expect(car.wheels).to eq(4)
end
```
Regular let is lazy executed. Let with the exclamation point is eager executed. That is, it runs right away the first time it's defined. It's the same as calling the definition and then just calling car right after it to make sure that it runs.
