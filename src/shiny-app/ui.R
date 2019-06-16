# define the user interface

ui <- dashboardPage(
  
  dashboardHeader(title = "ATP AgeRank Comparison"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem(text = "Player Explorer", tabName = "explorer", icon = icon("fas fa-search")),
      menuItem(text = "Player Comparator", tabName = "comparator", icon = icon("fas fa-grin-stars"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "explorer",
        box(title = "Informations", width = 6,
          numericInput("age_explorer", label = "Age:", step = 1, min = 0, max = 100, value = 18),
          sliderInput("top_rank_explorer", label = "Top Rank:", min = 1, max = 600, value = 25)
        ),
        dataTableOutput("dt_rank_age")
      ),
      tabItem(tabName = "comparator",
        box(title = "Player name", width = 6,
          selectizeInput("player_name_comparator", label = "", choices = unique(data_ranking$full_name), selected = "Roger Federer"),
          textOutput("age_player_name"),
          textOutput("rank_player_name"),
          br(),
          sliderInput("top_rank_comparator", label = "Actual Top Ranking:", min = 1, max = 600, value = 25)
        ),
        fluidRow(
          dataTableOutput("dt_actual_top")
        ),
        fluidRow(
          plotlyOutput('prog_plot', height = "900px")
        )
      )
    )
  )
  
)
