require "../spec_helper"
require "../../src/jbuilder"

class JbuilderView
  Kilt.file "spec/fixtures/test.jbuilder"
end

describe "kilt/jbuilder" do

  it "renders jbuilder" do
    Kilt.render("spec/fixtures/test.jbuilder").should eq("{\"span\":#{Process.pid}}")
  end

  it "works with class" do
    JbuilderView.new.to_s.should eq("{\"span\":#{Process.pid}}")
  end

end
