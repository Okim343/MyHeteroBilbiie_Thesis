using Plots, LaTeXStrings
pgfplotsx()


"""
2D bubble‐scatter of steady‐state firm properties with dynamic axes,  
45° reference line, and α‐annotations.

# Arguments
- `ss`: a NamedTuple or struct with fields
    - `ss.y_i`::AbstractVector    (firm‐level output yᵢ)
    - `ss.l_i`::AbstractVector    (firm‐level employment lᵢ)
    - `ss.M_i`::AbstractVector    (number of firms Mᵢ)
    - `ss.α_i`::AbstractVector    (technology parameter αᵢ)

# Keyword Arguments
- `size_scale::Real=30`      maximum marker size
- `min_marker::Real=5`       minimum marker size
- `palette_name::Symbol=:tab10`  color palette name from Plots
- `alpha::Real=0.8`          marker transparency
- `buffer_frac::Real=0.2`    fraction of range to pad the axes
- `log_x::Bool=false`        log‐scale x?
- `log_y::Bool=false`        log‐scale y?
"""
function steady_state_scatter(ss;
      size_scale::Real     = 6,
      min_marker::Real     = 5,
      palette_name::Symbol = :tab10,
      alpha::Real          = 0.8,
      buffer_frac::Real    = 0.2,
      log_x::Bool          = false,
      log_y::Bool          = false
    )

    # unpack
    y  = ss.y_i
    l  = ss.l_i
    M  = ss.M_i
    αs = ss.α_i

    N = length(M)
    @assert length(y)==N && length(l)==N && length(αs)==N "ss.y_i, ss.l_i, ss.M_i, ss.α_i must all match length"

    # optional log-transform
    xdata = log_x ? log.(y) : y
    ydata = log_y ? log.(l) : l

    # normalize M → [min_marker, size_scale]
    Mnorm   = (M .- minimum(M)) ./ (maximum(M) - minimum(M) + eps())
    markers = Mnorm .* (size_scale - min_marker) .+ min_marker

    # pick colors
    cols = palette(palette_name, N)

    # dynamic axis limits
    x_min, x_max = minimum(xdata), maximum(xdata)
    y_min, y_max = minimum(ydata), maximum(ydata)
    dx = (x_max > x_min) ? (x_max - x_min)*buffer_frac : max(abs(x_min)*buffer_frac, 1.0)
    dy = (y_max > y_min) ? (y_max - y_min)*buffer_frac : max(abs(y_min)*buffer_frac, 1.0)
    xlims = (x_min - dx, x_max + dx)
    ylims = (y_min - dy, y_max + dy)

    # axis labels
    xlabel = log_x ? "log yᵢ (output)"     : "yᵢ (output)"
    ylabel = log_y ? "log lᵢ (employment)" : "lᵢ (employment)"
    title  = ""

    # build plot
    plt = plot(
      xlabel      = xlabel,
      ylabel      = ylabel,
      title       = title,
      legend      = :outerright,
      legendtitle = "# firms Mᵢ:",
      xlim        = xlims,
      ylim        = ylims,
    )

    # plot each bubble, embedding α‐value in its legend label
    for i in 1:N
      scatter!(
        plt,
        [xdata[i]], [ydata[i]];
        markersize        = markers[i],
        markerstrokewidth = 0.5,
        markerstrokecolor = :black,
        alpha             = alpha,
        color             = cols[i],
        # use a LaTeXString so α renders nicely
        label = LaTeXString("sector $(i)\\,(\\alpha=$(round(αs[i], digits=3)))"),
      )
    end

    return plt
end
# ────────────────────────────────────────────────────────────────────────

"""
Plot steady‐state entry: potential entrants eᵢ vs. successful entrants mᵢ = eᵢ·Πᵢ,

- Legend: “sector i (Πᵢ=…)”
- On‐plot annotation: “αᵢ=…” next to each bubble

# Arguments
- `ss`: a named‐tuple with fields
    • `ss.e_i`  :: AbstractVector  (potential entrants)
    • `ss.Π_i`  :: AbstractVector  (success probabilities)
    • `ss.α_i`  :: AbstractVector  (technology parameters)

# Keyword Arguments
- `size_scale::Real=8`
- `palette_name::Symbol=:tab10`
- `alpha::Real=0.8`
- `buffer_frac::Real=0.2`
- `log_x::Bool=false`
- `log_y::Bool=false`
"""
function steady_state_entry(ss;
      size_scale::Real     = 4,
      palette_name::Symbol = :tab10,
      alpha::Real          = 0.8,
      buffer_frac::Real    = 0.2,
      log_x::Bool          = false,
      log_y::Bool          = false
    )

    # unpack
    eₖ  = ss.e_i
    Πₖ  = ss.Π_i
    αₖ  = ss.α_i

    N = length(eₖ)
    @assert length(Πₖ)==N && length(αₖ)==N "ss.e_i, ss.Π_i and ss.α_i must all match length"

    # compute successful entrants
    mₖ = eₖ .* Πₖ

    # optional log‐transform
    xdata = log_x ? log.(eₖ) : eₖ
    ydata = log_y ? log.(mₖ) : mₖ

    # pick N distinct colors
    cols = palette(palette_name, N)

    # dynamic axis limits
    x_min, x_max = minimum(xdata), maximum(xdata)
    y_min, y_max = minimum(ydata), maximum(ydata)
    dx = (x_max > x_min ? (x_max-x_min)*buffer_frac : abs(x_min)*buffer_frac)
    dy = (y_max > y_min ? (y_max-y_min)*buffer_frac : abs(y_min)*buffer_frac)
    xlims = (x_min-dx, x_max+dx)
    ylims = (y_min-dy, y_max+dy)

    # labels
    xlabel = log_x ? "log eᵢ (potential entrants)"  : "eᵢ (potential entrants)"
    ylabel = log_y ? "log mᵢ (successful entrants)" : "mᵢ (successful entrants)"
    title  = ""

    plt = plot(
      xlabel      = xlabel,
      ylabel      = ylabel,
      title       = title,
      legend      = :outerright,
      legendtitle = "sector (Πᵢ)",
      xlim        = xlims,
      ylim        = ylims,
    )

    for i in 1:N
      # draw the bubble, with Pi_i in legend
      scatter!(
        plt,
        [xdata[i]], [ydata[i]];
        markersize        = size_scale,
        markerstrokewidth = 0.5,
        markerstrokecolor = :black,
        alpha             = alpha,
        color             = cols[i],
        label             = "sector $i (Πᵢ=$(round(Πₖ[i], digits=3)))",
      )

      # annotate alpha_i *on top* of the bubble
      annotate!(
        plt,
        xdata[i], ydata[i],
        text(
          "αᵢ=$(round(αₖ[i], digits=3))",
          :right,  # push it just to the right of the point
          8        # font size
        )
      )
    end

    return plt
end