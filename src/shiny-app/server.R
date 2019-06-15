
server <- function(input, output, session) {
  
  
  input_list <- reactive(
    list(
      age_explorer = input$age_explorer,
      top_rank_explorer = input$top_rank_explorer,
      player_name_comparator = input$player_name_comparator,
      top_rank_comparator = input$top_rank_comparator
    )
  )
  
  output$age_player_name <- reactive(
    paste("Age of selected player:", data_test[players == input_list()$player_name_comparator,]$age)
  )
  
  output$dt_rank_age <- renderDataTable({
    datatable(data_test, colnames = c("Player Name", "Age", "Rank"), rownames = FALSE)
  })
  
  output$dt_actual_top <- renderDataTable({
    datatable(data_test, colnames = c("Player Name", "Current Rank", "Comparable Rank"), rownames = FALSE)
  })
  
  
}
