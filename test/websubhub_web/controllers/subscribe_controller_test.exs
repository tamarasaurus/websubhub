defmodule WebsubhubWeb.SubscribeControllerTest do
  use WebsubhubWeb.ConnCase

  describe "posting to /subscribe with" do
    test "wrong parameters returns a 404", %{conn: conn} do
      response = post(conn, "/subscribe", %{})

      assert response.resp_body == "Not found"
      assert response.status == 404

      response = post(conn, "/subscribe")

      assert response.resp_body == "Not found"
      assert response.status == 404
    end

    test "the wrong content type returns a 404", %{conn: conn}  do
      correct_params = %{
        "hub.callback" => "callback",
        "hub.mode" => "subscribe",
        "hub.topic" => "topic",
        "hub.secret" => "secret"
      }

      incorrect_content_type = "application/json"

      response = conn
        |> put_req_header("content-type", incorrect_content_type)
        |> post("/subscribe", correct_params)

      assert response.resp_body == "Not found"
      assert response.status == 404
    end

    test "the right parameters creates a subscription in the database", %{conn: conn} do
      correct_params = %{
        "hub.callback" => "callback",
        "hub.mode" => "subscribe",
        "hub.topic" => "topic",
        "hub.secret" => "secret"
      }

      response = conn
        |> put_req_header("content-type", "application/x-www-form-urlencoded; charset=utf-8")
        |> post("/subscribe", correct_params)

      assert response.status == 200
      subscription = Websubhub.Repo.get_by(Websubhub.Subscription, callback_url: "callback", topic_url: "topic")
      assert {:ok, response.resp_body} == Poison.encode(subscription)
    end

    test "an existing topic_url and callback_url updates an existing subscription"
  end

  describe "posting to /unsubscribe with" do
    test "the wrong parameters returns a 404"
    test "the wrong content type returns a 404"
    test "the right parameters removes a subscription from the database and returns a 410"
  end

end
