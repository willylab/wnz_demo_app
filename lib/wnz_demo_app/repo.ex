defmodule WnzDemoApp.Repo do
  use Ecto.Repo,
    otp_app: :wnz_demo_app,
    adapter: Ecto.Adapters.Postgres
end
