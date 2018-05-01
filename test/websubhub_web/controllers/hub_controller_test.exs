defmodule WebsubhubWeb.HubControllerTest do
  use WebsubhubWeb.ConnCase

  test "get endpoints", %{conn: conn} do
    response = get conn, "/"
    assert response.status == 200
    assert response.resp_body == "endpoints"
  end

  test "publish topic contents", %{conn: conn} do
    response = post conn, "/", %{}
    assert response.status == 200
    assert response.resp_body == "\"ok\""
  end
end
