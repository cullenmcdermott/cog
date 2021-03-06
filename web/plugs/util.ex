defmodule Cog.Plug.Util do
  @moduledoc """
  Utility functions for storing and retrieving various custom pieces
  of data in a `Plug.Conn` struct.
  """

  import Plug.Conn, only: [assign: 3]

  alias Plug.Conn
  alias Cog.Models.User

  @doc """
  Store the current authenticated user in the `conn`.
  """
  @spec set_user(%Conn{}, %User{}) :: %Conn{}
  def set_user(%Conn{}=conn, %User{}=user),
    do: assign(conn, :user, user)

  @doc """
  Retrieve the authenticated user for the request (if any).
  """
  @spec get_user(%Conn{}) :: %User{} | nil
  def get_user(%Conn{}=conn),
    do: conn.assigns[:user]

  @doc """
  Records the current time in the `conn`
  """
  @spec stamp_start_time(%Conn{}) :: %Conn{}
  def stamp_start_time(%Conn{}=conn),
    do: assign(conn, :start_time, DateTime.utc_now())

  @doc """
  Retrieve the timestamp when processing of the request began.
  """
  @spec get_start_time(%Conn{}) :: DateTime.t | nil
  def get_start_time(%Conn{}=conn),
    do: conn.assigns[:start_time]

  @doc """
  Records a new unique identifier in the `conn`.
  """
  @spec stamp_request_id(%Conn{}) :: %Conn{}
  def stamp_request_id(%Conn{}=conn),
    do: assign(conn, :request_id, Cog.Events.Util.unique_id)

  @doc """
  Retrieve the stored request identifier from the `conn`
  """
  @spec get_request_id(%Conn{}) :: binary() | nil
  def get_request_id(%Conn{}=conn),
    do: conn.assigns[:request_id]

  @doc """
  Store the service token for the current request.
  """
  @spec set_service_token(%Conn{}, String.t) :: %Conn{}
  def set_service_token(%Conn{}=conn, token) when is_binary(token),
    do: assign(conn, :service_token, token)

  @doc """
  Retrieve the service token for the current request.
  """
  @spec get_service_token(%Conn{}) :: binary() | nil
  def get_service_token(%Conn{}=conn),
    do: conn.assigns[:service_token]

end
