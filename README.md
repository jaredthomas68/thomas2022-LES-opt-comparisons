# Description

This repository contains data and scripts for the paper "[Gradient-Based Wind Farm Layout Optimization Results Compared with Large-Eddy Simulations](	
https://doi.org/10.5194/wes-2022-4)" by Jared J. Thomas, Christopher J. Bay, Andrew P. J. Stanley, Regis Thedin, and Andrew Ning

We undertook this work to determine if and how optimization algorithms may be exploiting inaccuracies in the simple models used for wind farm layout optimization. Comparing optimization results from a simple model to large-eddy simulations showed that even a simple model provides enough information for optimizers to find good layouts. However, varrying the number of wind directions in the optimization showed that the wind resource discretization can nagatively impact the optimization results.

All the code in this repository is in [Julia](https://julialang.org) and is compatible with Julia Version 1.8.0

# Setting up your environment

# Generating Images

Navigate to the image generation directory

`$ cd image-generation`

Start a Julia REPL

`$ julia`

Include the image generation script and run the `make_images()` function.

```julia
include("image_generator")

make_images()
```