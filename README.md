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

Add this class on your `app.css`:
```css
.phx-select2-multi-search-select-container {
  position: relative;
  width: 100%;
  background: #ffffff;
}

.phx-select2-multi-search-select-search-wrapper {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  position: relative;
  padding: 0.3em 0.3em 0;
  border: 1px solid #cccccc;
  border-radius: 0.25em;
}

.phx-select2-multi-search-select-loading {
  display: flex;
  align-items: center;
  margin-bottom: 0.3em;
}

.phx-select2-multi-search-select-loading > span {
  margin-left: 0.5em;
}

.phx-select2-multi-search-select-container input {
  flex: 1;
  height: 1.5em;
  margin-bottom: 0.3em;
  border: none;
  background: #ffffff;
}

.phx-select2-multi-search-select-container input:focus {
  outline: none;
}

.phx-select2-multi-search-select-selected-option {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 0.3em 0.6em;
  background: #90c8ea;
  margin-right: 0.3em;
  margin-bottom: 0.3em;
  border-radius: 0.25em;
  appearance: none;
  border: 0;
  outline-color: #50a8de;
  font-size: 14px;
  color: #ffffff;
  white-space: nowrap;
  cursor: pointer;
}

.phx-select2-multi-search-select-selected-option:hover {
  background: #a6d3ee;
}

.phx-select2-multi-search-select-options-container {
  position: absolute;
  width: 100%;
  max-height: 15em;
  margin: 0;
  padding: 0;
  border: 1px solid #cccccc;
  background: #ffffff;
  border-radius: 0.25em;
  list-style: none;
  overflow-y: auto;
  z-index: 2;
}

.phx-select2-multi-search-select-options-container li {
  padding: 0.5em;
}

.phx-select2-multi-search-select-options-container li.active {
  background: #90c8ea;
  color: #ffffff;
}

.phx-select2-multi-search-select-options-container li:not(.no-hover):hover {
  background: #90c8ea;
  color: #ffffff;
  cursor: pointer;
}
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

