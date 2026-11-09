defmodule Caudal.Repo do
  use Ecto.Repo,
    otp_app: :caudal,
    adapter: Ecto.Adapters.Postgres
end
