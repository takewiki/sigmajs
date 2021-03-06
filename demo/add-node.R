library(shiny)
library(sigmajs)

ui <- fluidPage(
	fluidRow(
		column(3, actionButton("add", "add node")),
		column(3, actionButton("stop", "stop forceAtlas2")),
		column(3, actionButton("start", "start forceAtlas2")),
		column(3, actionButton("restart", "re-start forceAtlas2"))
	),
	sigmajsOutput("sg", height = "100vh")
)

server <- function(input, output) {
	ids <- as.character(1:10)

	nodes <- data.frame(
		id = ids,
		label = LETTERS[1:10],
		size = runif(10, 1, 5),
		stringsAsFactors = FALSE
	)

	edges <- data.frame(
		id = 1:15,
		source = sample(ids, 15, replace = TRUE),
		target = sample(ids, 15, replace = TRUE),
		stringsAsFactors = FALSE
	)

	output$sg <- renderSigmajs({
		sigmajs() %>%
			sg_nodes(nodes, id, label, size) %>%
			sg_edges(edges, id, source, target) %>%
			sg_settings(
				defaultNodeColor = "#0011ff"
			)
	})

	i <- nrow(nodes)

	observeEvent(input$add, {
	i <<- i + 1

		df <- data.frame(
			id = i,
			size = runif(1, 1, 5),
			label = sample(LETTERS, 1)
		)

		sigmajsProxy("sg") %>%
			sg_add_node_p(df, id, label, size)
	})

	observeEvent(input$start, {
		sigmajsProxy("sg") %>%
				sg_force_start_p(worker = TRUE)
	})

	observeEvent(input$stop, {
		sigmajsProxy("sg") %>%
				sg_force_stop_p()
	})

	observeEvent(input$restart, {
		sigmajsProxy("sg") %>%
					sg_force_restart_p(worker = TRUE)
	})
}

shinyApp(ui, server)
