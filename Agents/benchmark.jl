using Agents
using BenchmarkTools
using Test

a = @benchmark step!(model, agent_step!, model_step!, 500) setup = (
    (model, agent_step!, model_step!) = Models.predator_prey(
        n_wolves = 40,
        n_sheep = 60,
        dims = (25, 25),
        Δenergy_sheep = 5,
        Δenergy_wolf = 13,
        sheep_reproduce = 0.2,
        wolf_reproduce = 0.1,
        regrowth_time = 20,
    )
) samples = 100
println("Agents.jl WolfSheep (ms): ", minimum(a.times) * 1e-6)

a = @benchmark step!(model, agent_step!, model_step!, 100) setup = (
    (model, agent_step!, model_step!) = Models.flocking(
        n_birds = 300,
        separation = 1,
        cohere_factor = 0.03,
        separate_factor = 0.015,
        match_factor = 0.05,
    )
)
println("Agents.jl Flocking (ms): ", minimum(a.times) * 1e-6)

a = @benchmark step!(model, agent_step!, model_step!, 10) setup = (
    (model, agent_step!, model_step!) =
        Models.schelling(griddims = (50, 50), numagents = 2000)
) samples = 100
println("Agents.jl Schelling (ms): ", minimum(a.times) * 1e-6)

a = @benchmark step!(model, agent_step!, model_step!, 100) setup =
    ((model, agent_step!, model_step!) = Models.forest_fire())
println("Agents.jl ForestFire (ms): ", minimum(a.times) * 1e-6)

