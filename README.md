# RemoteRecord

RemoteRecord is a thin ORM wrapper around Her model objects intended to provide a more
consistent but limited ActiveRecord look and feel. It also provides several
convenience methods to aid in working with some quirks of JSON APIs, as well as an
object-oriented class definition space for custom class and instance methods.

#### Definition and instantiation

Defining a RemoteRecord model is easy, requiring only two steps: 1) subclassing
`RemoteRecord::Base` and 2) `source`ing the model's remote client.

```ruby
class Account < RemoteRecord::Base
  source :rolodex
end
```

The class method `source` expects the first argument to be a symbolized client name, 
and takes two optional hash parameters, `:class_name` and `:delegate_attributes`.
You can explicitly pass a stringified class name that corresponds to a definition on
the client, or RemoteRecord will infer the class name from the definition itself.
`:delegate_attributes` is a boolean defaulted to `true`, in which case RemoteRecord
will attempt to forward any undefined instance methods to the underlying Her
instance attribute getters.

The example above is therefore equivalent to the more verbose:

```ruby
class Account < RemoteRecord::Base
  source :rolodex, class_name: 'Account', delegate_attributes: true
end
```

You can reach the underlying client model from either class or instance scope 
via `.remote` and `#remote`, respectively.

```ruby
Account.remote # => Rolodex::Account
Account.new.remote # => Rolodex::Account
```

A subclass of `RemoteRecord::Base` without its corresponding `source` call will 
raise `RemoteRecord::SourceNotImplementedError` at runtime.

Instantiation is relatively simple via `.new`, accepting either a Her instance
directly, or a hash of attributes.

```ruby
her_instance = Rolodex::Account.find(1)
attributes   = { id: 1, name: 'John Smith', created_at: 2.months.ago }

Account.new(her_instance)
Account.new(attributes)
```

You can always reach the underlying Her instance with `#instance`.

#### Query interface

RemoteRecord provides `.find(id)`, `.find_by({})`, and `.where({})`,
mimicking ActiveRecord.

#### Implicit delegation

If `:delegate_attributes` is set to `true` (default), RemoteRecord will attempt to
forward any undefined instance methods to the underlying Her instance attribute
getters.

Additionally, a bare `delegate :method_name` without its `:to` argument implicitly
delegates the method to the Her instance. You can of course still use `delegate` to 
explicitly forward to another object by passing `to: :another_object`.

```ruby
delegate :first_name
delegate :first_name, to: :instance
# equivalent!
```

#### Persistence

RemoteRecord provides `.create({})`, as well as `#save` and `#update({})`, again 
mimicking ActiveRecord.

#### Attribute conversion

The Her model, itself a wrapper of JSON, only returns attribute values as instances
of String or Integer. RemoteRecord lends a hand with a convenience class method,
`.convert`, accepting two arguments - the symbolized attribute name and a symbolized
conversion method from the standard/core Ruby or Rails libraries.

```ruby
class Account < RemoteRecord::Base
  source :rolodex

  convert :amount,     :to_f
  convert :created_at, :to_datetime
  convert :status,     :inquiry
end
```
