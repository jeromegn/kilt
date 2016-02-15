require "ecr/macros"
require "./kilt/*"

module Kilt
  # macro only constant
  TEMPLATES = {} of String => Int32

  macro register_template(ext, embed_macro)
    {% ::Kilt::TEMPLATES[ext] = embed_macro %}
  end

  macro embed(filename, io_name = "__kilt_io__")
    {% ext = filename.split(".").last %}
    {% ext_with_dot = ".#{ext.id}" %}

    {% if ::Kilt::TEMPLATES[ext_with_dot] == nil %}
      raise Kilt::Exception.new("Unsupported template type \"" + {{ext}} + "\"")
    {% else %}
      {{::Kilt::TEMPLATES[ext_with_dot]}}({{filename}}, {{io_name}})
    {% end %}
  end

  macro file(filename, io_name = "__kilt_io__")
    def to_s({{io_name.id}})
      Kilt.embed({{filename}}, {{io_name}})
    end
  end
end

::Kilt.register_template(".ecr", embed_ecr)
