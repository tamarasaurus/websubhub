defmodule WebsubhubWeb.SubscribeControllerTest do
  use WebsubhubWeb.ConnCase

  test "POST /subscribe creates a subscription"

  describe "posting to /subscribe with" do
    test "wrong parameters returns a 404"
    test "the wrong content type returns a 404"
    test "the right parameters creates a subscription in the database"
    test "an existing topic_url and callback_url updates an existing subscription"
  end

  test "POST /unsubscribe deactivates a subscription"

  describe "posting to /unsubscribe with" do
    test "the wrong parameters returns a 404"
    test "the wrong content type returns a 404"
    test "the right parameters removes a subscription from the database"
  end

end
