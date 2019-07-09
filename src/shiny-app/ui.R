# define the user interface

ui <- dashboardPage(skin = "black",
  
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
        box(title = "Context", width = 6, height = 250,
          "This App is meant to allow you to search the list of ATP players by age and rank.", 
          br(), 
          br(),
          HTML("The <b>Explorer Page</b> allows you to find the players who have reached a certain top ranking before a given age."),
          br(),
          br(),
          HTML("This App is for non-commcercial usage. It uses data from <a href='https://github.com/JeffSackmann/tennis_atp'>Jeff Sackmann GitHub repository</a>.")
        ),
        box(title = "Informations", width = 6, height = 250,
          numericInput("age_explorer", label = "Age:", step = 1, min = 0, max = 100, value = 18),
          sliderInput("top_rank_explorer", label = "Top Rank:", min = 1, max = 600, value = 25)
        ),
        dataTableOutput("dt_rank_age")
      ),
      tabItem(tabName = "comparator",
        fluidRow(
          box(title = "Context", width = 6, height = 250,
              HTML("The <b>Comparator Page</b> allows you to select a player and compare him with today's top ranked players, when they were his age."),
              br(),
              "You can also click on some current top players to compare their weekly rank throughout their career with that of the selected player."
          ),
          box(title = "Player name", width = 6, height = 250,
              selectizeInput("player_name_comparator", label = "", choices = unique(data_ranking$full_name), selected = "Roger Federer"),
              textOutput("age_player_name"),
              textOutput("rank_player_name"),
              br(),
              sliderInput("top_rank_comparator", label = "Actual Top Ranking:", min = 1, max = 600, value = 25)
          )
        ),
        br(),
        h3("Comparison with actual leaders"),
        fluidRow(
          dataTableOutput("dt_actual_top")
        ),
        br(),
        h3("Comparison with actual leaders"),
        fluidRow(
          plotlyOutput('prog_plot', height = "900px") 
        )
      )
    )
  )
  
)
