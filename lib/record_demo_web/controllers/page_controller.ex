defmodule RecordDemoWeb.PageController do
  use RecordDemoWeb, :controller
  alias RecordDemo.User

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    user = User.new_user("John Doe", 30, "john@example.com")

    # Get user info
    user_info = User.get_info(user)

    render(conn, :home, user_info: user_info)
  end
end
