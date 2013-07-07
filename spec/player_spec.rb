require 'minitest/autorun'
require_relative '../lib/player'

describe Player do
  it "allows you to set the username by default" do
    player = Player.new("Bobby Crouton")
    player.name.must_equal "Bobby Crouton"
  end

  it "accepts no arguments on initialization" do
    player = Player.new
    player.name.must_be_nil
  end

  it "can set the name after initialization" do
    player = Player.new
    player.name = "Steven Nunez"
    player.name.must_equal "Steven Nunez"
  end
end

