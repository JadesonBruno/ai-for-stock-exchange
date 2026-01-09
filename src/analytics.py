# Specialized Consulting Module in the field of data using AI Agents.
# Practical consulting project in the field of data using AI Agents.
# App Deployment for Day Trade Analytics in real time using Ai Agents,
# Groq, Deepseek and AWS for monetization.

# Analytics Module

# import third-party libraries
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
import yfinance as yf


def extract_data(ticker: str, period: str = "6mo") -> pd.DataFrame:
    """
    Define the function to extract historical stock data based on the given ticker
    and period.

    Parameters:
        ticker (str): The stock ticker symbol.
        period (str): The period for which to fetch historical data. Default is '6mo'.

    Returns:
        pd.DataFrame: DataFrame containing historical stock data.
    """

    # Fetch historical stock data
    stock = yf.Ticker(ticker)

    # Get historical data for the specified period
    hist = stock.history(period=period)
    # Reset index to convert the Date index into a column
    hist.reset_index(inplace=True)

    return hist


def plot_stock_data(hist: pd.DataFrame, ticker: str) -> None:
    """
    Plot the historical stock data using Plotly.

    Parameters:
        hist (pd.DataFrame): The historical stock data.
        ticker (str): The stock ticker symbol.
    """

    fig = px.line(
        hist,
        x="Date",
        y="Close",
        title=f"{ticker} - Stock Price in the Last 6 Months",
        markers=True,
    )

    return fig


def plot_candlestick(hist: pd.DataFrame, ticker: str) -> None:
    """
    Plot the candlestick chart for the historical stock data using Plotly.

    Parameters:
        hist (pd.DataFrame): The historical stock data.
        ticker (str): The stock ticker symbol.
    """

    fig = go.Figure(
        data=[
            go.Candlestick(
                x=hist["Date"],  # Define x-axis as Date
                open=hist["Open"],  # Define open prices
                high=hist["High"],  # Define high prices
                low=hist["Low"],  # Define low prices
                close=hist["Close"],  # Define close prices
            )
        ],
        layout=go.Layout(title=f"{ticker} - Candlestick Chart in the Last 6 Months"),
    )

    return fig


def plot_moving_averages(hist: pd.DataFrame, ticker: str) -> None:
    """
    Plot the stock data along with its 20-day moving average using Plotly.

    Parameters:
        hist (pd.DataFrame): The historical stock data.
        ticker (str): The stock ticker symbol.
    """

    # Calculate the 20-day simple moving average and add it as a new column
    hist["SMA_20"] = hist["Close"].rolling(window=20).mean()

    # Calculate the 20-day exponential moving average and add it as a new column
    hist["EMA_20"] = hist["Close"].ewm(span=20, adjust=False).mean()

    fig = px.line(
        hist,
        x="Date",
        y=["Close", "SMA_20", "EMA_20"],
        title=f"{ticker} - Stock Price with 20-Day Moving Averages",
        labels={"value": "Price (USD)", "Date": "Date", "variable": "variable"},
    )

    return fig


def plot_volume(hist: pd.DataFrame, ticker: str) -> None:
    """
    Plot the trading volume of the stock using Plotly.

    Parameters:
        hist (pd.DataFrame): The historical stock data.
        ticker (str): The stock ticker symbol.
    """

    fig = px.bar(
        hist,
        x="Date",
        y="Volume",
        title=f"{ticker} - Trading Volume in the Last 6 Months",
        labels={"Volume": "Volume", "Date": "Date"},
    )

    return fig
