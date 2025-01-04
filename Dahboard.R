
# Carregar pacotes necessários
library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(dplyr)

# Dados fornecidos (continuamos com os mesmos dados de exemplo)
dados <- data.frame(
  ID = 1:15,
  ENTREVISTADO = c("Fernando", "Lauriany", "Cristiany", "Diego Lisboa", "Debora Quintero",
                   "Lucas Rocha", "Daniel Rocha", "Kleber Salim", "Mara Oliveira", "Roselia Amorim",
                   "David Castro", "Cristovão da Mota", "João Melo", "Rosangela Sousa", "Thiago Barbosa"),
  P1 = c("Muito Grave", "Não é Grave", "Muito Grave", "Grave", "Grave", "Grave", "Grave", "Muito Grave", "Grave", "Grave", 
         "Moderado", "Moderado", "Muito Grave", "Grave", "Grave"),
  P2 = c("Mudanças Climáticas", "Falta de Planejamento Governamental", "Desperdício de Àgua", "Desperdício de Àgua", 
         "Tempo Excessivo no Banho", "Tempo Excessivo no Banho", "Tempo Excessivo no Banho", "Desperdício de Àgua", 
         "Desperdício de Àgua", "Desperdício de Àgua", "Mudanças Climáticas", "Mudanças Climáticas", "Desperdício de Àgua", 
         "Mudanças Climáticas", "Mudanças Climáticas"),
  P3 = c("Desmatamento/Falta Chuva", "Interrupções no Fornecimento de Água", "Plantas ou Áreas Verdes Secas", 
         "Reservatórios Secos", "Desmatamento", "Interrupções no Fornecimento de Água", "Interrupções no Fornecimento de Água", 
         "Interrupções no Fornecimento de Água", "Plantas ou Áreas Verdes Secas", "Plantas ou Áreas Verdes Secas", 
         "Desmatamento/Falta Chuva", "Desmatamento/Falta Chuva", "Interrupções no Fornecimento de Água", 
         "Interrupções no Fornecimento de Água", "Interrupções no Fornecimento de Água"),
  P4 = c("Preocupado(a)", "Preocupado(a)", "Preocupado(a)", "Motivado(a) p/ Agir", "Motivado(a) p/ Agir", "Preocupado(a)", 
         "Preocupado(a)", "Motivado(a) p/ Agir", "Muito Preocupado", "Muito Preocupado", "Ansioso(a)", "Ansioso(a)", 
         "Preocupado(a)", "Motivado(a) p/ Agir", "Motivado(a) p/ Agir"),
  P5 = c("Sim", "Não", "Sim", "Sim", "Sim", "Não", "Não", "Sim", "Sim", "Sim", "Não", "Não", "Sim", "Sim", "Sim"),
  P6 = c("Não Sei", "Não", "Não", "Não", "Sim", "Não", "Não", "Não Sei", "Não Sei", "Não Sei", "Não Sei", "Não Sei", 
         "Não", "Não", "Não")
)

