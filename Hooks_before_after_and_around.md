### DRY - Don't repeat yourself

This is the idea behind hooks.  Write code one time and then tell RSpec
to run that code either before, after, or around our examples.

### Before hooks,  After hooks,  Around hooks

Each of these RSpec methods is going to take an argument,
which is a symbol indicating the scope in which it should be run.

```
            config.before(:suite) do
                ... code in here
            end
```

This ensures that whether you're running one test or all of tests,
this code still runs one time at the very start. It's used rarely.
Mostly it's used to do any setup that our entire test suite needs right at the start

```
              before(:context) do :alias before(:all)
                ... code in here
              end
```

In the second example, we are using the context scope. This is more common.
This runs the block of code once before any of the examples in an example group are executed.
And you'll remember, an example group is defined by describe or context.
So before it runs anything inside that context, it'll run that block of code.

```
              before(:example) do :alias before(:each)

              end
```

In the third example, we are using the example scope. This runs the block of code once before each example.
If you have 10 examples in an example group, then the before example code will run 10 times.
The before example code, then the example, the before example code, then the example, and so on.

if you happen to have all three of these in place, then they run in the order shown.
The before suite runs first, then before context, and then example, and then your example runs.
After your example is done, it runs any after hooks that you have in the reverse order, after example,
after context, after suite.


### Around

```
 around(:example) do |example|
    puts "Code to execute before example "
    example.run
    puts "Code to execute after example"
 end
 ```

We have around example, and then you'll notice that we have example declared as a block variable after that.
That's so that then we can call example.run in the third line of code there.
So you can see I can do whatever business I want to do before I do that.
When I'm finally ready, I say example.run, and then I can do any business that I want to take care of after the example.

It's very similar to having a before example and an after example code block. Here we're just doing it all in one step.

If you happen to use both, around executes its before before any before hooks take place, and then after any after hooks
are done, then the around code takes place. So it wraps everything, including your before hooks and your after hooks.

### One other thing that is important to know about hooks

You need to use instance variables in them in order to make objects and values available to your examples.
So, for example, if we did some searching in the database and we find a customer. We assign it to the variable customer. That's a local variable that will not be available. But @customer is an instance variable, and it will be available to all of our examples. So just make sure that you're always using instance variables in order to access information between your hooks and your examples.

### Example
```
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
end
```
### Instead of:
```
describe 'attributes' do
  it 'allows reading and writing for :make' do
    car = Car.new
    @car.make = 'Test'
    expect(car.make).to eq('Test')
  end
```

I want to make sure that setting those values is not going to cause problems in my other examples. Because if I just do it one time, that car object is still around.

It's still what's going to be referred to. By you calling before example, I'm going to be creating a new instance of it each time. I'm essentially refreshing it with a new instance. That's not a particularly expensive operation, so that's okay.
