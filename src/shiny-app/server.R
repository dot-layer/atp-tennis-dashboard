
server <- function(input, output, session) {
  
  
  input_list_page1 <- reactive(
    list(
      age = input$age,
      top_rank = input$top_rank 
    )
  )
  
  output$dt_rank_age <- renderDataTable({
    datatable(data_test, colnames = c("Player Name", "Age", "Rank"))
  })
  
  
}
