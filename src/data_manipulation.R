library(data.table)
library(eeptools)
library(tidyverse)


player_id <- fread('../data/atp_players.csv')
player_id <- na.omit(player_id, cols='birthdate')

player_current_ranking <- fread('../data/atp_rankings_current.csv')
player_10s_ranking <- fread('../data/atp_rankings_10s.csv')
player_00s_ranking <- fread('../data/atp_rankings_00s.csv')

player_since_00s_ranking <-  rbindlist(list(player_current_ranking, player_10s_ranking, player_00s_ranking))
data_ranking <-  merge(player_since_00s_ranking, player_id, by.x='player', by.y='player_id')

data_ranking <- transform(data_ranking, birthdate = as.Date(as.character(birthdate), "%Y%m%d"))
data_ranking <- transform(data_ranking, ranking_date = as.Date(as.character(ranking_date), "%Y%m%d"))
data_ranking <- transform(data_ranking, age = age_calc(birthdate, ranking_date, "years"))

RANK = 10
AGE = 20

data_ranking_filter <- data_ranking[data_ranking$age <= AGE & data_ranking$rank <= RANK]

