##############################################################################
#  src/helper_functions/plot_irfs.jl – plotter for desired IRFs              #
#  for the heterogeneous Bilbiie-Sedlacek model (3 + 7 I)                    #
##############################################################################

using Plots, LaTeXStrings
pgfplotsx()

"""
Plot impulse response functions (IRFs) from a Dynare `ModelResults` object.

# Arguments
- `mr::ModelResults`: the model results (e.g., `ctx.results.model_results[1]`).
- `shock::Symbol`: the shock to plot (e.g., `:eps_Z` or `:eps_X`).
- `vars::Vector{Symbol}`: list of variable names to plot.

# Keyword Arguments
- `horizon::Int=50`: number of periods to plot.
- `ncols::Int=2`: number of columns in the subplot grid.
- `lw::Float64=1.5`: line width for each IRF.

# Returns
- A `Plots.Plot` object with LaTeX‐ready titles and no extra empty panels.
"""
function plot_irfs(
    mr::ModelResults,
    shock::Symbol,
    vars::Vector{Symbol};
    horizon::Int    = 50,
    ncols::Int      = 2,
    lw::Float64     = 1.5
)
    # grab the AxisArrayTable for this shock
    irf_table = mr.irfs[shock]

    # extract & trim the time‐axis
    full_t = collect(axes(irf_table, 1))
    times  = filter(t -> t ≤ horizon, full_t)

    # layout
    nvars   = length(vars)
    nrows   = ceil(Int, nvars / ncols)
    npanels = nrows * ncols

    p = plot(
      layout    = (nrows, ncols),
      legend    = false,
      linewidth = lw,
      size      = (400*ncols, 300*nrows),
      grid      = false,    # turn off all grids
      color     = :red      # default series color
    )

    for (i,var) in enumerate(vars)
        # pull out the IRF as a plain Vector{Float64}
        y = [ irf_table[t, var] for t in times ]

        # if the series is constant, pad the y‐limits by 10%
        ymin, ymax = extrema(y)
        if ymin == ymax
            pad = (abs(ymin) < 1e-8 ? 1.0 : abs(ymin)*0.1)
            ymin -= pad
            ymax += pad
        end

        plot!(
          p[i],
          times, y;
          title   = string(var),
          xlabel  = "Horizon",
          ylabel  = "",
          xlim    = (first(times), last(times)),
          ylim    = (ymin, ymax),
          grid    = false,   # ensure no grid on this subplot
          color   = :red     # force red line
        )
    end

    # blank out any unused panels
    for j in (nvars+1):npanels
        plot!(
          p[j],
          [],                          # empty series
          framestyle = :none,
          xticks     = false,
          yticks     = false,
          grid       = false
        )
    end

    return p
end


"""
Overlay multiple IRFs from a single shock in one plot.

# Arguments
- `mr::ModelResults`: the model results (e.g. `ctx.results.model_results[1]`).
- `shock::Symbol`: which shock to plot (e.g. `:eps_Z` or `:eps_X`).
- `vars::Vector{Symbol}`: list of variables (e.g. `[:v1, :v2, :v3]`).

# Keyword Arguments
- `horizon::Int=50`: how many periods to plot.
- `lw::Float64=1.5`: line width for each IRF.
- `ncols::Int=2`: number of columns in the legend.

# Returns
- A `Plots.Plot` object with all IRFs overlaid.
"""
function plot_irfs_stacked(
    mr::ModelResults,
    shock::Symbol,
    vars::Vector{Symbol};
    horizon::Int = 50,
    lw::Float64 = 1.5,
    ncols::Int = 2
)
    # Determine plot title from variable names (strip trailing digits)
    first_var_str = string(vars[1])
    title_str = replace(first_var_str, r"\d+$" => "")

    # pull the IRF table and time‐axis
    irf_table = mr.irfs[shock]
    full_t     = collect(axes(irf_table, 1))
    times      = filter(t -> t ≤ horizon, full_t)

    # find global y‐limits across all series
    ymin = Inf
    ymax = -Inf
    for var in vars
        y = [irf_table[t, var] for t in times]
        ymin = min(ymin, minimum(y))
        ymax = max(ymax, maximum(y))
    end
    if ymin == ymax
        pad = (abs(ymin) < 1e-8 ? 1.0 : abs(ymin)*0.1)
        ymin -= pad
        ymax += pad
    end

    # simple color palette
    palette = (
      :red, :green, :blue, :orange, :purple,
      :cyan, :brown, :magenta, :gray
    )

    # build the base plot (no grid), with dynamic title
    p = plot(
      title      = title_str,
      xlabel     = "Horizon",
      ylabel     = "",
      xlim       = (first(times), last(times)),
      ylim       = (ymin, ymax),
      legend     = :topright,
      legendcols = ncols,
      linewidth  = lw,
      size       = (600, 400),
      grid       = false
    )

    # draw y=0 dashed line in background
    hline!(
      p,
      [0];
      linestyle = :dash,
      color     = :black,
      label     = false
    )

    # overlay each IRF
    for (i, var) in enumerate(vars)
        y = [irf_table[t, var] for t in times]

        # get the trailing digit for the legend label
        vstr = string(var)
        m    = match(r"\d+$", vstr)
        lbl  = m !== nothing ? "sector $(m.match)" : string(var)

        # pick a color (fallback if >9)
        col = i ≤ length(palette) ? palette[i] : nothing

        plot!(
          p,
          times,
          y;
          label = lbl,
          color = col
        )
    end

    return p
end

