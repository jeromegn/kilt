require "../spec_helper"
require "../../src/liquid"

class LiquidView
  @process = { "pid" => Process.pid }
  Kilt.file "spec/fixtures/test.liquid"
end

it "works with classes" do
  LiquidView.new.to_s.should eq("<span>#{Process.pid}</span>\n")
end
