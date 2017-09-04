FactoryGirl.define do

  factory :foo_fixed, class: 'Foo' do
    name "test"
  end

  factory :foo_sequence, class: 'Foo' do
    sequence(:name) {|n| "test#{n}" }
  end

  factory :foo_names, class: 'Foo' do
    sequence(:name) {|n| ["larry", "moe", "curly"][n%3]  }
  end

  # FactoryGirl.build(:foo_transient)
  # FactoryGirl.build(:foo_transient, :male=>false)
  factory :foo_transient, class: 'Foo' do
    transient do
      # transient information: not part of the class
      male true
    end

    # after build, pass the object built and pass the transient block
    after(:build) do |object, props|
      # name is a property of the object passed
      # male is a property of the transient block passed
      object.name = props.male ? "Mr Test" : "Ms Test"
    end
  end

  factory :foo_faker, class: 'Foo' do
    name { Faker::Name.name }
  end

  # In previous, the Foo was created, and the name changed
  # If we have an immutable object, that must be instantiated in the constructor (new)
  factory :foo_ctor, class: 'Foo' do
    transient do
      hash {}
    end
    initialize_with { Foo.new(hash) }
  end

  factory :foo, :parent=>:foo_faker do
    # Create a new default FactoryGirl factory for the Foo model that replaces the dynamic names generated
    # for Foo#name by Faker. Your new factory must return names in the form of name0, name1, name2, for each time
    # it is called and return to name0 after reaching name9.
    sequence(:name) {|n| "name" + ["0","1","2","3","4","5","6","7","8","9"][n%10] }
  end

  factory :bar do
    name { Faker::Team.name.titleize }
  end
end
