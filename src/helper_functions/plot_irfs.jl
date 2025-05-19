##############################################################################
#  src/helper_functions/plot_irfs.jl – plotter for desired IRFs              #
#  for the heterogeneous Bilbiie-Sedlacek model (3 + 7 I)                    #
##############################################################################

using Plots, LaTeXStrings

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
      size      = (400*ncols, 300*nrows)
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
          title = string(var),
          xlabel = "Horizon",
          ylabel = "",
          xlim   = (first(times), last(times)),
          ylim   = (ymin, ymax)
          # no explicit ticks – let GR choose
        )
    end

    # blank out any unused panels
    for j in (nvars+1):npanels
        plot!(
          p[j],
          [],                          # empty series
          framestyle = :none,
          xticks     = false,
          yticks     = false
        )
    end

    return p
end
