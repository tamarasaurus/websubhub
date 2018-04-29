defmodule WebsubhubWeb.SubscribeControllerTest do
  use WebsubhubWeb.ConnCase

  describe "posting to /subscribe with" do
    test "wrong parameters returns a 404", %{conn: conn} do
      response = post(conn, "/subscribe", %{"test" => "nothing"})
      assert response.status == 404
      response = post(conn, "/subscribe")
      assert response.status == 404
    end

    test "the wrong content type returns a 404", %{conn: conn} do
      correct_params = %{
        "hub.callback" => "callback",
        "hub.mode" => "subscribe",
        "hub.topic" => "topic"
      }

      incorrect_content_type = "application/json"

      response =
        conn
        |> put_req_header("content-type", incorrect_content_type)
        |> post("/subscribe", correct_params)

      assert response.status == 404
    end

    test "the right parameters creates a subscription in the database", %{conn: conn} do
      correct_params = %{
        "hub.callback" => "callback",
        "hub.mode" => "subscribe",
        "hub.topic" => "topic"
      }

      response =
        conn
        |> put_req_header("content-type", "application/x-www-form-urlencoded; charset=utf-8")
        |> post("/subscribe", correct_params)

      assert response.status == 200

      subscription =
        Websubhub.Repo.get_by(
          Websubhub.Subscription,
          callback_url: "callback",
          topic_url: "topic"
        )

      assert {:ok, response.resp_body} == Poison.encode(subscription)
    end

    test "an existing topic_url and callback_url updates an existing subscription", %{conn: conn} do
      correct_params = %{
        "hub.callback" => "callback",
        "hub.mode" => "subscribe",
        "hub.topic" => "topic"
      }

      response =
        conn
        |> put_req_header("content-type", "application/x-www-form-urlencoded; charset=utf-8")
        |> post("/subscribe", correct_params)

      assert response.status == 200

      subscription =
        Websubhub.Repo.get_by(
          Websubhub.Subscription,
          callback_url: "callback",
          topic_url: "topic"
        )

      assert {:ok, response.resp_body} == Poison.encode(subscription)

      {:ok, before_update} = Poison.decode(response.resp_body)

      response =
        conn
        |> put_req_header("content-type", "application/x-www-form-urlencoded; charset=utf-8")
        |> post("/subscribe", correct_params)

      {:ok, after_update} = Poison.decode(response.resp_body)

      assert before_update["expired_at"] !== after_update["expired_at"]
    end
  end

  describe "posting to /unsubscribe with" do
    test "the wrong parameters returns a 404", %{conn: conn} do
      response = post(conn, "/unsubscribe", %{"test" => "nothing"})
      assert response.status == 404
      response = post(conn, "/unsubscribe")
      assert response.status == 404
    end

    test "the right parameters removes a subscription from the database and returns a 410", %{
      conn: conn
    } do
      correct_params = %{
        "hub.callback" => "callback1",
        "hub.mode" => "subscribe",
        "hub.topic" => "topic1"
      }

      response =
        conn
        |> put_req_header("content-type", "application/x-www-form-urlencoded; charset=utf-8")
        |> post("/subscribe", correct_params)

      assert response.status == 200

      subscription =
        Websubhub.Repo.get_by(
          Websubhub.Subscription,
          callback_url: "callback1",
          topic_url: "topic1"
        )

      assert subscription

      response =
        post(conn, "/unsubscribe", %{
          "callback_url" => "callback1",
          "topic_url" => "topic1",
          "hub.mode" => "unsubscribe"
        })

      assert response.status == 410

      subscription =
        Websubhub.Repo.get_by(
          Websubhub.Subscription,
          callback_url: "callback1",
          topic_url: "topic1"
        )

      assert subscription == nil
    end
  end
end
