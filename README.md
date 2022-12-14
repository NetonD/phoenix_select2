# PhoenixSelect2

This is just a `live componet` that improves the multi select user experience. 
## Installation

**Is supposed that you already has LiveView and is using Phoenix**
```elixir
def deps do
  [
    {:phoenix_select2, "~> 0.1.0"}
  ]
end
```

## Using

There some parameters that can given for `live_component/1` as assign function that will
be captured in `mount/1` and used by the handle_events, just the **seach_function** is mandatory.
**Do not forget to give an `id` to live component** 

Assigns:
  * `search_function` - a arity one function that receives the parameter to your search. This function must return a list
  of maps (or structs) where this elements must have the `content_key` key to be possible retrieve the content. And more, your registers must have an uniq `id`.
  * `empty_message` - a message when haven't options
  * `content_key` - the map key used to retrieve the content that will be showed from `search_function` result.
  * `integer_id` - if is used integers id set this assign as `true`.
  * `field` - the field to this select respond. 
  * `form` - your form, if none form is given the default multi-select name is setup to `multi_select` 


And just use this like a component that it is:

```elixir
# In your template .leex
...

<%= live_component PhoenixSelect2, 
  id: "multi_select_search", 
  search_function: fn _search_parameter -> [%{id: 1, content_key: "item"}] end 
  integer_id: true %>
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/phoenix_select2>.

