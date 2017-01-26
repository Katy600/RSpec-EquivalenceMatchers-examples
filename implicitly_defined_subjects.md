# Implicitly Defined Subjects

```
describe 'Car' do

subject { Car.new }

  it "allows reading for :wheels" do
    expect(subject.wheels).to eq(4)
  end

end

```
RSpec also allows us to have implicitly defined subjects. See the line at the top that says describe and then has a string for Car after it? Describe either accept a string or a classname.

```
describe Car
  it 'allows reading for :wheels' do
    expect(subject.wheels).to eq(4)
  end
end

```

Using a classname gives you an extra benefit. The benefit of having an implicitly defined subject. This code works exactly like subject because you don't have to specify the subject. RSpec does it for you. As soon as it encounters the classname as an argument to describe it creates a helper method for subject. It guessed the subject would be the class Car implicitly.

The subject method will always refer to a bare bones instance of the class, just like I had before on the previous slide. If I needed something more complex then I can either redefine it explicitly, or I can use a before hook to modify the subject and make it into something more complex. This gives you a nice shorthand to use, especially when you're working with a Ruby class. Because then you can very easily just refer to that class as subject throughout your example file. All you have to do to get that benefit is use a classname after describe instead of using a string.

##  You should use the right one for the right case!

### Before hooks
- very useful for doing all sorts of business that needs to be taken care of before your examples run.
###  Let
- is just a more efficient way of doing a before hook when you're only working with an instance variable.
### Subject
- if that let is the subject that you're working with then you can use subject.
### subject implicitly define
- if your file is all dedicated to one class, then you can have subject implicitly define for you and even save yourself that step.
