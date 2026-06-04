if (!requireNamespace("yaml", quietly = TRUE)) {
    install.packages("yaml")
}
if (!requireNamespace("jsonlite", quietly = TRUE)) {
    install.packages("jsonlite")
}
if (!requireNamespace("httr2", quietly = TRUE)) {
    install.packages("httr2")
}


if (!dir.exists("badges")) dir.create("badges")

badges_spec <- yaml::read_yaml("badges-specs.yml", readLines.warn = FALSE)

create_badge <- function(
    right_color,
    left_color,
    left_text,
    right_text,
    logo,
    logo_type
) {

    sel_logo <- jsonlite::read_json("base-64-logos.json") |>
        (\(x) x[[logo]][[1]][[logo_type]])()

    if (is.null(sel_logo)) {
        message(paste("Logo", logo, logo_type, "not found. Ignoring it."))
        logo_part <- ""
    } else {
        logo_part <- paste0(
            "&logo=", sel_logo
        )
    }

    b_url <- paste0(
        "https://img.shields.io/badge/",
        utils::URLencode(left_text, reserved = TRUE),
        "-",
        utils::URLencode(right_text, reserved = TRUE),
        "-",
        right_color,
        ".svg?",
        "labelColor=",
        left_color,
        logo_part
    )

    out_path <- file.path(
        "badges", tolower(paste0(
            left_text, "-", gsub("-| |\t", "_", right_text), ".svg"
        ))
    )

    httr2::request(b_url) |>
        httr2::req_perform(path = out_path)

    return(invisible(NULL))
}

for (li in seq_along(badges_spec)) {
    bspec <- badges_spec[[li]]

    types <- names(bspec$types)

    for (ty in types) {
        sel_type <- bspec$types[[ty]] |> unlist()

        right_color <- sel_type["right-color"]
        left_color <- sel_type["left-color"]
        left_text <- sel_type["left-text"]
        logo <- sel_type["logo"]
        logo_type <- sel_type["logo-type"]
        if (sum(grepl("right-text", names(sel_type))) > 1) {
            right_text <- sel_type[grepl("right-text", names(sel_type))]
        } else {
            right_text <- sel_type["right-text"]
        }

        for (rt in seq_along(right_text)) {
            create_badge(
                right_color,
                left_color,
                left_text,
                right_text = right_text[rt],
                logo,
                logo_type
            )
        }
    }
}