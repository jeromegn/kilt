require "ecr/macros"
require "./kilt/*"

module Kilt
  
  macro embed(filename, io_name = "__io__")
    {% if filename.ends_with?(".ecr") %}
      embed_ecr({{filename}}, {{io_name}})
    {% elsif filename.ends_with?(".slang") %}
      embed_slang({{filename}}, {{io_name}})
    {% else %}
      raise Kilt::Exception.new("Unsupported template type \"" + {{filename.split(".").last}} + "\"")
    {% end %}
  end

  macro file(filename)
    def to_s(__io__)
      Kilt.embed({{filename}}, "__io__")
    end
  end

end
