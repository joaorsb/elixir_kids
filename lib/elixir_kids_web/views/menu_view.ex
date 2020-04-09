defmodule ElixirKidsWeb.MenuView do
    use ElixirKidsWeb, :view
    alias ElixirKids.Blog

    def show_menu(conn) do
        conn
        |> render_menu_view
    end

    defp render_menu_view(_) do
        neighborhoods = Blog.list_neighborhoods()
        free_categories = Blog.list_categories_select_by_type("Free")
        paid_categories = Blog.list_categories_select_by_type("Paid")
        render "_menu_view.html", neighborhoods: neighborhoods, free_categories: free_categories, paid_categories: paid_categories
    end

end