defmodule WebsubhubWeb.PageController do
  use WebsubhubWeb, :controller

  def index(conn, _params) do
    # return allowed methods in hal format
    # subscribe with required hub params
    # unsubscribe with subscription_id
    text conn, "hello websubhub"
  end
end
