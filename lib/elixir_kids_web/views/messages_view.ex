defmodule ElixirKidsWeb.MessagesView do
    use ElixirKidsWeb, :view

    def show_flash_message(conn) do
        conn
        |> get_flash
        |> flash_message
    end

    defp flash_message(%{"info" => message}) do
        render "_flash_message.html", class: "success", message: message
    end

    defp flash_message(%{"error" => message}) do
        render "_flash_message.html", class: "danger", message: message
    end

    defp flash_message(_), do: nil
  end