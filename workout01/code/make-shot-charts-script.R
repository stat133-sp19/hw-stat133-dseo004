###########################################################################
# title: Make-shot-charts-script
# description: Using the shots_data and basketball court background to draw 
#              the shot-charts corresponding to different players.
# input(s): 5 players' shots_data tables, 1 nba-court jpg file
# output(s): 6 shot-charts pdf files (5 players and 1 facetted), 
#            1 shot-charts png files (facetted)
########################################################################

library(dplyr)
library(ggplot2)
library(jpeg)
library(grid)

# court imate (to be used as background of plot)
court_file <- "../images/nba-court.jpg"

# create raste object
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc")
)

# shot charts of each player

curry_shot_chart <- ggplot(data = curry) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 Season)') +
  theme_minimal()

ggsave("../images/stephen-curry-shot-chart.pdf", 
       plot = curry_shot_chart, width = 6.5, height = 5)

thompson_shot_chart <- ggplot(data = thompson) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 Season)') +
  theme_minimal()

ggsave("../images/klay-thompson-shot-chart.pdf", 
       plot = thompson_shot_chart, width = 6.5, height = 5)

durant_shot_chart <- ggplot(data = durant) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 Season)') +
  theme_minimal()

ggsave("../images/kevin-durant-shot-chart.pdf", 
       plot = durant_shot_chart, width = 6.5, height = 5)

green_shot_chart <- ggplot(data = green) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 Season)') +
  theme_minimal()

ggsave("../images/draymond-green-shot-chart.pdf", 
       plot = green_shot_chart, width = 6.5, height = 5)

iguodala_shot_chart <- ggplot(data = iguodala) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 Season)') +
  theme_minimal()

ggsave("../images/andre-iguodala-shot-chart.pdf", 
       plot = iguodala_shot_chart, width = 6.5, height = 5)

# facetted shot chart
gsw_shot_charts <- ggplot(data = shots_data, aes(x = x, y = y, color = shot_made_flag))+ 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point() +
  ylim(-50, 420) + 
  facet_wrap(.~ name, ncol = 3) + 
  ggtitle('Shot Chart: GSW (2016 Season)') +
  theme_minimal()

ggsave("../images/gsw-shot-charts.pdf", 
       plot = gsw_shot_charts, width = 8, height = 7)
ggsave("../images/gsw-shot-charts.png", 
       plot = gsw_shot_charts, width = 8, height = 7)