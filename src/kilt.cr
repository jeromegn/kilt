require "ecr/macros"
require "./kilt/*"

module Kilt

  macro embed(filename, io_name = "__kilt_io__")
    {% if filename.ends_with?(".ecr") %}
      embed_ecr({{filename}}, {{io_name}})
    {% elsif filename.ends_with?(".slang") %}
      embed_slang({{filename}}, {{io_name}})
    {% else %}
      raise Kilt::Exception.new("Unsupported template type \"" + {{filename.split(".").last}} + "\"")
    {% end %}
  end

  macro file(filename, io_name = "__kilt_io__")
    def to_s({{io_name.id}})
      Kilt.embed({{filename}}, {{io_name}})
    end
  end

end
