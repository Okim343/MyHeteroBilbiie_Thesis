using Plots, LaTeXStrings
pgfplotsx()

"""
2D bubble‐scatter of steady‐state firm properties with dynamic axes and legend title.

# Arguments
- `ss`: a NamedTuple or struct with fields
    - `ss.y`::AbstractVector    (firm‐level output yᵢ)
    - `ss.l`::AbstractVector    (firm‐level employment lᵢ)
    - `ss.M`::AbstractVector    (number of firms Mᵢ)

# Keyword Arguments
- `size_scale::Real=30`      maximum marker size
- `min_marker::Real=5`       minimum marker size
- `palette_name::Symbol=:tab10`  color palette name from Plots
- `alpha::Real=0.8`          marker transparency
- `buffer_frac::Real=0.05`   fraction of range to pad the axes
"""
function steady_state_scatter(ss;
      size_scale::Real   = 30,
      min_marker::Real   = 5,
      palette_name::Symbol = :tab10,
      alpha::Real        = 0.8,
      buffer_frac::Real  = 0.2
    )

    # unpack
    y = ss.y_i
    l = ss.l_i
    M = ss.M_i

    N = length(M)
    @assert length(y)==N && length(l)==N "ss.y, ss.l, ss.M must have same length"

    # normalize M → [0,1], then scale to [min_marker, size_scale]
    Mnorm = (M .- minimum(M)) ./ (maximum(M) - minimum(M) + eps())
    markers = Mnorm .* (size_scale - min_marker) .+ min_marker

    # pick N distinct colors
    cols = palette(palette_name, N)

    # dynamic axis limits
    x_min, x_max = minimum(y), maximum(y)
    y_min, y_max = minimum(l), maximum(l)

    # if degenerate, give a bit of absolute padding
    dx = (x_max > x_min) ? (x_max - x_min)*buffer_frac : max(abs(x_min)*buffer_frac, 1.0)
    dy = (y_max > y_min) ? (y_max - y_min)*buffer_frac : max(abs(y_min)*buffer_frac, 1.0)

    xlims = (x_min - dx, x_max + dx)
    ylims = (y_min - dy, y_max + dy)

    # base plot
    plt = plot(
      xlabel      = "yᵢ (output)",
      ylabel      = "lᵢ (employment)",
      title       = "Steady‐State Firm Properties",
      legend      = :outerright,
      legendtitle = "# firms Mᵢ:",
      xlim        = xlims,
      ylim        = ylims,
    )

    # add each sector as its own series (for distinct legend entries)
    for i in 1:N
      scatter!(
        plt,
        [y[i]], [l[i]];
        markersize        = markers[i],
        markerstrokewidth = 0.5,
        markerstrokecolor = :black,
        alpha             = alpha,
        color             = cols[i],
        label             = "sector $i",
      )
    end

    return plt
end

