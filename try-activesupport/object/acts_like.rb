require 'bundler/setup'
require 'active_support/core_ext/object/acts_like'

class Car
  def acts_like_car?; true; end
  def drive
    puts '走行します'
  end
end

class Boat
  def acts_like_boat?; true; end
  def sail
    puts '航行します'
  end
end

class AmphibianCar < Car
  def acts_like_boat?; true; end
  def sail
    puts '水中走行します'
  end
end

def run(vehicle)
  if vehicle.acts_like?(:car)
    vehicle.drive
  end
  if vehicle.acts_like?(:boat)
    vehicle.sail
  end
end

run Car.new
# => 走行します

run Boat.new
# => 航行します

run AmphibianCar.new
# => 走行します
# => 水中走行します
