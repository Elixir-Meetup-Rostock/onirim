import Config

config :onirim,
  cards: [:dream, :door, :location],
  phases: [:setup, :play_or_discard, :refill_hand, :shuffle_limbo],
  status: [:victory, :defeat, :active],
  symbols: [:key, :moon, :sun],
  personal_ressources_limit: 5,
  default_draw_pile: [
    {:dream, :nightmare, 10},
    {:door, :aquarium, 2},
    {:door, :garden, 2},
    {:door, :library, 2},
    {:door, :observatory, 2},
    {:location, :aquarium, :key, 3},
    {:location, :aquarium, :moon, 4},
    {:location, :aquarium, :sun, 8},
    {:location, :garden, :key, 3},
    {:location, :garden, :moon, 4},
    {:location, :garden, :sun, 7},
    {:location, :library, :key, 3},
    {:location, :library, :moon, 4},
    {:location, :library, :sun, 6},
    {:location, :observatory, :key, 3},
    {:location, :observatory, :moon, 4},
    {:location, :observatory, :sun, 9}
  ]
