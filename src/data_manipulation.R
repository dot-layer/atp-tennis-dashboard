library(data.table)
library(lubridate)

players_id <- fread('data/atp_players.csv')
players_id <- players_id[!is.na(birthdate)]
players_id[, birthdate:=ymd(birthdate)]

data_ranking <- rbindlist(lapply(list.files(
  path = "data",
  pattern = "atp_rankings_*",
  full.names = TRUE
), fread))
data_ranking <- data_ranking[!is.na(points)]
data_ranking[, ranking_date:=ymd(ranking_date)]

setkey(players_id, player_id)
setkey(data_ranking, player)
cols <- setdiff(colnames(players_id), "player_id")
data_ranking[players_id, (cols):=mget(cols)]
rm(cols, players_id)

data_ranking[, age:=interval(birthdate, ranking_date)/years(1)]

RANK = 10
AGE = 20

data_ranking_filter <- data_ranking[data_ranking$age <= AGE & data_ranking$rank <= RANK]

