return {

    config = {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },
    setup = function()
        require("ibl").setup()
    end

}
