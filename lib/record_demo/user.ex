defmodule RecordDemo.User do
  require Record

  # Define a record for user data
  Record.defrecord(:user, name: "", age: 0, email: "")

  # Helper function to create a new user
  def new_user(name, age, email) do
    user(name: name, age: age, email: email)
  end

  def get_info(user_record) do
    "Name: #{user(user_record, :name)}, Age: #{user(user_record, :age)}, Email: #{user(user_record, :email)}"
  end
end
