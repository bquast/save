#' RStudio Addin to Save Object from Environment to File
#' @name savewidget
#' @export
#' @import shiny miniUI
#' @examples
#' \dontrun{saveobjects()}

save.objects <- function() {

  # ui
  ui <- miniPage(
    miniTitleBar('Select Objects to Save', right=miniTitleBarButton('done', 'Save', primary = TRUE)),
    miniContentPanel(
      textInput('filename', label = 'Save as:', value = '.RData'),
      DT::dataTableOutput('tbl')
    )
  )

  # server
  server <- function(input, output, session) {

    objects <- data.frame(objects = ls(.GlobalEnv))

    output$tbl = DT::renderDataTable(
      objects, options = list(lengthChange = FALSE, paging=FALSE, autoWidth = TRUE, searching=FALSE)
    )

    observeEvent(input$done, {
      names <- as.character(objects[input$tbl_rows_selected, 1])
      # packages <- pkgs[input$tbl_rows_selected, 1]
      filename <- input$filename
      stopApp( save(list = names, file = filename)  )
    })

  }

  # run app
  runGadget(ui, server, viewer = dialogViewer("Save Objects"))
}
