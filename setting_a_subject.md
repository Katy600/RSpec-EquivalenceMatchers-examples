# Setting a Subject

## Using Let
```
let(:car) { Car.new }

it 'allows reading for :wheels' do
  expect(car.wheels).to eq(4)
end

```
## Using subject

```

subject { Car.new }

it 'allows reading for :wheels' do
  expect(subject.wheels).to eq(4)
end

```
It's exactly the same as what we saw in the last slide. We just simply write subject, and that's the same thing as saying let subject be a new helper method with this block of code. Now we not only create the same instance method, but we've also made it clear in our code that the focus is on this subject variable.

Just like let, there's also another version of subject that uses the exclamation point after it. That's going to execute the block of code immediately instead of having it be lazy executed. It will be eager executed. All right, let's see how we can use subject in RSpec. So if we look at the specs that we have for attributes, we have let car be car new.


```
describe 'attributes' do
    subject { Car.new }
    it 'allows reading and writing for :make' do
      subject.make = 'Test'
      expect(subject.make).to eq('Test')
    end
  end
```
