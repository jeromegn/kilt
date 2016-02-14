require "spec"
require "slang"
require "../src/kilt"

macro render_file(filename)
  String.build do |__io__|
    Kilt.embed({{filename}}, "__io__")
  end
end