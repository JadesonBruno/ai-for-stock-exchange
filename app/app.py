# Specialized Consulting Module in the field of data using AI Agents.
# Practical consulting project in the field of data using AI Agents.
# App Deployment for Day Trade Analytics in real time using Ai Agents,
# Groq, Deepseek and AWS for monetization.


# App Web

# Importing standard libraries
import os
import re
import sys

# Adjusting system path to include the src directory
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

# Importing third-party libraries
import streamlit as st

# Importing internal modules
from src.ai_agent import multi_ai_agent
from src.analytics import (
    extract_data,
    plot_candlestick,
    plot_moving_averages,
    plot_stock_data,
    plot_volume,
)

# Setting page configuration
st.set_page_config(page_title="IA para Bolsa de Valores", page_icon="📈", layout="wide")

# Sidebar with usage guide
st.sidebar.title("📝 Guia de Uso!")
st.sidebar.markdown(
    """
    ### Objetivo

    Este aplicativo permite que você obtenha análise em tempo real com visualizações
    e insights gerados por IA para uma ação na bolsa de valores.

    ### Como usar:

    1. Insira o símbolo da ação (ticker) no campo fornecido.
    2. Clique no botão **Analisar** para obter a análise.

    ### Exemplo de Tickers Válidos:
    - AAPL (Apple Inc.)
    - MSFT (Microsoft Corporation)
    - GOOGL (Alphabet Inc.)
    - AMZN (Amazon.com, Inc.)

    Mais tickers podem ser encontrados em
    [Stock Analysis](https://stockanalysis.com/list/nasdaq-stocks/).
    """
)

# Support Toggle Button
if "support_open" not in st.session_state:
    st.session_state["support_open"] = False


def toggle_support() -> None:
    """Toggle the support section visibility."""

    st.session_state["support_open"] = not st.session_state["support_open"]


st.sidebar.button("Suporte", on_click=toggle_support)

if st.session_state["support_open"]:
    st.sidebar.write(
        """
        No caso de dúvidas envie um email para:
        jadesonbruno.a@outlook.com
        """
    )


# Main Application Title
st.title("📈 IA para Bolsa de Valores")

# Main Header
st.header("🤖 Day trade analytics em tempo real com IA")

# Input for Stock Ticker
ticker = (
    st.text_input(
        label="Insira o símbolo da ação (ticker):", placeholder="Ex: AAPL", width=800
    )
    .upper()
    .strip()
)

# Analyze Button
if st.button("Analisar"):

    # If ticker is provided
    if ticker:
        # Display loading spinner during analysis
        with st.spinner("Analisando... Por favor, aguarde."):

            # Get historical stock data
            hist = extract_data(ticker)

            # Display analysis header
            st.subheader("🧠 Análise gerada por IA")

            # Get AI-generated response
            ai_response = multi_ai_agent.run(
                input=f"Summarize the analysts' recommendations and share the latest \
                    news about {ticker}."
            )

            # Clean AI response using regex
            clean_response = re.sub(
                pattern=r"(Running:[\s\S]*?\n\n) | \
                    (^transfer_task_to_finance_ai_agent.*\n?)",
                repl="",
                string=ai_response.content,
                flags=re.MULTILINE,
            ).strip()

            # Display AI response
            st.markdown(clean_response)

            # Display historical data visualizations
            st.subheader(f"📊 Visualização dos dados históricos de {ticker}")
            st.plotly_chart(plot_stock_data(hist, ticker))
            st.plotly_chart(plot_candlestick(hist, ticker))
            st.plotly_chart(plot_moving_averages(hist, ticker))
            st.plotly_chart(plot_volume(hist, ticker))
