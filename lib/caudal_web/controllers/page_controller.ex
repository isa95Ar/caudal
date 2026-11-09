defmodule CaudalWeb.PageController do
  use CaudalWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
