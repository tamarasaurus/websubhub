defmodule WebsubhubWeb.HubControllerTest do
  use WebsubhubWeb.ConnCase

  test "wrong parameters returns a 404", %{conn: conn} do
    response = post(conn, "/", %{"test" => "nothing"})
    assert response.status == 404
    response = post(conn, "/")
    assert response.status == 404
  end

  test "the right parameters creates a subscription in the database", %{conn: conn} do
    correct_params = %{
      "hub.callback" => "http://localhost:4001",
      "hub.mode" => "subscribe",
      "hub.topic" => "topic2"
    }

    response =
      conn
      |> put_req_header("content-type", "application/x-www-form-urlencoded; charset=utf-8")
      |> post("/", correct_params)

    assert response.status == 202
  end
end
