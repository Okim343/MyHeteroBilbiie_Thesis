# Master Thesis: Technology Choice and Firm Composition in an RBC Model with Endogenous Entry

This repository accompanies my master thesis, titled *Technology Choice and Firm Heterogeneity in an RBC
Model with Endogenous Entry* and supervised by Prof. Dr. Christian Bayer and Dr. Zheng Gong. This thesis was presented to the Department of Economics at the Rheinische Friedrich-Wilhelms-Universität Bonn in partial fulfillment of the requirements for the degree of Master of Science (M.Sc.) in Economics. In particular, you can find in this repository the thesis itself and the codes to generate the results as well as the figures found therein.

## Set-up

This thesis uses Dynare.jl, a julia package implementing the most common dynare commands into the Julia language. I use Julia version 1.94 for best compatibility with Dynare.jl, given that the package is still under development. Therefore, I recommend installing Julia 1.9.4 using the `juliaup` version manager.

Once the correct version is installed, you need to activate the project and install all the dependencies (You can find out which version you are using by calling `versioninfo()` in the Julia REPL). To do that,  set this folder as your working directory `cd`. Then, start your Julia REPL and type `]` so that you can call:

```console
(v1.9.4) pkg> activate .
(MyHeteroBilbiie) pkg > instantiate
```

This will install all needed packages for the files to run.

## Folder structure

All relevant source code can be found inside `src/`, which itself contains four files and two other subfolders. The files are:

- `analyze_steadystate.jl`: Solves and visualizes the steady state of the heterogeneous firm RBC model under elastic and inelastic labor assumptions. It prints out the steady-state values for each relevant variable.

- `parameter&types.jl` – Defines model parameters, shocks, and the `MyHeteroBilbiieModel` struct used to instantiate the RBC model.

- `run_model.jl` – Calls and runs the Dynare RBC model with elastic labor, computes impulse response functions (IRFs) for aggregate shocks, and exports sectoral and aggregate plots.

- `run_model_ineL.jl` – Calls and runs the Dynare RBC model with inelastic labor, computes impulse response functions (IRFs) for aggregate shocks, and exports sectoral and aggregate plots.

To replicate the results presented in the paper, one has to run `analyze_steadystate.jl` to get the steady-state values for the inelastic and elastic labor specifications, and copy paste them into the Dynare files directly, given how Dynare.jl currently does not integrate with Julia routines. Then, by running `run_model.jl` and `run_model_ineL.jl`, one can generate the IRFs seem in the paper for both the elastic and inelastic labor cases. These figures will be saved in a newly created local folder `Images/` which divides the images depending on the model specification (elastic or inelastic) and the shock (XShock or ZShock), and also includes the steady state visualizations.

To replicate the business cycle moments, one has to run the third and final steady state calculation in `analyze_steadystate.jl` to get the steady-state values, and then simply run the `main_bcycle.mod` directly
using MATLAB terminal either in VSCode with the MATLAB extension, or directly on MATLAB. This should print all the necessary business cycle moments directly in the output, with the relative standard deviation
w.r.t output $Y_R$ being retrieved by dividing the standard deviations of the other variables by the standard deviation of real output.

The three other subfolders are:

- `helper_functions/`, which contains the helper functions used to calculate the steady_state values (`steady_state.jl`), plot the steady state figures (`steady_state_figures.jl`), and finally, plot the IRFS (`plot_irfs.jl`).

- `DynareModFiles/`, which contains the Dynare mod files specifing the calibration parameters (`calibration.mod` and `calibration_ineL.mod`), declaring the variables (`declarations.mod`), setting up the relevant equations (`equations.mod` and `equations_ineL.mod`) and finally running the model itself (`model.mod` and `model_ineL.mod`).

- `Thesis/`, which contains the TeX code of the thesis, its `.bib` file and its PDF version.