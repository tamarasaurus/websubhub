defmodule DistributeContentTest do
  use ExUnit.Case

  alias Websubhub.DistributeContent, as: DistributeContent

  test "distributes content" do
    assert DistributeContent !== nil
    assert DistributeContent.distribute(1) == 1
  end
end
