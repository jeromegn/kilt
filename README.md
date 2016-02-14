# Kilt

Generic templating interface for Crystal.

## Goal

Simplify developers' lives by abstracting template rendering for multiple template languages.

## Supported

| Language | File extensions | Required libraries |
| -------- | --------------- | ------------------ |
| ECR      | .ecr            | none               |
| Slang    | .slang          | [slang](https://github.com/jeromegn/slang) |

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  kilt:
    github: jeromegn/kilt
  
  # Any other template languages Crystal shard
```

## Usage

Add template language dependencies, as listed in the support table above.

```crystal
require "kilt"
require "slang" # if you want to use Slang templates, for instance

# With a Class

class YourView
  Kilt.file("path/to/template.ecr") # Adds a to_s method
end
puts YourView.new.to_s # => <compiled template>


# Embedded

str = String.build do |str|
  Kilt.embed "path/to/template.slang", "str"
end

puts str # => <compiled template>
```

## Contributing

Please contribute your own "adapter" if you create a template language for Crystal that's not yet supported here!

1. Fork it ( https://github.com/jeromegn/kilt/fork )
2. Create your feature branch (git checkout -b my-awesome-template-language)
3. Commit your changes (git commit -am 'Add my-awesome-template-language')
4. Push to the branch (git push origin my-awesome-template-language)
5. Create a new Pull Request

## Contributors

- [jeromegn](https://github.com/jeromegn) Jerome Gravel-Niquet - creator, maintainer
