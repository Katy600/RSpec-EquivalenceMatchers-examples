describe 'predicate matchers' do
  it 'will be_* to custom method ending in ?' do
    #drops "be_", adds "?" to end, calls method on object
    #Can use these when methods end in '?', require no arguments,
    # and return true/false.

    # with built in methods
    expect([]).to be_empty # [].empty?
    expect(1).to be_integer # [].integer?
    expect(0).to be_zero # [].zero?
    expect(1).to be_nonzero # 1.nonezero?
    expect(1).to be_odd # 1.odd?
    expect(2).to be_even #1.even?

    #be_nil is exactly an example of his too
    #with custom methods

    #be_nil is actually an example of his too
    #with custom methods
    class Product
      def visible?; true; end
    end

    product = Product.new
    expect(product)
    expect(product.visible?).to be true #exactly the same as this
  end

    it "will match have_* to comstom methods like has_*?" do

    #changes "have_" to "has_", adds "?" to end , calls method on an object
    #Can use these when methods start with "has_", end in "?"
    # and return true/false. Can have arguments, but not required.

    # with built in methods
    hash = {:a => 1, :b => 2}
    expect(hash).to have_key(:a) #hash.has_key?
    expect(hash).to have_value(2) #hash.has_value?

      #with custom methods
      class Customer
        def has_pending_order?; true; end
      end
      customer = Customer.new

      expect(customer).to have_pending_order # customer.has_pending_order?
      expect(customer.has_pending_order?).to be true #same as thi
  end
end
