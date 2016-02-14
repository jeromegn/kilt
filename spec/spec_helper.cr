require "spec"
require "../src/kilt"

require "slang"
Kilt.register_template(".slang", embed_slang)

macro render_file(filename)
  String.build do |__io__|
    Kilt.embed({{filename}}, "__io__")
  end
end
