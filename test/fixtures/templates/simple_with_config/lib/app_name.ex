defmodule <%= module %> do
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(<%= module %>.Router, [])
    ]

    opts = [strategy: :one_for_one, name: <%= module %>.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
