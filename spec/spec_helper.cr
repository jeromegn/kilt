require "spec"
require "../src/kilt"

module Raw
  macro embed(filename, io)
    {{ io.id }} << {{`cat #{filename}`.stringify}}
  end
end