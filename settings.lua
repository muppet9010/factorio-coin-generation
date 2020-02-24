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
            type = "double-setting",
            default_value = 20,
            minimum_value = 0,
            maximum_value = 100,
            setting_type = "startup",
            order = "1001"
        }
    }
)