# UI: Definir a interface do usuário
ui <- dashboardPage(skin = "green",
                    dashboardHeader(title = "Projeto Escassez Água",
                                    titleWidth = 300
                    ),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("EQUIPE", tabName = "equipe", icon = icon("group")),
                        menuItem("SENSIBILIZAÇÃO", tabName = "sensibilizacao", icon = icon("video")),
                        menuItem("PROJETO", tabName = "projeto", icon = icon("project-diagram")),
                        menuItem("ANALISE EXPLORATÓRIA", tabName = "resultados", icon = icon("bar-chart")),
                        menuItem("ATITUDES", tabName = "atitudes", icon = icon("video"))
                      )
                    ),
                    dashboardBody(
                      tabItems(
                        tabItem(
                          tabName = "resultados",
                          fluidRow(
                            box(title = "Análise Visual - Questionário", status = "success", solidHeader = TRUE, width = 12,
                                tabsetPanel(
                                  tabPanel("Percepção do Problema", plotlyOutput("grafico_percepcao")),
                                  tabPanel("Causas da Escassez de Água", plotlyOutput("grafico_causas")),
                                  tabPanel("Sinais Visíveis da Escassez de Água", plotlyOutput("grafico_sinais")),
                                  tabPanel("Sentimentos sobre o Problema", plotlyOutput("grafico_sentimentos")),  # Novo gráfico
                                  tabPanel("Observação do Problema no Dia a Dia", plotlyOutput("grafico_observacao")),  # Novo gráfico
                                  tabPanel("Campanhas", plotlyOutput("grafico_campanhas"))  # Novo gráfico
                                )
                            )
                          )
                        ),
                        tabItem(
                          tabName = "projeto",
                          fluidRow(
                            box(
                              title = "PROJETO", status = "success", solidHeader = TRUE, width = 12,
                              tabsetPanel(
                                tabPanel("Problema",
                                         fluidRow(
                                           column(6, 
                                                  p(strong("")),
                                                  p("O Desperdício de água em residências é uma questão preocupante, gerada por diversos fatores, como:"),
                                                  tags$ul(
                                                    tags$li("Consumo excessivo, frequentemente causado pela falta de monitoramento eficiente."),
                                                    tags$li("Vazamentos não detectados, que resultam em perdas significativas ao longo do tempo."),
                                                    tags$li("Falta de conscientização sobre os impactos ambientais e financeiros desse desperdício.")
                                                  ),
                                                  p("Além disso, muitas famílias não possuem ferramentas adequadas para acompanhar o consumo em tempo real, dificultando a identificação de oportunidades para reduzir o desperdício e adotar práticas mais sustentáveis.")
                                           ),
                                           column(3,  # Coluna da primeira imagem
                                                  tags$img(src = "disperdicio1.jpg", 
                                                           controls = "controls",
                                                           width = 270, 
                                                           height = 250)  
                                           ),
                                           column(3,  # Coluna da segunda imagem
                                                  tags$img(src = "disperdicio2.jpg", 
                                                           controls = "controls",
                                                           width = 270, 
                                                           height = 250)  # Ajustando altura fixa
                                           )
                                         )
                                ),
                                tabPanel("Contexto",
                                         fluidRow(
                                           column(6,
                                                  p(strong("")),
                                                  p("Local: Residências em geral, abrangendo tanto áreas urbanas quanto rurais."),
                                                  p("Características:"),
                                                  tags$ul(
                                                    tags$li("Áreas urbanas: O custo elevado da água muitas vezes incentiva a busca por soluções mais econômicas e eficientes."),
                                                    tags$li("Áreas rurais: A disponibilidade limitada de água torna o uso racional ainda mais essencial para evitar escassez.")
                                                  ),
                                                  p(strong("Problema prático:")),
                                                  p("Famílias que dependem exclusivamente das contas mensais para monitorar o consumo de água enfrentam dificuldades para corrigir excessos de maneira imediata. Além disso, a ausência de sistemas simples e acessíveis para medir o consumo ou detectar vazamentos em tempo real agrava a situação."),
                                           ),
                                           
                                           column(3,  # Coluna da primeira imagem
                                                  tags$img(src = "disperdicio3.jpg", 
                                                           controls = "controls",
                                                           width = 270, 
                                                           height = 270)  
                                           ),
                                           column(3,  # Coluna da segunda imagem
                                                  tags$img(src = "disperdicio4.jpg", 
                                                           controls = "controls",
                                                           width = 270, 
                                                           height = 270)  # Ajustando altura fixa
                                           )
                                         )
                                ),
                                
                                
                                tabPanel("Público",
                                         p(strong("")),
                                         tags$ul(
                                           tags$li("Moradores de Residências: Famílias preocupadas com a sustentabilidade e a redução de custos."),
                                           tags$li("Proprietários que desejam identificar e evitar desperdícios em suas casas."),
                                           tags$li("Organizações e Educadores Ambientais: Grupos que promovem ações de conscientização ambiental e práticas sustentáveis."),
                                           tags$li("Faixa Etária e Perfil Socioeconômico: Adultos de 25 a 50 anos, geralmente chefes de família ou responsáveis pelas contas domésticas, famílias de classe média e alta.")
                                         )
                                ),
                                tabPanel("Anseios",
                                         p(strong("")),
                                         tags$ul(
                                           tags$li("Reduzir o desperdício de água: Evitar custos desnecessários e ajudar na preservação dos recursos naturais."),
                                           tags$li("Obter relatórios claros e práticos: Acompanhar o consumo em tempo real por meio de informações simples e de fácil interpretação."),
                                           tags$li("Receber alertas em tempo real: Detectar rapidamente situações anormais, como vazamentos ou consumo excessivo."),
                                           tags$li("Ter uma solução acessível e prática: Contar com um dispositivo fácil de instalar, usar e entender, independentemente do nível de conhecimento tecnológico."),
                                           tags$li("Contribuir para a sustentabilidade: Participar de um movimento de conscientização ambiental, promovendo práticas responsáveis no uso da água.")
                                         )
                                )
                              )
                            )
                          )
                        ),
                        tabItem(
                          tabName = "equipe",
                          fluidRow(
                            box(
                              title = "EQUIPE DE TRABALHO", status = "success", solidHeader = TRUE, width = 12,
                              p(strong("DOCENTE:")),
                              p("ORIENTADOR: Prof. Dra. Marianne Kogut Eliasquevici"),
                              br(),
                              p(strong("DISCENTES:")),
                              tags$ul(
                                tags$li("Andrey Cardoso Oliveira"),
                                tags$li("Andreya Cristina Bentes de Paiva"),
                                tags$li("Fellipe Machado Castro"),
                                tags$li("José Henrique da Silva"),
                                tags$li("Keanu Frota Sales"),
                                tags$li("Mario Dhiego Valente"),
                                tags$li("Ramon Henrique Pereira Neves")
                              )
                            )
                          )
                        ),
                        tabItem(
                          tabName = "sensibilizacao",
                          fluidRow(
                            box(
                              title = "SENSIBILIZAÇÃO SOBRE O DISPERDICÍO DE ÁGUA", 
                              status = "success", 
                              solidHeader = TRUE, 
                              width = 8,
                              tags$iframe(width = "100%", 
                                          height = 500, 
                                          src = "https://www.youtube.com/embed/nE1tnvMY-i0",
                                          frameborder = "0", 
                                          allowfullscreen = TRUE)
                            )
                          )
                        ),
                        tabItem(
                          tabName = "atitudes",
                          fluidRow(
                            box(
                              title = "ATITUDES PARA REDUZIR OU ECONOMIZAR ÁGUA", 
                              status = "success", 
                              solidHeader = TRUE, 
                              width = 8,
                              tags$iframe(width = "100%", 
                                          height = 500, 
                                          src = "https://www.youtube.com/embed/oVADyHI9GIg",
                                          frameborder = "0", 
                                          allowfullscreen = TRUE)
                            )
                          )
                        )
                      )
                    )
)

