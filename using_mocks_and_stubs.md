```
it 'allows stubbing methods' do
  dbl = double("Chant")
  allow(dbl).to recieve(:hey!)
  expect(dbl).to respond_to(:hey!)
end

```
 The result is that double is going to create a very simple fake object, a stand-in that we can use. It doesn't have any knowledge or intelligence on its own.

 It's just a simple object. And I'm going to assign that object to the variable double, so that I can continue to work with it. In the next line, I'm giving the object something to do. I'm giving it a bit of intelligence, and I'm doing that by stubbing the mock object. I do it by calling RSpec's allow method, which is always followed by to receive.

In the first one, the stub, I'm telling RSpec that it should allow the object to receive the message, hey. In Ruby, a message sent to an object is generally a request for that object to run its method by the same name. So, telling it to respond to hey is a bit like defining a method in the mock object. We're saying, mock object pretend you have the hey method defined, and that's why in the next line we can have an expectation that the double will respond to hey, just like it would if it had the method.

That's what the stub did. It allowed it to respond to the call to hey. So in this example, we've created a mock object and given it a stub, but it's much more useful if we can also set the return value that that method returns whenever it's called.

```
it 'allows setting responses' do
  dbl = double("Chant")
  allow(dbl).to recieve(:hey!) {"Ho!"}
  expect(dbl.hey!).to eq("Ho!")
end
```

The simplest form uses a block to set the return value. You can see that I've added a block after receive hey. In this example, my block is very simple. It just returns a simple string. The block could also perform other more complex calculations before finally returning its result.

I've now told the mock object not only to respond to hey but to respond with a specific value, ho.

##### A stub is a fake method.

### Another syntax

```
it 'allows setting responses' do
  dbl = double("Chant")
  allow(dbl).to
    receive(:hey).and_return("Ho!")
    expect(dbl.hey!).to eq("Ho!")
end

```

 After receive hey, you can see that now I'm stringing onto that another method called .and_return and then the value that I want to return. Now this won't allow me to do the complicated calculations that the block format would do. It allows me to return simple values. But the result is the same. My expectation is that when I call hey on double, it will respond with ho.

Note that when mocking and stubbing using test doubles, these last for the duration of a single example. Every time I call hey in this same example, I'll get back ho, but in the next example, the mock object and stub will disappear, and I won't get those back. They get cleaned up and reset after each example. This ensures that examples using doubles can be run individually or in groups or in any order. You can put them in before example blocks, if you need them to be present for multiple examples inside an example group.

### Using recieve messages
Notice that it's different. Instead of just having allow something to receive, I have allow something to receive_messages. In this case, I'm stubbing several things at once. I'm stubbing full name and asking it to return the value Mary Smith, and I'm stubbing initials and asking it to return MTS. Essentially, it's allowing me to set up many allow statements all in one.

```
it 'allows setting responses' do
  dbl = double("Person")
  allow(dbl).to receive_messages(
    :full_name => "Mary Smith",
    :initials => "MTS"
    )
  expect(dbl.full_name).to eq("Mary Smith")
  expect(dbl.initials).to eq("MTS")
end
```

### Providing a hash as arguments to double.

```
it 'allows setting to responses' do
  dbl = double("Person", :full_name => "Mary Smith", :initials => "MTS")
  expect(dbl.full_name).to eq("Mary Smith")
  expect(dbl.initials).to eq("MTS")
end
```
 It creates the double with stubs defined on it all in one step.

### Set consecutive return value

```
it 'allows setting multiple responses' do
  die = double("Die")
  allow(die).to receive(:roll).and_return(1,5,2,6)
  expect(die.roll).to eq(1)
  expect(die.roll).to eq(5)
  expect(die.roll).to eq(2)
  expect(die.roll).to eq(6)
  expect(die.roll).to eq(6)
end
```

Each die should return a random number from one to six.

It would be hard to write tests for a random number, so stubbing random responses can come in handy.
