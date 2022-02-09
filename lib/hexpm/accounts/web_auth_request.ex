defmodule Hexpm.Accounts.WebAuthRequest do
  use Hexpm.Schema

  @moduledoc false

  # See `lib/hexpm/accounts/web_auth.ex` for an explanation of the terminology used.

  schema "web_auth_requests" do
    field :device_code, :string
    field :user_code, :string
    field :key_name, :string
    field :verified, :boolean, default: false
    belongs_to :user, Hexpm.Accounts.User
  end

  def create(request, params \\ %{}) do
    request
    |> cast(params, [:device_code, :user_code, :key_name])
    |> validate_required([:device_code, :user_code, :key_name, :verified])
    |> unique_constraint([:device_code, :user_code])
  end

  def verify(request, user) do
    request
    |> change()
    |> put_change(:verified, true)
    |> put_assoc(:user, user)
  end
end
