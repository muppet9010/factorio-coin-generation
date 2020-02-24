data:extend(
    {
        {
            name = "coin_generation-private_research_institute_type",
            type = "string-setting",
            default_value = "none",
            allowed_values = {"none", "per_science", "grouped_science"},
            setting_type = "startup",
            order = "1001"
        },
        {
            name = "coin_generation-private_research_institute_value_decrease_percent",
            type = "int-setting",
            default_value = 20,
            min_value = -1,
            max_value = 100,
            setting_type = "startup",
            order = "1001"
        }
    }
)
