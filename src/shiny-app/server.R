
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
    paste("Age of selected player:", round(data_ranking[full_name == input_list()$player_name_comparator,][order(-ranking_date),][1,]$age, 1))
  )
  
  output$rank_player_name <- reactive(
    paste("Rank of selected player:", round(data_ranking[full_name == input_list()$player_name_comparator,][order(-ranking_date),][1,]$rank, 1))
  )
  
  data_ranking_rank_age <- reactive(
    data_ranking[top_rank <= input_list()$top_rank_explorer & age <= input_list()$age_explorer,][, .SD[which.min(top_rank)], by = player] 
  )
  
  data_actual_ranking <- reactive({
    player_age <- data_ranking[full_name == input_list()$player_name_comparator,][order(-ranking_date),][1,]$age
    actual_top <- data_ranking[ranking_date == max(data_ranking$ranking_date),][order(rank),][1:input_list()$top_rank_comparator, (c("full_name", "age", "rank")), with = FALSE]
    past_top <- data_ranking[full_name %in% actual_top$full_name & age <= player_age,][, .SD[which.max(age)], by = player][, (c("full_name", "age", "rank")), with = FALSE]
    setnames(past_top, c("age", "rank"), c("past_age", "past_rank"))
    dt_top <- merge(actual_top, past_top, on = "full_name", all.x = TRUE)[order(rank),]
  })
  
  output$dt_rank_age <- renderDataTable({
    datatable(data_ranking_rank_age()[, (c("full_name", "ranking_date", "age", "top_rank")), with = F], colnames = c("Player Name", "Ranking Date", "Age", "Rank"), rownames = FALSE)
  })
  
  output$dt_actual_top <- renderDataTable({
    datatable(data_actual_ranking()[, (c("full_name", "rank", "age", "past_rank", "past_age")), with = F], colnames = c("Player Name", "Current Rank", "Current Age", "Past Rank", "Past Age"), rownames = FALSE)
  })
  
  dt_prog_plot <- reactive({
    players_selected <- data_actual_ranking()[input$dt_actual_top_rows_selected,]$full_name
    players_to_plot <- c(input_list()$player_name_comparator, players_selected)
    data_player_prog <- data_ranking[full_name %in% players_to_plot,]
    data_player_prog[, ]
  })
  
  output$prog_plot <- renderPlotly({
    
    plot <- ggplot(dt_prog_plot(), aes(x = age, y = rank, color = full_name)) +
              geom_line() +
              scale_x_continuous("Age") +
              scale_y_reverse("Rank") +
              scale_color_discrete("Full Name") +
              theme_classic() +
              theme(legend.position = "bottom")
    
    ggplotly(plot)
  })
  
}
