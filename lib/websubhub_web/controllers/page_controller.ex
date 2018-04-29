defmodule WebsubhubWeb.PageController do
  use WebsubhubWeb, :controller

  def index(conn, _params) do
    text conn, "endpoints"
  end
end
