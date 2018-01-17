## Datasetup
library(igraphdata)
library(igraph)
library(tidyverse)
library(ggraph)
data(karate)
my_graph <- karate
my_v_colors <- c("#7570b3", "#1b9e77")
vertices_colours_labels <- list("dog" = "#7570b3", "cat" = "#1b9e77")
edges_colours_labels <- list("strong" = "#c7e9b4", "average" = "#fdb863", "weak" = "#8073ac")
my_e_colors <- c("#c7e9b4", "#fdb863", "#8073ac")
E(my_graph)$color <- sample(names(edges_colours_labels), ecount(karate), replace = TRUE)
V(my_graph)$color <- plyr::mapvalues(V(my_graph)$color,
                                     from = c(1,2),
                                     to = names(vertices_colours_labels))
## Now let's visualise the graph!

ggraph(my_graph, layout = 'drl') +
  geom_node_point(aes(colour = fct_relevel(color, names(vertices_colours_labels))), show.legend = TRUE) +
  scale_colour_manual(
    values = as.character(vertices_colours_labels)
  ) +
  geom_edge_fan(aes(colour = fct_relevel(color, names(edges_colours_labels))), show.legend = TRUE) +
  scale_edge_colour_manual(
    values = as.character(edges_colours_labels)
  )