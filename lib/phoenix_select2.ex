defmodule PhoenixSelect2 do
  @moduledoc false

  @missing_function_error_message """
  You need give the function to performs the search on live component.

  <%= live_component PhoenixSelect2, ..., search_function: your_nice_function %>
  """
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
    <div class="phx-select2-multi-search-select-container" x-data="{search_select: false}">
      <div class="phx-select2-multi-search-select-search-wrapper">
        <%= for selected_option <- @selected_options do %>
          <button
            type="button"
            class="phx-select2-multi-search-select-selected-option"
            phx-click="unselect-option"
            phx-value-option-id="<%= Map.get(selected_option, :id) %>"
            phx-target="<%= @myself %>"
          >
            <%= Map.get(selected_option, @content_key) %>
          </button>
        <% end %>

        <%= for option <- @selected_options do %>
          <input type="hidden" name="<%= @form.name %>[<%= @field %>][]" value="<%= option.id %>">
        <% end %>

        <input
          x-on:blur="setTimeout(()=>search_select=false, 200)"
          x-on:focus="search_select=true"
          x-transition
          type="text"
          value="<%= @search %>"
          placeholder="Search"
          autoComplete="off"
          phx-target="<%= @myself %>"
          phx-keyup="search"
        />
      </div>

      <ul x-show="search_select" x-transition class="phx-select2-multi-search-select-options-container">
        <%= for option <- @options do %>
          <%= if option not in @selected_options do %>
            <li
              phx-click="select-item"
              phx-value-option-id="<%= Map.get(option, :id) %>"
              phx-target="<%= @myself %>"
            >
              <%= Map.get(option, @content_key) %>
            </li>
          <% end %>
        <% end %>

        <%= if @options == [], do: @empty_message %>
      </ul>
    </div>
    """
  end

  def mount(socket) do
    {:ok,
     socket
     |> assign(:search, "")
     |> assign(:options, [])
     |> assign(:selected_options, [])
     |> assign(:empty_message, Map.get(socket, :empty_message, "Without items"))
     |> assign(:content_key, Map.get(socket, :content_key, :value))
     |> assign(:integer_id, Map.get(socket, :integer_id, false))
     |> assign(:form, Map.get(socket, :form, %{name: "multi_select"}))
     |> assign(:field, Map.get(socket, :field, "ids"))}
  end

  def handle_event("select-item", %{"option-id" => option_id}, socket) do
    integer_id = socket.assigns.integer_id

    clicked_option =
      if integer_id do
        socket.assigns.options
        |> Enum.find(&(&1.id == String.to_integer(option_id)))
      else
        socket.assigns.options
        |> Enum.find(&(&1.id == option_id))
      end

    {:noreply,
     socket
     |> update(:selected_options, &(&1 ++ [clicked_option]))}
  end

  def handle_event("unselect-option", %{"option-id" => option_id}, socket) do
    integer_id = socket.assigns.integer_id

    clicked_option_index =
      if integer_id do
        socket.assigns.selected_options
        |> Enum.find_index(&(&1.id == String.to_integer(option_id)))
      else
        socket.assigns.selected_options
        |> Enum.find_index(&(&1.id == option_id))
      end

    {:noreply,
     socket
     |> update(:selected_options, &List.delete_at(&1, clicked_option_index))}
  end

  def handle_event("search", %{"value" => text_input}, socket) do
    search_function = socket.assigns.search_function

    if is_nil(search_function) do
      raise(RuntimeError.exception(@missing_function_error_message))
    end

    result = search_function.(text_input)

    {:noreply, assign(socket, :options, result)}
  end
end
