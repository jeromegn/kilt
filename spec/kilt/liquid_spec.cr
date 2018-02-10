require "../spec_helper"
require "../../src/liquid"

class LiquidView
  @process = { "pid" => Process.pid }
  Kilt.file "spec/fixtures/test.liquid"
end

class LiquidViewWithCustomContext
  # Use of instance variable is not required in user code. It is used here to
  # avoid name clash with 'context' variable existing within spec.
  def initialize
    @context = Liquid::Context.new
    @context.set "process", { "pid" => Process.pid }
  end
  Kilt.file "spec/fixtures/test.liquid", "__kilt_io__", "@context"
end

it "renders liquid" do
  ctx = Liquid::Context.new
  ctx.set "process", { "pid" => Process.pid }
  Kilt.render("spec/fixtures/test.liquid", ctx).should eq("<span>#{Process.pid}</span>\n")
end

it "works with classes" do
  LiquidView.new.to_s.should eq("<span>#{Process.pid}</span>\n")
end

it "works with classes and custom context" do
  LiquidViewWithCustomContext.new.to_s.should eq("<span>#{Process.pid}</span>\n")
end
