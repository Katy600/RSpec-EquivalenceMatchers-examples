# Shared Examples

```
describe Product do
  it 'has a position attribute' do
    expect(subject).to respond_to(:position)
  end

  it 'sorts position lowest first by default' do
  it 'assigns positions to new items' do
end

```
These examples test whether a product can be sorted by its position attribute.

  If other classes need to be sorted by a position attribute too, then it would not be efficient for us to cut and paste these examples into another spec file or example group. That would violate the principle of don't repeat yourself in a big way. *Shared examples provide a way for you to reuse examples in different example groups*.

# How to create a shared example?

Move this code out of the describe block, and into a shared_examples_for block. The only thing that changes is the first line.


```
shared_examples_for('a sortable') do
  it 'has a position attribute' do
    expect(subject).to respond_to(:position)
  end

  it 'sorts position lowest first by default' do
  it 'assigns positions to new items' do
end

```

We use shared_examples_for, and then we pass in a string as the name, or the label, for this shared example set. We can then have as many shared example sets as we want. And we can refer to them by name. Typically, you would put this in a new file. That file can be anywhere in your spec directory.

I would suggest creating a new directory called shared examples, or some people create a directory called support. And then put all of your shared examples in separate files in that directory. Once we have the example declared, then we can use it in our example group for product. We use the RSpec method it_behaves_like to include the shared examples, followed by the name or the label that we gave it.


```
describe Product do
    it_behaves_like 'a sortable'
end
```

So, describe Product do, it_behaves_like 'a sortable'. it_behaves_like will include the examples in this example group. It's as if we were to cut and paste them in here.
```
describe ProductImage do
    it_behaves_like 'a sortable'
end
```

In this case, I have product images that go with my product, and also need to be sorted in the correct order. *Because we used the implicitly defined subject in our example, the subject inside the product example group will be Product.*

And the subject inside the product image group will be ProductImage. That's where the complexity of shared examples lies though. We start getting into something that feels like metaprogramming.
#### Make sure that your example is abstract enough so that it can work in multiple contexts.
If our shared example was called the Product class directly, then it wouldn't be abstract. And it wouldn't be flexible enough for us to use with ProductImage.
##### Shared examples work best for common, fundamental behaviors. Ruby classes that act like a list sorted on the position is a common behavior.

#### Another place shared examples work really well is...
 APIs and common actions.
 We haven't talked about Ruby on Rails yet, but in Rails, it's very common to have standard actions for CRUD, and for a RESTful API.
 ```
 describe ProductController do
    describe '#index'
      it_behaves_like 'a standard index action'
    end

    describe '#new'
      it_behaves_like 'a standard new action'
    end

    describe '#create'
      it_behaves_like 'a standard create action'
    end
 end
 ```

 Most Rails controllers respond to actions for index, show, new, create, edit, update, and destroy. Shared examples allow us to write examples for each of those actions, and then reuse them across our controllers.

 ### Shared Examples also take a block

 ```
 shared_examples_for('a sortable') do
    it 'sorts position lowest first by default' do
      positions = collection.map($:position)
      expect(positions).to eq(positions.sort)
      end
    end
 end
 ```
If we want to write our example for sorting a collection of items by the lowest item first, we need a collection of items to work with. We have an implicitly defined subject to work with, but that only gives us a single instance. What we need is a collection of instances. And they should all be different, with different positions that we can sort them on.


 In the first line in this example, you can see that I'm calling collection in order to get that collection and use it. So how do we assign it? After the it_behaves_like method, we can add a block. And that block will be called before the examples are included, and before they're executed. Need to set up a different collection for each one? No problem. We can tell Product to set up a collection of five products. Then we can tell ProductImage to set up a collection of five product images. And we can do that using let. And inside that block, you can include code with before and after hooks as well.
