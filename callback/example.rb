require_relative 'super_simple_callback'

class MyObservedHouse
  include SuperSimpleCallbacks

  before :party, [:walk_dinosaure, :prepare, :just_idle]
  after :party, [:just_idle, :keep_house, :walk_dinosaure]

  before :home_office, [:just_idle, :prepare, :just_idle]
  after :home_office, [:just_idle, :walk_dinosaure, :just_idle]

  before :second_level, [:party]

  def home_office
    puts "learning and working with ruby...".upcase
  end

  def party
    puts "having party...".upcase
  end

  def just_idle
    puts "...."
  end

  def prepare
    puts "preparing snacks..."
  end

  def keep_house
    puts "house keeping..."
  end

  def walk_dinosaure
    puts "walking the dinosaure..."
  end

  def second_level
    puts "second level..."
  end
end

MyObservedHouse.new.tap do |house|
  puts "-------------------------"
  puts "-- about calling party --"
  puts "-------------------------"

  house.party

  puts "-------------------------------"
  puts "-- about calling home_office --"
  puts "-------------------------------"

  house.home_office

  puts "--------------------------------"
  puts "-- about calling second_level --"
  puts "--------------------------------"

  house.second_level
end
# => ...
# -------------------------
# -- about calling party --
# -------------------------
# walking the dinosaure...
# preparing snacks...
# ....
# HAVING PARTY...
# ....
# house keeping...
# walking the dinosaure...
# -------------------------------
# -- about calling home_office --
# -------------------------------
# ....
# preparing snacks...
# ....
# LEARNING AND WORKING WITH RUBY...
# ....
# walking the dinosaure...
# ....
# --------------------------------
# -- about calling second_level --
# --------------------------------
# walking the dinosaure...
# preparing snacks...
# ....
# HAVING PARTY...
# ....
# house keeping...
# walking the dinosaure...
# second level...
