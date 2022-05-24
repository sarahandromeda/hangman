require 'json'

module Serialization

  def serialize
    obj = {}
    instance_variables.map do |var|
      obj[var] = instance_variable_get(var)
    end
    dest = open('./saves/save.txt', 'w')
    dest.puts JSON.dump obj
    dest.close
  end

  def self.unserialize
    source = open('./saves/save.txt', 'r')
    obj = JSON.parse(source.readline)
  end
end
