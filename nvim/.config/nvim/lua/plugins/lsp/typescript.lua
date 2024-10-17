return {
    "qwexvf/typescript-tools.nvim",
    dependencies = {
        "kyoh86/climbdir.nvim",
    },
    lazy = false,
    config = function()
        require("typescript-tools").setup {
            settings = {
                tsserver_node_executable = "bun",
            },
            root_dir = function(path)
                local marker = require("climbdir.marker")
                return require("climbdir").climb(path,
                    marker.one_of(marker.has_readable_file("package.json"), marker.has_directory("node_modules")), {
                        halt = marker.one_of(
                            marker.has_readable_file("deno.json"),
                            marker.has_readable_file("deno.jsonc"),
                            marker.has_readable_file("import_maps.json"),
                            marker.has_directory("denops")
                        ),
                    })
            end,
            single_file_support = false,
        }
    end,
}
