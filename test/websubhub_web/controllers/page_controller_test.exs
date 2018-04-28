defmodule WebsubhubWeb.PageControllerTest do
  use WebsubhubWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert text_response(conn, 200) =~ "hello websubhub"
  end
end
