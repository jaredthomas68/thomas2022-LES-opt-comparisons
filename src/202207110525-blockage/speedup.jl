using PyPlot; const plt=PyPlot

function speedestimate(v1, b)
    # based on conservation of mass
    v2 = v1/(1-b)
    return v2
end

function _powerratio(v1, v2)
    # based on power being proportional to the cube of the velocity, all other inputs the same
    pratio = (v2^3)/(v1^3)
    return pratio - 1
end

function powerratio(v1, b)
    # b *= 0.15 # adjust for solidity
    # inflow speed
    v2 = speedestimate(v1, b)
    pratio = _powerratio(v1, v2)
    return pratio
end

function plot_pratio()
    # initialize figure
    fig, ax = plt.subplots(1)

    # set input velocity
    v1 = 8.0 # m/s

    # set range for blockage
    b = (0:0.001:0.17)

    # get powerup values
    pr = powerratio.(v1, b)

    # pr = speedestimate.(v1, b)

    # plot
    ax.plot(b,pr,"-k")

    # at b = 0.08
    b = 0.08 
    pr = powerratio(v1, b)
    ax.annotate("b = $b, pr = $(round(pr, digits=3))", [b-0.035,pr])
    ax.scatter(b, pr)
    ax.set(aspect="equal")

    # at b = 0.01
    b = 0.01
    pr = powerratio(v1, b)
    ax.annotate("b = $b, pr = $(round(pr, digits=3))", [b+0.01,pr])
    ax.scatter(b, pr)

    # at b = 0.02
    b = 0.02
    pr = powerratio(v1, b)
    ax.annotate("b = $b, pr = $(round(pr, digits=3))", [b+0.01,pr])
    ax.scatter(b, pr)

    # show plot
    plt.show()

end

function save_pratio()

    datalocation = "../../image-generation/image-data/blockage/"

    # load high-ti data
    high_ti_base_file = "base_case_blockage_high-ti_base_res0.5.csv"
    high_ti_base_data = DataFrame(CSV.File(datalocation*high_ti_base_file))
    high_ti_opt_file = "base_case_blockage_high-ti_opt_res0.5.csv"
    high_ti_opt_data = DataFrame(CSV.File(datalocation*high_ti_opt_file))
    
    # load low-ti data 
    low_ti_base_file = "base_case_blockage_low-ti_base_res0.5.csv"
    low_ti_base_data = DataFrame(CSV.File(datalocation*low_ti_base_file))
    low_ti_opt_file = "base_case_blockage_low-ti_opt_res0.5.csv"
    low_ti_opt_data = DataFrame(CSV.File(datalocation*low_ti_opt_file))
   
    # set input velocity
    v1 = 8.0 # m/s

    # get powerup values
    high_ti_base_data[!, :power_ratio] = powerratio.(v1, high_ti_base_data.blockage)
    high_ti_opt_data[!, :power_ratio] = powerratio.(v1, high_ti_opt_data.blockage)
    low_ti_base_data[!, :power_ratio] = powerratio.(v1, low_ti_base_data.blockage)
    low_ti_opt_data[!, :power_ratio] = powerratio.(v1, low_ti_opt_data.blockage)

    CSV.write(high_ti_base_file, high_ti_base_data)
    CSV.write(high_ti_opt_file, high_ti_opt_data)
    CSV.write(low_ti_base_file, low_ti_base_data)
    CSV.write(low_ti_opt_file, low_ti_opt_data)


end
