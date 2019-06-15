# define the user interface

ui <- dashboardPage(
  
  dashboardHeader(title = "ATP AgeRank Comparison"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem(text = "Player Explorer", tabName = "explorer"),
      menuItem(text = "Player Comparator", tabName = "comparator")
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "explorer",
        box(title = "Informations", width = 6,
          numericInput("age", label = "Age:", step = 1, min = 0, max = 100, value = 18),
          sliderInput("top_rank", label = "Top Rank:", min = 1, max = 600, value = 50)
        ),
        renderDataTable("dt_rank_age")
      ),
      tabItem(tabName = "comparator"
      )
    )
  )
  
)
