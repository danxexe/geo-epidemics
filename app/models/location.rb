class Location
  include Mongoid::Document

  field :position, type: Point, default: -> { Point.new }
  field :tag, type: String
end