require "ecr/macros"
require "./kilt/*"

module Kilt
  # macro only constants
  TEMPLATES = [] of Int32
  OVERRIDES = [] of Int32

  macro register_template(extension, embed_macro)
    {% ::Kilt::TEMPLATES << {extension, embed_macro} %}
    ::Kilt._override_embed
  end

  macro embed(filename, io_name = "__kilt_io__")
    {{::Kilt::OVERRIDES.last.id}}.embed({{filename}}, {{io_name}})
  end

  macro _override_embed
    {% override_name = "::Kilt::Override#{OVERRIDES.size}" %}

    module {{override_name.id}}
      macro embed(filename, io_name)
        {% start = true %}

        {% for template in ::Kilt::TEMPLATES %}
          {% extension = template[0] %}
          {% embed_macro = template[1] %}

          {% if start == true %}
            {% start = false %}

            \{% if filename.ends_with?({{extension}}) %}
              {{embed_macro.id}}(\{{filename}}, \{{io_name}})

          {% else %}

            \{% elsif filename.ends_with?({{extension}}) %}
              {{embed_macro.id}}(\{{filename}}, \{{io_name}})

          {% end %}
        {% end %}

            \{% else %}
              raise Kilt::Exception.new("Unsupported template type \"" + \{{filename.split(".").last}} + "\"")
            \{% {{:end.id}} %}
      end
    end

    {% ::Kilt::OVERRIDES << override_name %}
  end

  register_template(".ecr", embed_ecr)

  macro file(filename, io_name = "__kilt_io__")
    def to_s({{io_name.id}})
      Kilt.embed({{filename}}, {{io_name}})
    end
  end

end
