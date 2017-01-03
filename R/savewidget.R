#' RStudio Addin to Save Object from Environment to File
#' @name savewidget
#' @export
#' @import shiny miniUI DT

saveobjects <- function() {

  # ui
  ui <- miniPage(
    miniTitleBar('Select Objects to Save', right=miniTitleBarButton('done', 'Save', primary = TRUE)),
    miniContentPanel(
      DT::dataTableOutput('tbl')
    )
  )

  # server
  server <- function(input, output, session) {

    objects <- data.frame(objects = ls(.GlobalEnv))

    output$tbl = DT::renderDataTable(
      objects, options = list(lengthChange = FALSE, paging=FALSE, autoWidth = TRUE)
    )

    observeEvent(input$done, {
      names <- as.character(objects[input$tbl_rows_selected, 1])
      # packages <- pkgs[input$tbl_rows_selected, 1]
      filename <- 'bla.RData'
      stopApp( save(list = names, file = filename)  )
    })

  }

  # run app
  runGadget(ui, server, viewer = dialogViewer("Save Objects"))
}
