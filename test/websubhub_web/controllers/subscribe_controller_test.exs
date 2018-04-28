defmodule WebsubhubWeb.SubscribeControllerTest do
  use WebsubhubWeb.ConnCase

  test "subscribe to a topic with incorrect params", %{conn: conn} do
    conn = post conn, "/subscribe"
    assert text_response(conn, 200) =~ "hello websubhub"
  end
end
