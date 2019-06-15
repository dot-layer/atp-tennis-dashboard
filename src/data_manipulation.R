library(data.table)
library(lubridate)

# Get player infos and keep only those with a valid birthdate
players_id <- fread('data/atp_players.csv')
players_id <- players_id[!is.na(birthdate)]
players_id[, birthdate:=ymd(birthdate)]

# Get ranking data and keep only non-NA entries
data_ranking <- rbindlist(lapply(list.files(
  path = "data",
  pattern = "atp_rankings_*",
  full.names = TRUE
), fread))
data_ranking <- data_ranking[!is.na(points)]
data_ranking[, ranking_date:=ymd(ranking_date)]

# Merge player infos on ranking data
setkey(players_id, player_id)
setkey(data_ranking, player)
cols <- setdiff(colnames(players_id), "player_id")
data_ranking[players_id, (cols):=mget(cols)]
data_ranking <- data_ranking[!is.na(birthdate)]
rm(cols, players_id)

# Calculate player age as of ranking date
data_ranking[, age:=interval(birthdate, ranking_date)/years(1)]

# Clean data
data_ranking <- data_ranking[age>10]

RANK = 10
AGE = 20

data_ranking_filter <- data_ranking[data_ranking$age <= AGE & data_ranking$rank <= RANK]

