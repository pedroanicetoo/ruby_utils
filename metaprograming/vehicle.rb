
class Truck
  attr_accessor :is_used

 def initialize(is_used:)
   @is_used = is_used
 end

 def Truck_condition?
   @is_used ? 'used' : 'new'
 end
 end

 class Sedan
 attr_accessor :is_used

 def initialize(is_used:)
   @is_used = is_used
 end

 def Sedan_condition?
   @is_used ? 'used' : 'new'
 end
end


## Exercise: define these classes above with dinamically...

class MyBaseClass; end

attributes = [:is_used]
methods = ['condition']

klass = Class.new(MyBaseClass) do
  ATTRIBUTES = attributes
  attr_accessor *ATTRIBUTES
  def initialize(*args)
    raise ArgumentError, "Too many arguments" if args.size != ATTRIBUTES.size
    ATTRIBUTES.zip(args) do |attr, val|
      send "#{attr}=", val
    end
  end

  methods.each do |method|
    send(:define_method, method) { @is_used ? 'used' : 'new' }
  end
end

# Define Truck
Object.const_set 'Truck', klass
# Defibe Sedan
Object.const_set 'Sedan', klass

# Instance classes
Truck.new(true) # => #<Truck:0x007f934a975830 @is_used=true>
Sedan.new(false) # => #<Sedan:0x007f934a975830 @is_used=false>

# PT 2
# improvements -> make dinamically method assignment ...
