library(tidyverse)
# source data
data = readRDS("data.rds")
data_ghg = readRDS('data_ghg.rds')


# GGPlot Plotting function 
#linechart
plot_linechart = function(data, data_x, data_y, xlabel, ylabel, line_colour, caption) {
  data %>%
    ggplot(aes(x = data_x, y = data_y, colour = line_colour)) +
    geom_line(size = 1) + 
    labs(
      # title = title, 
      # subtitle = ifelse(missing(subtitle), '', subtitle),
      caption = ifelse(missing(caption), '', caption),
      color = "Country"
    ) +
    xlab(xlabel) + ylab(ylabel) +
    theme(
      #plot.title = element_text(family = "Fira Sans Condensed"),
      plot.background = element_rect(colour = NA, fill = '#282C33'),
      panel.background = element_rect(colour = NA, fill = '#282C33'),
      panel.grid.major = element_line(colour="#3c4046"),
      panel.grid.minor = element_line(colour="#303338"),
      axis.title = element_text(face = "bold", size = rel(1), colour = '#e6e1e1'),
      axis.text = element_text(face = "bold", size = rel(1), colour = '#e6e1e1'),
      axis.ticks = element_blank(),
      plot.title = element_blank(),
      plot.caption = element_text(colour = '#e6e1e1', family = "Fira Sans Condensed"),
      # legend modification
      legend.background = element_blank(),
      # legend.background = element_rect(colour = NA, fill = "#282C33"),
      legend.key = element_rect(colour = "#282C33", fill = NA),
      legend.title = element_text(
        face = "bold",
        size = rel(1),
        colour = "#E6E1E1"),
      legend.text = element_text(
        face = "bold",
        size = rel(1),
        colour = "#E6E1E1")
    ) 
}





# areachart
plot_areachart = function(data, data_x, data_y, xlabel, ylabel, fill_colour, caption){
  data %>% 
    ggplot(aes(x = data_x, y = data_y, fill = fill_colour)) +
      geom_area(alpha = 0.4) +
      labs(
        # title = title, 
        # subtitle = ifelse(missing(subtitle), '', subtitle),
        caption = ifelse(missing(caption), '', caption),
        color = "Country"
      ) +
      xlab(xlabel) + ylab(ylabel) +
      theme(
        #plot.title = element_text(family = "Fira Sans Condensed"),
        plot.background = element_rect(colour = NA, fill = '#282C33'),
        panel.background = element_rect(colour = NA, fill = '#282C33'),
        panel.grid.major = element_line(colour="#3c4046"),
        panel.grid.minor = element_line(colour="#303338"),
        axis.title = element_text(face = "bold", size = rel(1), colour = '#e6e1e1'),
        axis.text = element_text(face = "bold", size = rel(1), colour = '#e6e1e1'),
        axis.ticks = element_blank(),
        plot.title = element_blank(),
        plot.caption = element_text(colour = '#e6e1e1', family = "Fira Sans Condensed"),
        # legend modification
        legend.background = element_blank(),
        # legend.background = element_rect(colour = NA, fill = "#282C33"),
        legend.key = element_rect(colour = "#282C33", fill = NA),
        legend.title = element_text(
          face = "bold",
          size = rel(1),
          colour = "#E6E1E1"),
        legend.text = element_text(
          face = "bold",
          size = rel(1),
          colour = "#E6E1E1")
      ) 
}


# bar plot


plot_barchart = function(data, data_x, data_y, Country, xlabel, ylabel,title, subtitle, caption) {

  ggplot(data, aes(x = data_x, y = data_y, fill = Country)) +
    geom_bar(stat = "identity", position = 'dodge') +
    coord_flip() +
    labs(
      subtitle = ifelse(missing(subtitle), '', subtitle),
      caption = ifelse(missing(caption), '', caption),
      color = "Country"
    ) +
    xlab(xlabel) + ylab(ylabel) +
    theme(
      #plot.title = element_text(family = "Fira Sans Condensed"),
      plot.background = element_rect(colour = NA, fill = '#282C33'),
      panel.background = element_rect(colour = NA, fill = '#282C33'),
      panel.grid.major = element_line(colour="#3c4046"),
      panel.grid.minor = element_line(colour="#303338"),
      axis.title = element_text(face = "bold", size = rel(1), colour = '#e6e1e1'),
      axis.text = element_text(face = "bold", size = rel(1), colour = '#e6e1e1'),
      axis.ticks = element_blank(),
      plot.title = element_blank(),
      plot.caption = element_text(colour = '#e6e1e1', family = "Fira Sans Condensed"),
      # legend modification
      legend.background = element_blank(),
      # legend.background = element_rect(colour = NA, fill = "#282C33"),
      legend.key = element_rect(colour = "#282C33", fill = NA),
      legend.title = element_text(
        face = "bold",
        size = rel(1),
        colour = "#E6E1E1"),
      legend.text = element_text(
        face = "bold",
        size = rel(1),
        colour = "#E6E1E1")
    ) 
  
  
}


