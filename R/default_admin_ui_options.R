#' options for the Admin UI
#'
#' @return a list of html for branding the Admin UI
#'
#' @export
#'
default_admin_ui_options <- function() {
  list(


    title = shiny::titlePanel(
      htmltools::HTML(
        paste0(
          tags$a(
            href = "https://polished.tychobra.com",
            tags$img(
              src="polish/images/polished_hex.png",
              height = "50px",
              alt = "Polished Logo",
              style = "margin-top: -20px; float: left;"
            )
          ),
          tags$span("Polished", style='float: left; font-size: 37px !important; margin-top: -14px !important; margin-left: 10px; padding-top: 0 !important;')
        )
      ),
      windowTitle = "Polished"
    ),


    sidebar_branding = tags$a(
      href = "https://www.tychobra.com/",
      tags$img(
        style = "position: fixed; bottom: 0; left: 0; width: 230px;",
        src = "polish/images/tychobra_logo_blue_co_name.png"
      )
    ),

    browser_tab_icon = tags$link(rel = "shortcut icon", href = "polish/images/polished_hex.png")
  )
}