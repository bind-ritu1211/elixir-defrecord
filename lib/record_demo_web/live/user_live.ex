defmodule RecordDemoWeb.UserLive do
  use RecordDemoWeb, :live_view
  alias RecordDemo.User

  def mount(_params, _session, socket) do
    # Create some initial users
    initial_users = [
      User.new_user("John Doe", 30, "john@example.com"),
      User.new_user("Jane Smith", 25, "jane@example.com")
    ]

    {:ok, assign(socket, users: initial_users, form: to_form(%{}))}
  end

  def handle_event("add_user", %{"user" => params}, socket) do
    new_user = User.new_user(
      params["name"],
      String.to_integer(params["age"]),
      params["email"]
    )

    {:noreply,
     socket
     |> update(:users, fn users -> [new_user | users] end)
     |> assign(form: to_form(%{}))}
  end

  def handle_event("delete_user", %{"index" => index}, socket) do
    index = String.to_integer(index)
    updated_users = List.delete_at(socket.assigns.users, index)
    {:noreply, assign(socket, users: updated_users)}
  end

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-3xl p-6">
      <h1 class="text-2xl font-bold mb-6">User Records Demo</h1>

      <div class="bg-white shadow rounded-lg p-6 mb-6">
        <h2 class="text-xl font-semibold mb-4">Add New User</h2>
        <.form for={@form} phx-submit="add_user" class="space-y-4">
          <div class="grid grid-cols-1 gap-4 sm:grid-cols-3">
            <div>
              <label class="block text-sm font-medium text-gray-700">Name</label>
              <input type="text" name="user[name]" required
                     class="mt-1 block w-full rounded-md border-gray-300 shadow-sm" />
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700">Age</label>
              <input type="number" name="user[age]" required
                     class="mt-1 block w-full rounded-md border-gray-300 shadow-sm" />
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700">Email</label>
              <input type="email" name="user[email]" required
                     class="mt-1 block w-full rounded-md border-gray-300 shadow-sm" />
            </div>
          </div>
          <div class="flex justify-end">
            <button type="submit"
                    class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
              Add User
            </button>
          </div>
        </.form>
      </div>

      <div class="bg-white shadow rounded-lg p-6">
        <h2 class="text-xl font-semibold mb-4">User List</h2>
        <div class="overflow-x-auto">
          <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
              <tr>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  User Info
                </th>
                <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Actions
                </th>
              </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
              <%= for {user, index} <- Enum.with_index(@users) do %>
                <tr>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                    <%= User.get_info(user) %>
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <button phx-click="delete_user" phx-value-index={index}
                            class="text-red-600 hover:text-red-900">
                      Delete
                    </button>
                  </td>
                </tr>
              <% end %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    """
  end
end
