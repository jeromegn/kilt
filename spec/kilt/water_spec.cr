require "../spec_helper"
require "../../src/water"

class WaterView
  Kilt.file "spec/fixtures/test.water"
end

describe "kilt/water" do

  it "renders water" do
    Kilt.render("spec/fixtures/test.water").should eq("<span>#{Process.pid}</span>")
  end

  it "works with class" do
    WaterView.new.to_s.should eq("<span>#{Process.pid}</span>")
  end

end
