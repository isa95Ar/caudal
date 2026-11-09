defmodule Caudal.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CaudalWeb.Telemetry,
      Caudal.Repo,
      {DNSCluster, query: Application.get_env(:caudal, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Caudal.PubSub},
      # Start a worker by calling: Caudal.Worker.start_link(arg)
      # {Caudal.Worker, arg},
      # Start to serve requests, typically the last entry
      CaudalWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Caudal.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CaudalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
