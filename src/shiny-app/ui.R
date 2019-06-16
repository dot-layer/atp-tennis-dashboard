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
          "This App is mainly aimed to search for new ATP players by age and rank.", 
          br(), 
          br(),
          HTML("The <b>Explorer Page</b> allows to look for players that reached a certain top ranking before a given age."),
          br(),
          br(),
          HTML("This App is for non-commcercial usage and used data from <a href='https://github.com/JeffSackmann/tennis_atp'>Jeff Sackmann GitHub repository</a>.")
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
              HTML("This <b>Comparator Page</b> allows to compare the actual top ranking players at this age of a selected players."),
              br(),
              "You can also click on top actual players and compare their career rankings with your selected player."
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
