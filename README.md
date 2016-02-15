# Kilt [![Build Status](https://travis-ci.org/jeromegn/kilt.svg?branch=master)](https://travis-ci.org/jeromegn/kilt) [![Dependency Status](https://shards.rocks/badge/github/jeromegn/kilt/status.svg)](https://shards.rocks/github/jeromegn/kilt) [![devDependency Status](https://shards.rocks/badge/github/jeromegn/kilt/dev_status.svg)](https://shards.rocks/github/jeromegn/kilt)

Generic templating interface for Crystal.

## Goal

Simplify developers' lives by abstracting template rendering for multiple template languages.

## Supported out of the box

| Language | File extensions | Required libraries |
| -------- | --------------- | ------------------ |
| ECR      | .ecr            | none (part of the stdlib) |

See also:
[Registering your own template engine](#registering-your-own-template-engine).

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  kilt:
    github: jeromegn/kilt
  
  # Any other template languages Crystal shard
```

## Usage

- Kilt essentially adds two macros `Kilt.embed` and `Kilt.file`, the code is really simple.
- Add template language dependencies, as listed in the support table above.

Both macros take a `filename` and a `io_name` (the latter defaults to `"__kilt_io__"`)

### Example

```crystal
require "kilt"
require "slang" # if you want to use Slang templates, for instance

# With a Class

class YourView
  Kilt.file("path/to/template.ecr") # Adds a to_s method
end
puts YourView.new.to_s # => <compiled template>


# Embedded

str = String.build do |__kilt_io__|
  Kilt.embed "path/to/template.slang"
end

puts str # => <compiled template>
```

## Registering your own template engine

Use `Kilt.register_template(extension, embed_command)` macro:

```crystal
require "kilt"

module MyEngine
  macro embed(filename, io_name)
    # ....
  end
end

Kilt.register_template("myeng", ::MyEngine.embed)
```

This can be part of your own `my-engine` library: in this case it should depend
on `kilt` directly, or this could be a part of adapter library, like:
`kilt-my-engine`, which will depend on both `kilt` and `my-engine`.

## Contributing

Please contribute your own "adapter" if you create a template language for Crystal that's not yet supported here!

1. Fork it ( https://github.com/jeromegn/kilt/fork )
2. Create your feature branch (git checkout -b my-awesome-template-language)
3. Commit your changes (git commit -am 'Add my-awesome-template-language')
4. Push to the branch (git push origin my-awesome-template-language)
5. Create a new Pull Request

## Contributors

- [jeromegn](https://github.com/jeromegn) Jerome Gravel-Niquet - creator, maintainer