# Server: Definir a lógica para processar os dados
server <- function(input, output, session) {
  
  # Função para adicionar os percentuais dentro das barras (centralizados)
  adicionar_percentuais <- function(grafico, dados_count) {
    total_respostas <- sum(dados_count$n)
    grafico + 
      geom_text(
        aes(label = paste0(round(n / total_respostas * 100, 1), "%")), 
        position = position_stack(vjust = 0.5), 
        color = "black"
      )
  }
  
  # Gráfico da Percepção do Problema (P1)
  output$grafico_percepcao <- renderPlotly({
    percepcao_count <- dados %>%
      count(P1) %>%
      arrange(desc(n))
    
    grafico_percepcao <- ggplot(percepcao_count, aes(x = reorder(P1, -n), y = n)) +
      geom_bar(stat = "identity", fill = 'lightblue') +
      theme_minimal() +
      labs(title = "COMO VOCÊ AVALIA A GRAVIDADE DO PROBLEMA DA ESCASSEZ DE ÁGUA EM SUA REGIÃO?", 
           x = "Percepção", 
           y = "Contagem")
    
    grafico_percepcao <- adicionar_percentuais(grafico_percepcao, percepcao_count)
    
    ggplotly(grafico_percepcao)
  })
  
  # Gráfico das Causas (P2)
  output$grafico_causas <- renderPlotly({
    causas_count <- dados %>%
      count(P2) %>%
      arrange(desc(n))
    
    grafico_causas <- ggplot(causas_count, aes(x = reorder(P2, -n), y = n)) +
      geom_bar(stat = "identity", fill = 'lightgreen') +
      theme_minimal() +
      labs(title = "QUAIS AS PRINCIPAIS CAUSAS DA ESCASSEZ DE ÁGUA?", 
           x = "Causa", 
           y = "Contagem")
    
    grafico_causas <- adicionar_percentuais(grafico_causas, causas_count)
    
    ggplotly(grafico_causas)
  })
  
  # Gráfico dos Sinais Visíveis (P3)
  output$grafico_sinais <- renderPlotly({
    sinais_count <- dados %>%
      count(P3) %>%
      arrange(desc(n))
    
    grafico_sinais <- ggplot(sinais_count, aes(x = reorder(P3, -n), y = n)) +
      geom_bar(stat = "identity", fill = 'lightcoral') +
      theme_minimal() 
      labs(title = "QUAIS OS SINAIS RELACIONADOS A ESCASSEZ DE ÁGUA VOCÊ PERCEBE EM SUA REGIÃO?", 
      x = "Sinal", 
      y = "Contagem")
    
    grafico_sinais <- adicionar_percentuais(grafico_sinais, sinais_count)
    
    ggplotly(grafico_sinais)
  })
  
  # Gráfico do Sentimento sobre o Problema (P4)
  output$grafico_sentimentos <- renderPlotly({
    sentimentos_count <- dados %>%
      count(P4) %>%
      arrange(desc(n))
    
    grafico_sentimentos <- ggplot(sentimentos_count, aes(x = reorder(P4, -n), y = n)) +
      geom_bar(stat = "identity", fill = 'lightblue') +
      theme_minimal() +
      labs(title = "COMO VOCÊ SE SENTE EM RELAÇÃO A ESCASSEZ DE ÁGUA?", 
           x = "Sentimento", 
           y = "Contagem")
    
    grafico_sentimentos <- adicionar_percentuais(grafico_sentimentos, sentimentos_count)
    
    ggplotly(grafico_sentimentos)
  })
  
  # Gráfico da Observação do Problema no Dia a Dia (P5)
  output$grafico_observacao <- renderPlotly({
    observacao_count <- dados %>%
      count(P5) %>%
      arrange(desc(n))
    
    grafico_observacao <- ggplot(observacao_count, aes(x = reorder(P5, -n), y = n)) +
      geom_bar(stat = "identity", fill = 'lightgreen') +
      theme_minimal() +
      labs(title = "VOCê PERCEBE SINAIS DE ESCASSEZ DE ÁGUA NA SUA ROTINA?", 
           x = "Observação", 
           y = "Contagem")
    
    grafico_observacao <- adicionar_percentuais(grafico_observacao, observacao_count)
    
    ggplotly(grafico_observacao)
  })
  
  # Gráfico das Campanhas (P6)
  output$grafico_campanhas <- renderPlotly({
    campanhas_count <- dados %>%
      count(P6) %>%
      arrange(desc(n))
    
    grafico_campanhas <- ggplot(campanhas_count, aes(x = reorder(P6, -n), y = n)) +
      geom_bar(stat = "identity", fill = 'lightpink') +
      theme_minimal() +
      labs(title = "EXISTEM AÇÕES/CAMPANHAS DE ECPONOMIA DE ÁGUA?", 
           x = "Resposta", 
           y = "Contagem")
    
    grafico_campanhas <- adicionar_percentuais(grafico_campanhas, campanhas_count)
    
    ggplotly(grafico_campanhas)
  })
}

# Run the application
shinyApp(ui, server)
