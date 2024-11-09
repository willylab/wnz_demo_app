defmodule WnzDemoApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WnzDemoAppWeb.Telemetry,
      WnzDemoApp.Repo,
      {DNSCluster, query: Application.get_env(:wnz_demo_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: WnzDemoApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: WnzDemoApp.Finch},
      # Start a worker by calling: WnzDemoApp.Worker.start_link(arg)
      # {WnzDemoApp.Worker, arg},
      # Start to serve requests, typically the last entry
      WnzDemoAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WnzDemoApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WnzDemoAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
