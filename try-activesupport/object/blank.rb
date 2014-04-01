require 'bundler/setup'
require 'active_support/core_ext/object/blank'
require 'pp'

['', ' ', nil, false].each do |address|
  if !address || address.empty?
    puts 'addressが空です'
  end

  if address.blank?
    puts 'addressが空です'
  end
end



params = {name: 'hoge'}

name = params[:name] ? params[:name] : 'default'
pp name

params = {}
pp params[:name].presence
name = params[:name].presence || 'default'
pp name
