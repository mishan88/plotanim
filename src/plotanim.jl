using Random
using Plots
gr()

# prepare data
rng = Xoshiro(42)
noise = randn(rng, 100)
x = [0.1:0.1:10.0;]
y_noise = 2 * x + noise

# ideal plot
plot(x, y_noise, seriestype=:scatter, leg=false, ylims=[-1.0, 21.0])
plot!(x, x * 2.0)
savefig("./plot/ideal_plot.png")


# plot mock animation
anim = Animation()
for weight = range(1, 2, length=20)
    plot(x, y_noise, seriestype=:scatter, leg=false, ylims=[-1.0, 21.0])
    plot!(x, x * weight)
    frame(anim)
end

gif(anim, "./plot/mock_update_animation.gif", fps=10)

anim = Animation()

# update weight
learning_rate = 0.05
let
    current_weight = 1.0
    for i = range(1, 100)
        plot(x, y_noise, seriestype=:scatter, leg=false, ylims=[-1.0, 21.0])
        plot!(x, x * current_weight)
        estimate_y = x[i] * current_weight
        plot!([x[i], x[i]], [y_noise[i], estimate_y], color=:black)
        diff = y_noise[i] - estimate_y
        current_weight += diff * learning_rate
        frame(anim)
    end
end

gif(anim, "./plot/update_weight_animation.gif", fps=5)
