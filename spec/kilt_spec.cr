require "./spec_helper"

class View
  Kilt.file "spec/fixtures/test.ecr"
end

describe Kilt do

  it "renders ecr" do
    render_file("spec/fixtures/test.ecr").should eq("<span>#{Process.pid}</span>")
  end

  it "renders slang" do
    render_file("spec/fixtures/test.slang").should eq("<span>#{Process.pid}</span>")
  end

  it "works with classes" do
    View.new.to_s.should eq("<span>#{Process.pid}</span>")
  end

  it "raises with unsupported filetype" do
    expect_raises(Kilt::Exception, "Unsupported template engine for extension: \"abc\"") {
      render_file("test.abc")
    }
  end

end
