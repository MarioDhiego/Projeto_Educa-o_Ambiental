
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
                    dashboardHeader(title = "Projeto Escassez de Água",
                                    titleWidth = 320,
                                    tags$li(class = "dropdown",style = "margin-right: 15px; display: inline-block;",  
                                            a(href = "https://www.facebook.com/computacaoufpa/", class = "fa fa-facebook fa-lg", target = "_blank", title = "Facebook", style = "color: #3b5998; transition: color 0.3s;"),
                                            tags$style(HTML(".fa-facebook:hover {color: #8b9dc3;}"))),
                                    tags$li(class = "dropdown",style = "margin-right: 15px; display: inline-block;", 
                                            a(href = "https://www.instagram.com/computacaoufpa/", class = "fa fa-instagram", target = "_blank", title = "InstaGram",style = "color: #e1306c; transition: color 0.3s;"),
                                            tags$style(HTML(".fa-instagram:hover {color: #fd1d1d;}"))),
                                    tags$li(class = "dropdown",style = "margin-right: 15px; display: inline-block;", 
                                            a(href = "https://github.com/MarioDhiego", icon("github"), "Suporte", target = "_blank", title = "Suporte",style = "color: #333; transition: color 0.3s;"),
                                            tags$style(HTML(".fa-github:hover {color: #6e6e6e;}")))
                    ),
                    dashboardSidebar(
                                     collapsed = FALSE,
                                     tags$img(src = "ufpa.jpg",
                                              width = 230,
                                              height = 130),
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
                                tabPanel("PROBLEMA",
                                         fluidRow(
                                           column(6, 
                                                  p(strong("")),
                                                  p(strong("O Desperdício de água em residências é uma questão preocupante, gerada por diversos fatores, como:")),
                                                  tags$ul(
                                                    tags$li(strong("Consumo excessivo, frequentemente causado pela falta de monitoramento eficiente.")),
                                                    tags$li(strong("Vazamentos não detectados, que resultam em perdas significativas ao longo do tempo.")),
                                                    tags$li(strong("Falta de conscientização sobre os impactos ambientais e financeiros desse desperdício."))
                                                  ),
                                                  p(strong("Além disso, muitas famílias não possuem ferramentas adequadas para acompanhar o consumo em tempo real, dificultando a identificação de oportunidades para reduzir o desperdício e adotar práticas mais sustentáveis."))
                                           ),
                                           column(3,  # Coluna da primeira imagem
                                                  tags$img(src = "disperdicio1.jpg", 
                                                           controls = "controls",
                                                           width = 280, 
                                                           height = 300)  
                                           ),
                                           column(3,  # Coluna da segunda imagem
                                                  tags$img(src = "disperdicio2.jpg", 
                                                           controls = "controls",
                                                           width = 280, 
                                                           height = 300)  # Ajustando altura fixa
                                           )
                                         )
                                ),
                                tabPanel("CONTEXTO",
                                         fluidRow(
                                           column(6,
                                                  p(strong("")),
                                                  p(strong("LOCAL: Residências em geral, abrangendo tanto áreas urbanas quanto rurais.")),
                                                  p(strong("Características:")),
                                                  tags$ul(
                                                    tags$li(strong("Áreas Urbanas: O custo elevado da água muitas vezes incentiva a busca por soluções mais econômicas e eficientes.")),
                                                    tags$br(),
                                                    tags$li(strong("Áreas Rurais: A disponibilidade limitada de água torna o uso racional ainda mais essencial para evitar escassez."))
                                                  ),
                                                  
                                                  p(strong("Problema Prático:")),
                                                  p(strong("Famílias que dependem exclusivamente das contas mensais para monitorar o consumo de água enfrentam dificuldades para corrigir excessos de maneira imediata. Além disso, a ausência de sistemas simples e acessíveis para medir o consumo ou detectar vazamentos em tempo real agrava a situação.")),
                                           ),
                                           
                                           column(3,  # Coluna da primeira imagem
                                                  tags$img(src = "disperdicio3.jpg", 
                                                           controls = "controls",
                                                           width = 280, 
                                                           height = 300)  
                                           ),
                                           column(3,  # Coluna da segunda imagem
                                                  tags$img(src = "disperdicio4.jpg", 
                                                           controls = "controls",
                                                           width = 280, 
                                                           height = 300)  # Ajustando altura fixa
                                           )
                                         )
                                ),
                                
                                
                                tabPanel("PÚBLICO ALVO",
                                         p(strong("")),
                                         tags$ul(
                                           tags$br(),
                                           tags$li(strong("Moradores de Residências: Famílias preocupadas com a sustentabilidade e a redução de custos.")),
                                           #tags$br(),
                                           tags$li(strong("Proprietários que desejam identificar e evitar desperdícios em suas casas.")),
                                           #tags$br(),
                                           tags$li(strong("Organizações e Educadores Ambientais: Grupos que promovem ações de conscientização ambiental e práticas sustentáveis.")),
                                           #tags$br(),
                                           tags$li(strong("Faixa Etária e Perfil Socioeconômico: Adultos de 25 a 50 anos, geralmente chefes de família ou responsáveis pelas contas domésticas, famílias de classe média e alta."))
                                         )
                                ),
                                tabPanel("ANSEIOS",
                                         p(strong("")),
                                         tags$ul(
                                           tags$br(),
                                           tags$li(strong("Reduzir o Desperdício de água: Evitar custos desnecessários e ajudar na preservação dos recursos naturais.")),
                                           #tags$br(),
                                           tags$li(strong("Obter Relatórios claros e práticos: Acompanhar o consumo em tempo real por meio de informações simples e de fácil interpretação.")),
                                           #tags$br(),
                                           tags$li(strong("Receber Alertas em tempo real: Detectar rapidamente situações anormais, como vazamentos ou consumo excessivo.")),
                                          # tags$br(),
                                           tags$li(strong("Ter uma Solução acessível e prática: Contar com um dispositivo fácil de instalar, usar e entender, independentemente do nível de conhecimento tecnológico.")),
                                           #tags$br(),
                                           tags$li(strong("Contribuir para a Sustentabilidade: Participar de um movimento de conscientização ambiental, promovendo práticas responsáveis no uso da água."))
                                         )
                                ),
                                
                                tabPanel("OBJETIVO",
                                         icon = icon("book"),
                                         fluidRow(
                                           column(
                                             width = 4,
                                             position = "center",
                                             tags$br(),
                                             h3("OBJETIVO GERAL", align = "center"),
                                             tags$br(),
                                             tags$p(
                                               style = "text-align:justify;font-si20pt",
                                               strong(
                                                 "Implantar o Projeto Sobre Desperdício de Água em Residências Familiares, na Região Metropolitana de Belém em 2025."
                                               )
                                             )
   
                                           ),
                                           column(
                                             width = 4,
                                             position = "center",
                                             tags$br(),
                                             h3("QUESTIONÁRIO", align = "center"),
                                             tags$br(),
                                             tags$p(
                                               style = "text-align:justify;font-si20pt",
                                               strong(
                                                 "Para a coleta dos dados foi utilizado um instrumento semiestruturado composto por 15 itens que versam sobre o Problema de Escassez de Àgua. A estrutura do questionário contém três subescalas, que medem características de Percepção, Sentimentos, Ações Pessoais e Preocupações sobre a temática."
                                               )
                                             )
                                           )
                                         )
                                ),
                                tabPanel("RECURSO COMPUTACIONAL",
                                         icon = icon("computer"),
                                         fluidRow(
                                           column(
                                             width = 4,
                                             position = "center",
                                             tags$br(),
                                             h3("SOFTWARE", align = "center"),
                                             tags$br(),
                                             solidHeader = TRUE,
                                             tags$br(),
                                             tags$p(
                                               style = "text-align: justify;font-si20pt",
                                               strong(
                                                 "Para Criação do Painel em Formato Web com Dasboard Interativos, foi Desenvolvido um script em Linguagem de Programação R-PROJECT Versão 4.4.1, no formato de Projeto de Software Livre de Código Aberto (open source), ou seja, pode ser utilizado sem custos de licença (R DEVELOPMENT CORE TEAM, 2024)"
                                               )
                                             ),
                                             tags$br(),
                                             tags$img(
                                               id = "foto2",
                                               src = "R.jpg",
                                               controls = "controls",
                                               width = 180, 
                                               height = 150
                                             ),
                                             tags$br(),
                                             tags$a("Software R",
                                                    href = "https://cran.r-project.org/bin/windows/base/R-4.3.2-win.exe"
                                             ),
                                             tags$br(),
                                           ),
                                           column(
                                             width = 4,
                                             position = "center", solidHeader = TRUE,
                                             tags$br(),
                                             tags$br(),
                                             tags$br(),
                                             tags$br(),
                                             tags$br(),
                                             tags$br(),
                                             tags$p(
                                               style = "text-align: justify;font-si20pt",
                                               strong("Foi utilizado um Ambiente de Desenvolvmento Integrado (IDE) Chamado Rstudio Versão 1.4.1.7, utilizando um Processo de Extração-Transformação-Carga(ETL) com uso de Várias bibliotecas (library), para o Ambiente Windows")
                                             ),
                                             tags$br(),
                                             tags$br(),
                                             tags$img(
                                               id = "foto3",
                                               src = "RStudio.png",
                                               controls = "controls",
                                               width = 190, 
                                               height = 170
                                             ),
                                             tags$br(),
                                             tags$a("RStudio",
                                                    href = "https://download1.rstudio.org/electron/windows/RStudio-2023.09.1-494.exe"
                                             ),
                                             tags$br(),
                                           )
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
                              title = "DISCIPLINA: EDUCAÇÃO AMBIENTAL", status = "success", solidHeader = TRUE, width = 12,
                              p(strong("DOCENTE:")),
                              p("ORIENTADOR: ", a("Prof. Dra. Marianne Kogut Eliasquevici", href = "https://ead.ufpa.br/user/profile.php?id=386")),
                              br(),
                              p(strong("DISCENTES:")),
                              tags$ul(
                              tags$li(a("Andrey Cardoso Oliveira", href = "https://github.com/andreydedey", target = "_blank")),
                                tags$li(a("Andreya Cristina Bentes de Paiva", href = "https://github.com/andreyabpaiva", target = "_blank")),
                                tags$li(a("Fellipe Machado Castro", href = "https://github.com/fellipecastro7", target = "_blank")),
                                tags$li(a("José Henrique da Silva", href = "https://github.com/Henriqueto/", target = "_blank")),
                                tags$li(a("Keanu Frota Sales", href = "https://github.com/keanusales", target = "_blank")),
                                tags$li(a("Mario Dhiego Rocha Valente", href = "https://github.com/MarioDhiego", target = "_blank")),
                                tags$li(a("Ramon Henrique Pereira Neves", href = "https://github.com/RamonHPN", target = "_blank"))
                              )
                            )
                          )
                        )
                        
                        
                        
                        
                        
                        ,
                        
                        tabItem(
                          tabName = "sensibilizacao",
                          fluidRow(
                            # Div para centralizar o box dentro do fluidRow
                            div(
                              style = "display: flex; justify-content: center; align-items: center; width: 100%;", 
                              box(
                                title = "SENSIBILIZAÇÃO SOBRE O DISPERDÍCIO DE ÁGUA", 
                                status = "success", 
                                solidHeader = TRUE, 
                                width = 12, 
                                div(style = "display: flex; justify-content: center; align-items: center;",
                                    tags$iframe(width = "70%", 
                                                height = 500, 
                                                src = "https://www.youtube.com/embed/nE1tnvMY-i0",
                                                frameborder = "0", 
                                                allowfullscreen = TRUE)
                                )
                              )
                            )
                          )
                        )
                        ,
                        tabItem(
                          tabName = "atitudes",
                          fluidRow(
                            # Div que envolve o box para centralização
                            div(
                              style = "display: flex; justify-content: center; align-items: center; width: 100%;", 
                              box(
                                title = "ATITUDES PARA REDUZIR OU ECONOMIZAR ÁGUA", 
                                status = "success", 
                                solidHeader = TRUE, 
                                width = 12, 
                                div(style = "display: flex; justify-content: center; align-items: center;",
                                    tags$iframe(width = "70%", 
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
