require 'bundler/setup'
require 'active_support/core_ext/object/conversions'
require 'pp'

val = 100
array = [1, 2, 3]
hash = {
    hoge: 'fuga',
    val: 100
}
date = Date.today

# to_param
pp val.to_param # => 100
pp array.to_param # => "1/2/3"
pp hash.to_param # => "hoge=fuga&val=100"
pp date.to_param # => "2014-04-02"

# to_query
pp val.to_query('val') # => "val=100"
pp array.to_query('array') # => "array%5B%5D=1&array%5B%5D=2&array%5B%5D=3"
pp hash.to_query('hash') # => "hash%5Bhoge%5D=fuga&hash%5Bval%5D=100"
pp hash.to_query # => "hoge=fuga&val=100"
pp date.to_query('date') # => "date=2014-04-02"

